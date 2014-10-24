#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/11.GtkStatusBar.t,v 1.2 2003/05/17 13:31:06 rwmcfa1 Exp $
#

#########################
# GtkStatusbar Tests
# 	- rm
#########################

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 11;
BEGIN { use_ok('Gtk2') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

ok( Gtk2->init );

ok( $win = Gtk2::Window->new('toplevel') );
$win->set_title('GtkStatusbar.t Test Window');
$win->set_default_size(120,25);

ok( $sts = Gtk2::Statusbar->new );
$win->add($sts);

ok( $sts_cid1 = $sts->get_context_id('Main') );
ok( $sts->push($sts_cid1, 'Ready 1-0') );
ok( $sts->push($sts_cid1, 'Ready 1-1') );

ok( $sts_cid2 = $sts->get_context_id('Not Main') );
ok( $sts->push($sts_cid2, 'Ready 2-0') );
ok( $sts->push($sts_cid2, 'Ready 2-1') );

$win->show_all;

$sts->pop($sts_cid2);
$sts->pop($sts_cid1);

Glib::Idle->add( sub {
		$sts->pop($sts_cid2);
		Gtk2->main_quit;
		0;
	});

Gtk2->main;

ok(1);
