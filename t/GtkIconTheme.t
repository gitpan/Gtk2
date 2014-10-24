#!/usr/bin/perl
#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkIconTheme.t,v 1.19 2007/10/21 15:29:47 kaffeetisch Exp $
#

use Gtk2::TestHelper
	at_least_version => [2, 4, 0, 'GtkIconTheme is new in 2.4'],
	tests => 16;

my $icon_theme = Gtk2::IconTheme->new;
isa_ok ($icon_theme, 'Gtk2::IconTheme');

$icon_theme = Gtk2::IconTheme->get_default;
isa_ok ($icon_theme, 'Gtk2::IconTheme');

$icon_theme = Gtk2::IconTheme->get_for_screen (Gtk2::Gdk::Screen->get_default);
isa_ok ($icon_theme, 'Gtk2::IconTheme');

$icon_theme->set_screen (Gtk2::Gdk::Screen->get_default);

ok ($icon_theme->list_icons (undef));

ok (!$icon_theme->has_icon ('something crazy'));

my $icon_info = $icon_theme->lookup_icon ('stock_edit', 24, 'use-builtin');

SKIP: {
	skip 'lookup_icon returned undef, skipping the rest', 5
		unless defined $icon_info;

	isa_ok ($icon_info, 'Gtk2::IconInfo');

	my $pixbuf = $icon_theme->load_icon ('stock_edit', 24, 'use-builtin');
	isa_ok ($pixbuf, 'Gtk2::Gdk::Pixbuf');

	isa_ok ($icon_info->load_icon, 'Gtk2::Gdk::Pixbuf');

	ok (defined $icon_info->get_base_size);
	like ($icon_info->get_filename, qr/stock_edit/);

	# FIXME:
	# isa_ok ($icon_info->get_builtin_pixbuf, 'Gtk2::Gdk::Pixbuf');
	# isa_ok($icon_info->get_embedded_rect, 'Gtk2::Gdk::Rectangle');
	# warn $icon_info->get_attach_points;
	# warn $icon_info->get_display_name;

	$icon_info->set_raw_coordinates (1);

	$icon_theme->add_builtin_icon ('stock_edit', 24, $pixbuf);
}

SKIP: {
	skip 'new 2.6 stuff', 1
		unless Gtk2->CHECK_VERSION (2, 6, 0);

	my @sizes = $icon_theme->get_icon_sizes ('stock_edit');

	skip 'get_icon_sizes returned empty, can not test them', 1
		unless (@sizes);

	like ($sizes[0], qr/^\d+$/);
}

SKIP: {
	skip 'new 2.12 stuff', 1
		unless Gtk2->CHECK_VERSION (2, 12, 0);

	my @contexts = $icon_theme->list_contexts;
	# @contexts might be undef and can contain anything

	my $info = $icon_theme->choose_icon (['gtk-bla', 'gtk-cancel'], 24, 'use-builtin');
	isa_ok ($info, 'Gtk2::IconInfo');
}

my @paths = qw(/tmp /etc /home);
$icon_theme->set_search_path (@paths);

is_deeply ([$icon_theme->get_search_path], \@paths);

$icon_theme->append_search_path ('/usr/local/tmp');
push @paths, '/usr/local/tmp';
is_deeply ([$icon_theme->get_search_path], \@paths);

$icon_theme->prepend_search_path ('/usr/tmp');
unshift @paths, '/usr/tmp';
is_deeply ([$icon_theme->get_search_path], \@paths);

# cannot call set_custom_theme on a default theme
$icon_theme = Gtk2::IconTheme->new;
$icon_theme->set_custom_theme ('crazy custom theme');

# Ignore result.  Might be anything, including undef.
$icon_theme->get_example_icon_name;

ok (!$icon_theme->rescan_if_needed);

__END__

Copyright (C) 2003-2005 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
