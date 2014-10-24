#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/07.GtkBoxes.t,v 1.6 2003/11/29 17:20:46 rwmcfa1 Exp $
#

use strict;
use warnings;

#########################
# GtkBoxes Tests
# 	- rm
#########################

#########################

use Gtk2;
use Test::More;

if( Gtk2->init_check )
{
	plan tests => 68;
}
else
{
	plan skip_all =>
		'Gtk2->init_check failed, probably unable to open DISPLAY';
}

#########################

require './t/ignore_keyboard.pl';

ok( my $win = Gtk2::Window->new() );
$win->set_border_width(10);

ok( my $vbox = Gtk2::VBox->new(0,5) );
$win->add($vbox);

my ($r, $c);
for( $r = 0; $r < 3; $r++ )
{
	ok( my $hbox = Gtk2::HBox->new(0, 5), "created hbox for row $r" );
	$vbox->pack_start($hbox, 0, 0, 5);
	$hbox->set_name ("hbox $r");
	for( $c = 0; $c < 3; $c++ )
	{
		ok( my $label = Gtk2::Label->new("(r,c):($r,$c)"), 'created label' );
		$hbox->pack_start($label, 0, 0, 10);

		# make sure we are where we think we are
		is( $label->get_ancestor ('Gtk2::Box'), $hbox, 'ancestry' );
		is( $label->get_ancestor ('Gtk2::VBox'), $vbox, 'ancestry' );

		# interestingly, the second string returned from this
		# appears to be reversed, rather than the objects in
		# reverse order.  how handy.  that makes the second
		# one fairly useless, but let's verify that it's there.
		my ($path, $htap) = $label->path;
		ok( defined($htap), 'path returned two items' );
		ok( $path =~ /hbox $r/, "'hbox $r' is in the path" );
		##print "path $path\n";

		($path, $htap) = $label->class_path;
		ok( defined($htap), 'path returned two items' );
		ok( $path !~ /hbox $r/, "'hbox $r' is not in the class path" );
		##print "class path $path\n";
	}
}

$win->show_all;

Glib::Idle->add( sub {
		Gtk2->main_quit;
		0;
	} );

Gtk2->main;

1;

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list)

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
