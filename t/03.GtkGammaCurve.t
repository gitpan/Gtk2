#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/03.GtkGammaCurve.t,v 1.2 2003/08/19 14:25:13 rwmcfa1 Exp $
#

#########################
# GtkGammaCurve Tests
# 	- rm
#########################

#########################

use Test::More;
BEGIN { use_ok('Gtk2') };

if( Gtk2->init_check )
{
	plan tests => 3;
}
else
{
	plan skip_all =>
		'Gtk2->init_check failed, probably unable to open DISPLAY';
}

#########################

ok( $win = Gtk2::Window->new("toplevel") );

ok( $gamma = Gtk2::GammaCurve->new() );

$win->add($gamma);

$gamma->curve->set_range(0, 255, 0, 255);

$win->show_all;

Glib::Idle->add( sub
	{
		$gamma->curve->set_vector(0, 255);
		$gamma->curve->set_curve_type('spline');
		ok( eq_array( [ $gamma->curve->get_vector(2) ], [ 0, 255 ] ) );
		Gtk2->main_quit;
		0;
	} );

Gtk2->main;
