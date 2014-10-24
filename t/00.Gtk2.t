#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/00.Gtk2.t,v 1.5 2003/08/19 14:25:13 rwmcfa1 Exp $
#

#########################
# Gtk2 Tests
# 	- rm
#########################

#########################

use Test::More tests => 15;
BEGIN { use_ok('Gtk2') };

#########################

ok( Gtk2->get_version_info );
ok( Gtk2->check_version(0,0,0) eq 'Gtk+ version too new (major mismatch)' );
ok( Gtk2->check_version(50,0,0) eq 'Gtk+ version too old (major mismatch)' );

SKIP:
{
	skip 'Gtk2->init_check failed, probably unable to open DISPLAY', 
		11, unless( Gtk2->init_check );

	ok( Gtk2->init );

	ok( Gtk2->events_pending == 0 );

	ok( Gtk2->main_level == 0 );

	Gtk2->init_add( sub { ok(1); } );
	Gtk2->init_add( sub { ok($_[0] eq 'foo'); }, 'foo' );
	ok(1);

	ok( $q1 = Gtk2->quit_add( 0, sub { Gtk2->quit_remove($q1); ok(1); } ) );
	ok( Gtk2->quit_add( 0, sub { ok($_[0] eq 'bar'); }, 'bar' ) );

	Glib::Idle->add( sub { Gtk2->main_quit; 0 } );
	Gtk2->main;
	ok(1);
}
