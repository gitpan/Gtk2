#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/12.GtkDialog.t,v 1.2 2003/05/17 13:31:06 rwmcfa1 Exp $
#

#########################
# GtkDialog Tests
# 	- rm
#########################

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 20;
BEGIN { use_ok('Gtk2') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

ok( Gtk2->init );

ok( $win = Gtk2::Window->new('toplevel') );
$win->set_title('GtkDialog.t Test Window');

$win->add( Gtk2::Label->new('Main Dialog') );

# a constructor made dialog, run
ok( $d1 = Gtk2::Dialog->new("Test Dialog", $win, 
		[qw/destroy-with-parent no-separator/], 
		'gtk-cancel', 2, 'gtk-quit', 3 ) );
ok( $btn1 = $d1->add_button('Another', 4) );
ok( $d1->get_has_separator == 0 );
Glib::Idle->add( sub {
		$btn1->clicked;
		0;
	});
ok( $d1->run == 4 );
$d1->hide;

# a hand made dialog, run
ok( $d2 = Gtk2::Dialog->new );
ok( $d2->add_button('First Button', 0) );
ok( $btn2 = $d2->add_button('gtk-ok', 1) );
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
ok( $d3 = Gtk2::Dialog->new("Test Dialog", $win, 
		[qw/destroy-with-parent no-separator/], 
		'gtk-ok', 22, 'gtk-quit', 33 ) );
ok( $btn3 = $d3->add_button('Another', 44) );
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
