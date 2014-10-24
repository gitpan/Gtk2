#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/02.GtkButton.t,v 1.1 2003/06/05 15:01:02 rwmcfa1 Exp $
#

#########################
# GtkButton Tests
# 	- rm
#########################

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 8;
BEGIN { use_ok('Gtk2') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

ok( Gtk2->init );

ok( $win = Gtk2::Window->new('toplevel') );

$win->set_title('Gtkbutton.t Test Window');

ok( $button = Gtk2::Button->new("Not Yet") );
$button->show;
$button->signal_connect( "clicked" , sub
	{
		if( $_[0]->child->get_text eq 'Quit' )
		{
			Gtk2->main_quit;
		}
		else
		{
			$_[0]->child->set_text("Quit");
		}
	} );

$win->add($button);
$win->show;

$button->set_relief("half");

ok( $button->get_relief eq 'half' );

$button->set_label('Click Me');

ok( $button->get_label eq 'Click Me' );

ok( $win2 = Gtk2::Window->new('toplevel') );
ok( $button_stock = Gtk2::Button->new_from_stock('Apply') );
$win2->add($button_stock);
$button_stock->show;

Glib::Idle->add( sub 
	{
		$win2->show;
		$button->pressed;
		$button->released;
		#$button->clicked;
		$button->enter;
		$button->leave;
		Gtk2->main_quit;
		0;
	} );

Gtk2->main;
