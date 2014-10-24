#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/12.GtkDialog.t,v 1.6 2003/11/29 17:20:46 rwmcfa1 Exp $
#

use strict;
use warnings;

#########################
# GtkDialog Tests
# 	- rm
#########################

#########################

use Gtk2;
use Test::More;

if( Gtk2->init_check )
{
	plan tests => 18;
}
else
{
	plan skip_all =>
		'Gtk2->init_check failed, probably unable to open DISPLAY';
}

#########################

require './t/ignore_keyboard.pl';

ok( my $win = Gtk2::Window->new('toplevel') );
$win->set_title('GtkDialog.t Test Window');

$win->add( Gtk2::Label->new('Main Dialog') );

# a constructor made dialog, run
ok( my $d1 = Gtk2::Dialog->new("Test Dialog", $win,
		[qw/destroy-with-parent no-separator/],
		'gtk-cancel', 2, 'gtk-quit', 3 ) );
ok( my $btn1 = $d1->add_button('Another', 4) );
ok( $d1->get_has_separator == 0 );
Glib::Idle->add( sub {
		$btn1->clicked;
		0;
	});
ok( $d1->run == 4 );
$d1->hide;

# a hand made dialog, run
ok( my $d2 = Gtk2::Dialog->new );
ok( $d2->add_button('First Button', 0) );
ok( my $btn2 = $d2->add_button('gtk-ok', 1) );
$d2->set_has_separator(1);
ok( $d2->get_has_separator == 1 );
$d2->set_has_separator(0);
ok( $d2->get_has_separator == 0 );
$d2->add_buttons('gtk-cancel', 2, 'gtk-quit', 3, 'Last Button', 4);
$d2->signal_connect( response => sub {
		ok( $_[1] == 1 );
		1;
	});
Glib::Idle->add( sub {
		$btn2->clicked;
		0;
	});
ok( $d2->run == 1 );
$d2->hide;

# a constructor made dialog, show
ok( my $d3 = Gtk2::Dialog->new("Test Dialog", $win,
		[qw/destroy-with-parent no-separator/],
		'gtk-ok', 22, 'gtk-quit', 33 ) );
ok( my $btn3 = $d3->add_button('Another', 44) );
ok( $d3->get_has_separator == 0 );
$d3->vbox->pack_start( Gtk2::Label->new('This is just a test.'), 0, 0, 0);
$d3->action_area->pack_start( Gtk2::Label->new('<- Actions'), 0, 0, 0);
$d3->show_all;
$d3->signal_connect( response => sub {
		ok( $_[1] == 44 );
		1;
	});
ok(1);

#$win->show_all;

Glib::Idle->add( sub {
		$btn3->clicked;
		Gtk2->main_quit;
		0;
	});

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
