#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/18.GtkNotebook.t,v 1.4 2003/09/22 00:04:24 rwmcfa1 Exp $
#

use strict;
use warnings;

#########################
# GtkNotbook Tests
# 	- rm
#########################

#########################

use Gtk2;
use Test::More;

if( Gtk2->init_check )
{
	plan tests => 58;
}
else
{
	plan skip_all =>
		'Gtk2->init_check failed, probably unable to open DISPLAY';
}

#########################

my $win = Gtk2::Window->new;

ok( my $nb = Gtk2::Notebook->new );
$win->add($nb);
ok(1);


$nb->prepend_page( Gtk2::Label->new('p1c'), Gtk2::Label->new('p1') );
ok(1);

$nb->append_page( Gtk2::Label->new('p2c'), Gtk2::Label->new('p2') );
ok(1);

my $child = Gtk2::Label->new('p1.5c');
$nb->insert_page( $child, Gtk2::Label->new('p1.5'), 1 );
ok(1);

$nb->prepend_page_menu( Gtk2::Label->new('Page 1c'), undef, Gtk2::Label->new('Page 1 pop') );
ok(1);

$nb->append_page_menu( Gtk2::Label->new('Page 6c'), Gtk2::Label->new('Page 6l'),
		Gtk2::Label->new('Page 6 pop') );
ok(1);

my $child2 = Gtk2::Label->new('Page 2c');
$nb->insert_page_menu($child2, Gtk2::Label->new('Page 2 pop'), undef, 1 );
ok(1);

$nb->insert_page( Gtk2::Label->new('remove'), Gtk2::Label->new('remove'), 7 );
$nb->insert_page( Gtk2::Label->new('remove'), Gtk2::Label->new('remove'), 7 );
$nb->insert_page( Gtk2::Label->new('remove'), Gtk2::Label->new('remove'), 0 );
$nb->remove_page(7);
ok(1);
$nb->remove_page(0);
ok(1);
$nb->remove_page(-1);
ok(1);

foreach (qw/left right bottom top/)
{
	$nb->set_tab_pos($_);
	ok(1);

	ok( $nb->get_tab_pos eq $_ );
}

$nb->set_show_tabs(0);
ok(1);
ok( ! $nb->get_show_tabs );

$nb->set_show_tabs(1);
ok(1);
ok( $nb->get_show_tabs );

$nb->set_show_border(0);
ok(1);
ok( ! $nb->get_show_border );

$nb->set_show_border(1);
ok(1);
ok( $nb->get_show_border );

$nb->set_scrollable(1);
ok(1);
ok( $nb->get_scrollable );

$nb->set_scrollable(0);
ok(1);

$nb->popup_disable;
ok(1);

$nb->popup_enable;
ok(1);
ok( ! $nb->get_scrollable );

# in reality this one is only in gtk2.2+, but it's been implemented in
# the xs wrapper since it's trivial anyway
ok( $nb->get_n_pages == 6 );

$nb->set_menu_label($child2, Gtk2::Label->new('re-set'));
ok(1);
ok( $nb->get_menu_label($child2)->get_text eq 're-set');

$nb->set_menu_label_text($child2, 're-set2');
ok(1);
ok( $nb->get_menu_label_text($child2) eq 're-set2');

$nb->set_tab_label($child, Gtk2::Label->new('re-set'));
ok(1);
ok( $nb->get_tab_label($child)->get_text eq 're-set' );

$nb->set_tab_label_text($child, 're-set2');
ok(1);
ok( $nb->get_tab_label_text($child) eq 're-set2' );

ok( $nb->get_nth_page(1)->get_text eq 'Page 2c' );

ok( eq_array( [ $nb->query_tab_label_packing($child) ],
	      [ undef, 1, 'start' ] ) );

$nb->set_tab_label_packing($child, 1, 0, 'end');
ok(1);
ok( eq_array( [ $nb->query_tab_label_packing($child) ],
	      [ 1, undef, 'end' ] ) );

Glib::Idle->add( sub
	{
		$nb->next_page;
		ok(1);
		$nb->prev_page;
		ok(1);
		ok( (my $index = $nb->page_num($child)) == 3 );
		$nb->reorder_child($child, 0);
		ok(1);
		$nb->reorder_child($child, $index);

		ok( $nb->get_current_page == 0 );

		$nb->next_page;
		ok(1);
		ok( $nb->get_current_page == 1 );

		$nb->set_current_page(4);
       		ok(1);
		ok( $nb->get_current_page == 4 );

		Gtk2->main_quit;
		ok(1);

		0
	} );

$win->show_all;
ok(1);

Gtk2->main;
ok(1);

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
