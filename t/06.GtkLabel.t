#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/06.GtkLabel.t,v 1.2 2003/08/19 14:25:13 rwmcfa1 Exp $
#

#########################
# GtkLabel Tests
# 	- rm
#########################

#########################

use Gtk2;
use Test::More;

if( Gtk2->init_check )
{
	plan tests => 5;
}
else
{
	plan skip_all =>
		'Gtk2->init_check failed, probably unable to open DISPLAY';
}

#########################

ok( $win = Gtk2::Window->new() );
$win->set_border_width(10);

ok( $label = Gtk2::Label->new("Hello World!") );
$win->add($label);

ok( $label->get_text eq 'Hello World!' );
$label->set_justify("right");
ok( $label->get_selectable == 0 );
$label->set_selectable(1);
ok( $label->get_selectable == 1 );
$label->select_region(2, 8);

$win->show_all;

Glib::Idle->add( sub {
		Gtk2->main_quit;
		0;
	} );

Gtk2->main;

1;
