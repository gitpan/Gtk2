#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/pm/SimpleList.pm,v 1.14.4.1 2004/01/07 21:18:40 muppetman Exp $
#

#########################
package Gtk2::SimpleList;

use strict;
use Carp;
use Gtk2;

our @ISA = qw(Gtk2::TreeView);

our $VERSION = '0.14';

=cut

this version of simplelist is a simple list widget, which has a list-of-lists
data structure (under the key I<data>) which corresponds directly to the
items in the list.  as it is tied, it is always synchronized.

this is a very simple interface, giving you six column types:

  text
  int
  double
  bool
  scalar
  pixbuf

only bool is editable, and that's set up for you.

=cut

our %column_types = (
  'hidden' => {type=>'Glib::String',                                        attr=>'hidden'},
  'text'   => {type=>'Glib::String',  renderer=>'Gtk2::CellRendererText',   attr=>'text'},
  'int'    => {type=>'Glib::Int',     renderer=>'Gtk2::CellRendererText',   attr=>'text'},
  'double' => {type=>'Glib::Double',  renderer=>'Gtk2::CellRendererText',   attr=>'text'},
  'bool'   => {type=>'Glib::Boolean', renderer=>'Gtk2::CellRendererToggle', attr=>'active'},
  'scalar' => {type=>'Glib::Scalar',  renderer=>'Gtk2::CellRendererText',   
	  attr=> sub { 
  		my ($tree_column, $cell, $model, $iter, $i) = @_;
  		my ($info) = $model->get ($iter, $i);
  		$cell->set (text => $info || '' );
	  } },
  'pixbuf' => {type=>'Gtk2::Gdk::Pixbuf', renderer=>'Gtk2::CellRendererPixbuf', attr=>'pixbuf'},
);

# this is some cool shit
sub add_column_type
{
	shift;	# don't want/need classname
	my $name = shift;
	$column_types{$name} = { @_ };
}

sub text_cell_edited {
	my ($cell_renderer, $text_path, $new_text, $model) = @_;
	my $path = Gtk2::TreePath->new_from_string ($text_path);
	my $iter = $model->get_iter ($path);
	$model->set ($iter, $cell_renderer->{column}, $new_text);
}

sub new {
	croak "Usage: $_[0]\->new (title => type, ...)\n"
	    . " expecting a list of column title and type name pairs.\n"
	    . " can't create a SimpleList with no columns"
		unless @_ >= 3; # class, key1, val1
	return shift->new_from_treeview (Gtk2::TreeView->new (), @_);
}

sub new_from_treeview {
	my $class = shift;
	my $view = shift;
	croak "treeview is not a Gtk2::TreeView"
		unless defined ($view)
		   and UNIVERSAL::isa ($view, 'Gtk2::TreeView');
	croak "Usage: $class\->new_from_treeview (treeview, title => type, ...)\n"
	    . " expecting a treeview reference and list of column title and type name pairs.\n"
	    . " can't create a SimpleList with no columns"
		unless @_ >= 2; # key1, val1
	my @column_info = ();
	for (my $i = 0; $i < @_ ; $i+=2) {
		my $typekey = $_[$i+1];
		croak "expecting pairs of title=>type"
			unless $typekey;
		croak "unknown column type $typekey, use one of "
		    . join(", ", keys %column_types)
			unless exists $column_types{$typekey};
		my $type = $column_types{$typekey}{type};
		if (not defined $type) {
			$type = 'Glib::String';
			carp "column type $typekey has no type field; did you"
			   . " create a custom column type incorrectly?\n"
			   . "limping along with $type";
		}
		push @column_info, {
			title => $_[$i],
			type => $type,
			rtype => $column_types{$_[$i+1]}{renderer},
			attr => $column_types{$_[$i+1]}{attr},
		};
	}
	my $model = Gtk2::ListStore->new (map { $_->{type} } @column_info);
	# just in case, 'cause i'm paranoid like that.
	map { $view->remove_column ($_) } $view->get_columns;
	$view->set_model ($model);
	for (my $i = 0; $i < @column_info ; $i++) {
		if( 'CODE' eq ref $column_info[$i]{attr} )
		{
			$view->insert_column_with_data_func (-1,
				$column_info[$i]{title},
				$column_info[$i]{rtype}->new,
				$column_info[$i]{attr}, $i);
		}
		elsif ('hidden' eq $column_info[$i]{attr})
		{
			# skip hidden column
		}
		else
		{
			my $column = Gtk2::TreeViewColumn->new_with_attributes (
				$column_info[$i]{title},
				$column_info[$i]{rtype}->new,
				$column_info[$i]{attr} => $i,
			);
			$view->append_column ($column);
	
			if ($column_info[$i]{attr} eq 'active') {
				# make boolean columns respond to editing.
				my $r = $column->get_cell_renderers;
				$r->set (activatable => 1);
				$r->signal_connect (toggled => sub {
					my ($renderer, $row, $col) = @_;
					my $iter = $model->iter_nth_child (undef, $row);
					my $val = $model->get ($iter, $col);
					$model->set ($iter, $col, !$val);
					}, $i);

			} elsif ($column_info[$i]{attr} eq 'text') {
				# attach a decent 'edited' callback to any
				# columns using a text renderer.  we do NOT
				# turn on editing by default.
				my $r = $column->get_cell_renderers;
				$r->{column} = $i;
				$r->signal_connect (edited => \&text_cell_edited,
						    $model);
			}
		}
	}

	my @a;
	tie @a, 'Gtk2::SimpleList::TiedList', $model;

	$view->{data} = \@a;
	return bless $view, $class;
}

sub set_column_editable {
	my ($self, $index, $editable) = @_;
	my $column = $self->get_column ($index);
	croak "invalid column index $index"
		unless defined $column;
	my $cell_renderer = $column->get_cell_renderers;
	$cell_renderer->set (editable => $editable);
}

sub get_column_editable {
	my ($self, $index, $editable) = @_;
	my $column = $self->get_column ($index);
	croak "invalid column index $index"
		unless defined $column;
	my $cell_renderer = $column->get_cell_renderers;
	return $cell_renderer->get ('editable');
}

sub get_selected_indices {
	my $self = shift;
	my $selection = $self->get_selection;
	return () unless $selection;
	# warning: this assumes that the TreeModel is actually a ListStore.
	# if the model is a TreeStore, get_indices will return more than one
	# index, which tells you how to get all the way down into the tree,
	# but all the indices will be squashed into one array... so, ah,
	# don't use this for TreeStores!
	map { $_->get_indices } $selection->get_selected_rows;
}

sub select {
	my $self = shift;
	my $selection = $self->get_selection;
	my @inds = (@_ > 1 && $selection->get_mode ne 'multiple')
	         ? $_[0]
		 : @_;
	my $model = $self->get_model;
	foreach my $i (@inds) {
		my $iter = $model->iter_nth_child (undef, $i);
		next unless $iter;
		$selection->select_iter ($iter);
	}
}

sub unselect {
	my $self = shift;
	my $selection = $self->get_selection;
	my @inds = (@_ > 1 && $selection->get_mode ne 'multiple')
	         ? $_[0]
		 : @_;
	my $model = $self->get_model;
	foreach my $i (@inds) {
		my $iter = $model->iter_nth_child (undef, $i);
		next unless $iter;
		$selection->unselect_iter ($iter);
	}
}

sub set_data_array
{
	@{$_[0]->{data}} = @{$_[1]};
}

##################################
package Gtk2::SimpleList::TiedRow;

use strict;
use Gtk2;
use Carp;

=cut

TiedRow is the lowest-level tie, allowing you to treat a row as an array
of column data.

=cut

sub TIEARRAY {
	my $class = shift;
	my $model = shift;
	my $iter = shift;

	croak "usage tie (\@ary, 'class', model, iter)"
		unless $model && UNIVERSAL::isa ($model, 'Gtk2::TreeModel');

	return bless {
		model => $model,
		iter => $iter,
	}, $class;
}

sub FETCH {
	return $_[0]->{model}->get ($_[0]->{iter}, $_[1]);
}

sub STORE {
	return $_[0]->{model}->set ($_[0]->{iter}, $_[1], $_[2])
		if defined $_[2]; # allow 0, but not undef
}

sub FETCHSIZE {
	return $_[0]{model}->get_n_columns;
}

sub EXISTS { 
	return( $_[1] < $_[0]{model}->get_n_columns );
}

sub EXTEND { }
sub CLEAR { }

sub new {
	my ($class, $model, $iter) = @_;
	my @a;
	tie @a, __PACKAGE__, $model, $iter;
	return \@a;
}

sub POP { croak "pop called on a TiedRow, but you can't change its size"; }
sub PUSH { croak "push called on a TiedRow, but you can't change its size"; }
sub SHIFT { croak "shift called on a TiedRow, but you can't change its size"; }
sub UNSHIFT { croak "unshift called on a TiedRow, but you can't change its size"; }
sub SPLICE { croak "splice called on a TiedRow, but you can't change it's size"; }
sub DELETE { croak "delete called on a TiedRow, but you can't change it's size"; }
sub STORESIZE { carp "STORESIZE operation not supported"; }


###################################
package Gtk2::SimpleList::TiedList;

use strict;
use Gtk2;
use Carp;

=cut

TiedList is an array in which each element is a row in the liststore.

=cut

sub TIEARRAY {
	my $class = shift;
	my $model = shift;

	croak "usage tie (\@ary, 'class', model)"
		unless $model && UNIVERSAL::isa ($model, 'Gtk2::TreeModel');

	return bless {
		model => $model,
	}, $class;
}

sub FETCH {
	my $iter = $_[0]->{model}->iter_nth_child (undef, $_[1]);
	return undef unless defined $iter;
	my @row;
	tie @row, 'Gtk2::SimpleList::TiedRow', $_[0]->{model}, $iter;
	return \@row;
}

sub STORE {
	my $iter = $_[0]->{model}->iter_nth_child (undef, $_[1]);
	$iter = $_[0]->{model}->insert ($_[1])
		if not defined $iter;
	my @row;
	tie @row, 'Gtk2::SimpleList::TiedRow', $_[0]->{model}, $iter;
	if ('ARRAY' eq ref $_[2]) {
		@row = @{$_[2]};
	} else {
		$row[0] = $_[2];
	}
	return 1;
}

sub FETCHSIZE { 
	return $_[0]->{model}->iter_n_children (undef);
}

sub PUSH { 
	my $model = shift()->{model};
	my $iter;
	foreach (@_)
	{
		$iter = $model->append;
		my @row;
		tie @row, 'Gtk2::SimpleList::TiedRow', $model, $iter;
		if ('ARRAY' eq ref $_) {
			@row = @$_;
		} else {
			$row[0] = $_;
		}
	}
	return 1;
}

sub POP { 
	my $model = $_[0]->{model};
	my $index = $model->iter_n_children-1;
	$model->remove($model->iter_nth_child(undef, $index))
		if( $index >= 0 );
}

sub SHIFT { 
	my $model = $_[0]->{model};
	$model->remove($model->iter_nth_child(undef, 0))
		if( $model->iter_n_children );
}

sub UNSHIFT { 
	my $model = shift()->{model};
	my $iter;
	foreach (@_)
	{
		$iter = $model->prepend;
		my @row;
		tie @row, 'Gtk2::SimpleList::TiedRow', $model, $iter;
		if ('ARRAY' eq ref $_) {
			@row = @$_;
		} else {
			$row[0] = $_;
		}
	}
	return 1;
}

sub DELETE { 
	my $model = $_[0]->{model};
	$model->remove($model->iter_nth_child(undef, $_[1]))
		if( $_[1] < $model->iter_n_children );
}

sub CLEAR { 
	$_[0]->{model}->clear;
}

sub EXISTS { 
	return( $_[1] < $_[0]->{model}->iter_n_children );
}

# we can't really, reasonably, extend the tree store in one go, it will be 
# extend as items are added
sub EXTEND {}

sub get_model {
	return $_[0]{model};
}

sub STORESIZE { carp "STORESIZE: operation not supported"; }

sub SPLICE {
	if ($_[2] == 0 && 'ARRAY' eq ref($_[3])) {
		my $iter = $_[0]->{model}->insert($_[1]);
		my @row;
		tie @row, 'Gtk2::SimpleList::TiedRow', $_[0]->{model}, $iter;
		if ('ARRAY' eq ref $_[3]) {
			@row = @{$_[3]};
		} else {
			$row[0] = $_[3];
		}
		return 1;

	} else {
		carp "SPLICE: operation not fully supported";
	}
}

1;

__END__
# documentation is a good thing.

=head1 NAME

Gtk2::SimpleList - A simple interface to Gtk2's complex MVC list widget

=head1 SYNOPSIS

  use Gtk2 '-init';
  use Gtk2::SimpleList;

  use constant TRUE  => 1;
  use constant FALSE => 0;

  my $slist = Gtk2::SimpleList->new (
                'Text Field'    => 'text',
                'Int Field'     => 'int',
                'Double Field'  => 'double',
                'Bool Field'    => 'bool',
                'Scalar Field'  => 'scalar',
                'Pixbuf Field'  => 'pixbuf',
              );

  @{$slist->{data}} = (
          [ 'text', 1, 1.1,  TRUE, $var, $pixbuf ],
          [ 'text', 2, 2.2, FALSE, $var, $pixbuf ],
  );

  # (almost) anything you can do to an array you can do to 
  # $slist->{data} which is an array reference tied to the list model
  push @{$slist->{data}}, [ 'text', 3, 3.3, TRUE, $var, $pixbuf ];

  # mess with selections
  $slist->get_selection->set_mode ('multiple');
  $slist->get_selection->unselect_all;
  $slist->select (1, 3, 5..9); # select rows by index
  $slist->unselect (3, 8); # unselect rows by index
  @sel = $slist->get_selected_indices;

  # simple way to make text columns editable
  $slist->set_column_editable ($col_num, TRUE);

  # Gtk2::SimpleList is derived from Gtk2::TreeView
  $slist->set_rules_hint (TRUE);
  $slist->signal_connect (row_activated => \&row_clicked);

  # turn an existing TreeView into a SimpleList; useful for
  # Glade-generated interfaces.
  $simplelist = Gtk2::SimpleList->new_from_treeview (
                    $glade->get_widget ('treeview'),
                    'Text Field'    => 'text',
                    'Int Field'     => 'int',
                    'Double Field'  => 'double',
                 );

=head1 ABSTRACT

SimpleList is a simple interface to the powerful but complex Gtk2::TreeView
and Gtk2::ListStore combination, implementing using tied arrays to make
thing simple and easy.

=head1 DESCRIPTION

Gtk2 has a powerful, but complex MVC (Model, View, Controller) system used to
implement list and tree widgets.  Gtk2::SimpleList automates the complex setup
work and allows you to treat the list model as a more natural list of lists
structure.

After creating a new Gtk2::SimpleList object with the desired columns you may
set the list data with a simple Perl array assignment. Rows may be added or
deleted with the all of the normal array operations. Data may be accessed and
modified by treating the data member of the list object as an array reference.

A mechanism has also been put into place allowing columns to be Perl scalars.
The scalar is converted to text through Perl's normal mechanisms and then
displayed in the list. This same mechanism can be expanded by defining
arbitrary new column types before calling the new function. 

=head1 OBJECT HIERARCHY

 Glib::Object
 +--- Gtk2::Object
      +--- Gtk2::Widget
           +--- Gtk2::TreeView
	        +--- Gtk2::SimpleList

=head1 FUNCTIONS

=over

=item $slist = Gtk2::SimpleList->new (cname, ctype, [cname, ctype, ...])

Creates a new Gtk2::SimpleList object with the specified columns. The parameter
C<cname> is the name of the column, what will be displayed in the list headers if
they are turned on. The parameter ctype is the type of the column, one of:

 text    normal text strings
 int     integer values
 double  double-precision floating point values
 bool    boolean values, displayed as toggle-able checkboxes
 scalar  a perl scalar, displayed as a text string by default
 pixbuf  a Gtk2::Gdk::Pixbuf

or the name of a custom type you add with C<add_column_type>.
These should be provided in pairs according to the desired columns for you list.

=item $slist = Gtk2::SimpleList->new_from_treeview (treeview, cname, ctype, ...)

Like C<< Gtk2::SimpleList->new() >>, but turns an existing Gtk2::TreeView into
a Gtk2::SimpleList.  This is intended mostly for use with stuff like Glade,
where the widget is created for you.  This will create and attach a new model
and remove any existing columns from I<treeview>.  Returns I<treeview>,
re-blessed as a Gtk2::SimpleList.

=item $slist->set_data_array (arrayref)

Set the data in the list to the array reference arrayref. This is completely
equivalent to @{$list->{data}} = @{$arrayref} and is only here for convenience
and for those programmers who don't like to type-cast and have static, set once
data.

=item @indices = $slist->get_selected_indices

Return the indices of the selected rows in the ListStore.

=item $slist->select (index, ...);

=item $slist->unselect (index, ...);

Select or unselect rows in the list by index.  If the list is set for multiple
selection, all indices in the list will be set/unset; otherwise, just the
first is used.  If the list is set for no selection, then nothing happens.

To set the selection mode, or to select all or none of the rows, use the normal
TreeView/TreeSelection stuff, e.g.  $slist->get_selection and the TreeSelection
methods C<get_mode>, C<set_mode>, C<select_all>, and C<unselect_all>.

=item $slist->set_column_editable (index, editable)

=item boolean = $slist->get_column_editable (index)

This is a very simple interface to Gtk2::TreeView's editable text column cells.
All columns which use the attr "text" (basically, any text or number column,
see C<add_column_type>) automatically have callbacks installed to update data
when cells are edited.  With C<set_column_editable>, you can enable the
in-place editing.

C<get_column_editable> tells you if column I<index> is currently editable.

=item Gtk2::SimpleList->add_column_type (type_name, ...)

Add a new column type to the list of possible types. Initially six column types
are defined, text, int, double, bool, scalar, and pixbuf. The bool column type
uses a toggle cell renderer, the pixbuf uses a pixbuf cell renderer, and the
rest use text cell renderers. In the process of adding a new column type you
may use any cell renderer you wish. 

The first parameter is the column type name, the list of six are examples.
There are no restrictions on the names and you may even overwrite the existing
ones should you choose to do so. The remaining parameters are the type
definition consisting of key value pairs. There are three required: type,
renderer, and attr. The type key should be always be set to 'Glib::Scalar'. The
renderer key should hold the class name of the cell renderer to create for this
column type; this may be any of Gtk2::CellRendererText,
Gtk2::CellRendererToggle, Gtk2::CellRendererPixbuf, or some other, possibly
custom, cell renderer class.  The attr key is magical; it may be either a
string, in which case it specifies the attribute which will be set from the
specified column (e.g. 'text' for a text renderer, 'active' for a toggle
renderer, etc), or it may be a reference to a subroutine which will be called
each time the renderer needs to draw the data.

This function, described as a GtkTreeCellDataFunc in the API reference, 
will receive 5 parameters: $treecol, $cell, $model, $iter,
$col_num (when SimpleList hooks up the function, it sets the column number to
be passed as the user data).  The data value for the particular cell in question
is available via $model->get ($iter, $col_num); you can then do whatever it is
you have to do to render the cell the way you want.  Here are some examples:

  # just displays the value in a scalar as 
  # Perl would convert it to a string
  Gtk2::SimpleList->add_column_type( 'a_scalar', 
          type     => 'Glib::Scalar',
	  renderer => 'Text',
          attr     => sub {
               my ($treecol, $cell, $model, $iter, $col_num) = @_;
               my $info = $model->get ($iter, $i);
               $cell->set (text => $info);
	  }
     );

  # sums up the values in an array ref and displays 
  # that in a text renderer
  Gtk2::SimpleList->add_column_type( 'sum_of_array', 
          type     => 'Glib::Scalar',
	  renderer => 'Text',
          attr     => sub {
               my ($treecol, $cell, $model, $iter, $col_num) = @_;
               my $sum = 0;
               my $info = $model->get ($iter, $i);
               foreach (@$info)
               {
                   $sum += $_;
               }
               $cell->set (text => $sum);
          } 
     );

=back

=head1 MODIFYING LIST DATA

After creating a new Gtk2::SimpleList object there will be a member called C<data>
which is a tied array. That means data may be treated as an array, but in
reality the data resides in something else. There is no need to understand the
details of this it just means that you put data into, take data out of, and
modify it just like any other array. This includes using array operations like
push, pop, unshift, and shift. For those of you very familiar with perl this
section will prove redundant, but just in case:

  Adding and removing rows:
  
    # push a row onto the end of the list
    push @{$slist->{data}}, [col1_data, col2_data, ..., coln_data];
    # pop a row off of the end of the list
    $rowref = pop @{$slist->{data}};
    # unshift a row onto the beginning of the list
    unshift @{$slist->{data}}, [col1_data, col2_data, ..., coln_data];
    # shift a row off of the beginning of the list
    $rowref = shift @{$slist->{data}};
    # delete the row at index n, 0 indexed
    delete $slist->{data}[n];
    # set the entire list to be the data in a array
    @{$slist->{data}} = ( [row1, ...], [row2, ...], [row3, ...] );

  Getting at the data in the list:
  
    # get an array reference to the entire nth row
    $rowref = $slist->{data}[n];
    # get the scalar in the mth column of the nth row, 0 indexed
    $val = $slist->{data}[n][m];
    # set an array reference to the entire nth row
    $slist->{data}[n] = [col1_data, col2_data, ..., coln_data];
    # get the scalar in the mth column of the nth row, 0 indexed
    $slist->{data}[n][m] = $rowm_coln_value;

=head1 SEE ALSO

Perl(1), Glib(3pm), Gtk2(3pm).

=head1 AUTHORS

 muppet <scott at asofyet dot org>
 Ross McFarland <rwmcfa1 at neces dot com>
 Gavin Brown <gavin dot brown at uk dot com>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by the Gtk2-Perl team.

This library is free software; you can redistribute it and/or modify it under
the terms of the GNU Library General Public License as published by the Free
Software Foundation; either version 2.1 of the License, or (at your option) any
later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU Library General Public License for more
details.

You should have received a copy of the GNU Library General Public License along
with this library; if not, write to the Free Software Foundation, Inc., 59
Temple Place - Suite 330, Boston, MA  02111-1307  USA.

=cut
