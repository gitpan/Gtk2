#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/11.GtkStatusBar.t,v 1.4 2003/09/11 15:01:32 rwmcfa1 Exp $
#

use strict;
use warnings;

#########################
# GtkStatusbar Tests
# 	- rm
#########################

#########################

use Gtk2;
use Test::More;

if( Gtk2->init_check )
{
	plan tests => 9;
}
else
{
	plan skip_all =>
		'Gtk2->init_check failed, probably unable to open DISPLAY';
}

#########################

ok( my $win = Gtk2::Window->new('toplevel') );
$win->set_title('GtkStatusbar.t Test Window');
$win->set_default_size(120,25);

ok( my $sts = Gtk2::Statusbar->new );
$win->add($sts);

ok( my $sts_cid1 = $sts->get_context_id('Main') );
ok( $sts->push($sts_cid1, 'Ready 1-0') );
ok( $sts->push($sts_cid1, 'Ready 1-1') );

ok( my $sts_cid2 = $sts->get_context_id('Not Main') );
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
