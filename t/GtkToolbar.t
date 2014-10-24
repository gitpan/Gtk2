#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkToolbar.t,v 1.5.2.1 2004/03/17 02:47:13 muppetman Exp $
#

#########################
# GtkToolbar Tests
# 	- rm
#########################

use Gtk2::TestHelper tests => 29;

ok( my $dlg = Gtk2::Dialog->new('GtkToolbar.t Test Window', undef,
		[ ], 'gtk-quit', 1 ) );
$dlg->set_default_size(600,300);

# so pixmaps will work?
$dlg->realize;

ok( my $tlbr = Gtk2::Toolbar->new );
$dlg->vbox->pack_start($tlbr, 0, 0, 0);

$tlbr->set_orientation('horizontal');
ok(1);

is( $tlbr->get_orientation, 'horizontal' );

$tlbr->unset_style;

$tlbr->set_style('both');
ok(1);

is( $tlbr->get_style, 'both' );

ok( $tlbr->insert_stock('gtk-open', 'Open Nothing', 'Verbose Open Nothing',
		undef, undef, 0) );

$tlbr->append_space;

ok( my $quit_btn = $tlbr->append_item('Close', 'Closes this app', 'Private',
	Gtk2::Image->new_from_stock('gtk-quit', $tlbr->get_icon_size),
       	sub { ok(1); }) );

$tlbr->append_space;

sub radio_event
{
	$tlbr->set_style($_[1]);
	ok(1);
	1;
}

ok( my $icons = $tlbr->append_element( 'radiobutton', undef, 'Icons',
	'Only Icons will be shown on the toolbar', 'Private',
	Gtk2::Image->new_from_stock('gtk-go-up', $tlbr->get_icon_size),
	\&radio_event, 'icons' ) );

ok( my $text = $tlbr->append_element( 'radiobutton', $icons, 'Text',
	'Only Text will be shown on the toolbar', 'Private',
	Gtk2::Image->new_from_stock('gtk-go-down', $tlbr->get_icon_size),
	\&radio_event, 'text' ) );

ok( my $both = $tlbr->append_element( 'radiobutton', $icons, 'Icons & Text',
	'Icons & Text will be shown on the toolbar', 'Private',
	Gtk2::Image->new_from_stock('gtk-go-back', $tlbr->get_icon_size),
	\&radio_event, 'both' ) );

$tlbr->append_space;

ok( my $tips = $tlbr->append_element( 'togglebutton', undef, 'Tooltips',
	'A toggle button to turn on/off Tooltips', 'Private',
	Gtk2::Image->new_from_stock('gtk-go-forward', $tlbr->get_icon_size),
	sub {
		$tlbr->set_tooltips($_[0]->get_active);
		ok(1);

		is( $tlbr->get_tooltips, $_[0]->get_active );

		1;
	} ) );

$tlbr->append_space;

ok( my $size = $tlbr->append_element( 'togglebutton', undef, 'Icon Size',
	'A toggle button to change the icon size', 'Private',
	Gtk2::Image->new_from_stock('gtk-go-up', $tlbr->get_icon_size),
	sub {
		if( $_[0]->get_active )
		{
			$tlbr->set_icon_size('small-toolbar');
		}
		else
		{
			$tlbr->set_icon_size('large-toolbar');
		}

		ok(1);
		1;
	} ) );

$tlbr->append_space;

ok( my $entry = Gtk2::Entry->new );
$tlbr->append_widget( $entry, 'This is just an entry', 'Private' );
$entry->set_text('An Entry Widget');

$icons->clicked;
$text->clicked;
$both->clicked;
$tips->clicked;
$size->clicked;
$quit_btn->clicked;

SKIP: {
	skip "stuff new in 2.4", 6
		unless Gtk2->CHECK_VERSION (2, 4, 0);

	$tlbr = Gtk2::Toolbar->new;

	is( $tlbr->get_drop_index (10, 10), 0 );

	my $item = Gtk2::ToolItem->new;
	$tlbr->insert ($item, 0);
	is( $tlbr->get_item_index ($item), 0 );
	is( $tlbr->get_n_items, 1 );
	is( $tlbr->get_nth_item (0), $item );
	ok( $tlbr->get_relief_style );

	$tlbr->set_show_arrow (1);
	is( $tlbr->get_show_arrow, 1 );

	$tlbr->set_drop_highlight_item (Gtk2::ToolItem->new, 1);
}

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
