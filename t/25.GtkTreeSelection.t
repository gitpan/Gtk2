#!/usr/bin/perl -w
use strict;
use warnings;
use Gtk2;
use Test::More;

###############################################################################

if (Gtk2 -> init_check()) {
	plan(tests => 26);
}
else {
	plan(skip_all =>
		'Gtk2->init_check failed, probably unable to open DISPLAY');
}

###############################################################################

require './t/ignore_keyboard.pl';

my $model = Gtk2::ListStore -> new("Glib::String");
my $view = Gtk2::TreeView -> new($model);

my $renderer = Gtk2::CellRendererText -> new();
my $column = Gtk2::TreeViewColumn -> new_with_attributes(
				       "Hmm",
				       $renderer,
				       text => 0);

$view -> append_column($column);

foreach (qw(bla ble bli blo blu)) {
	$model -> set($model -> append(), 0 => $_);
}

###############################################################################

my $selection = $view -> get_selection();
isa_ok($selection, "Gtk2::TreeSelection");

$selection -> select_path(Gtk2::TreePath -> new_from_string(0));

###############################################################################

$selection -> set_mode("browse");
ok($selection -> get_mode() eq "browse");

###############################################################################

isa_ok($selection -> get_tree_view(), "Gtk2::TreeView");

###############################################################################

my ($tmp_model, $tmp_iter) = $selection -> get_selected();
isa_ok($tmp_model, "Gtk2::ListStore");
isa_ok($tmp_iter, "Gtk2::TreeIter");

is($tmp_model -> get($tmp_iter, 0), "bla");

isa_ok($selection -> get_selected(), "Gtk2::TreeIter");

###############################################################################

isa_ok($selection -> get_selected_rows(), "Gtk2::TreePath");

###############################################################################

is($selection -> count_selected_rows(), 1);

my $path = Gtk2::TreePath -> new_from_string(1);

$selection -> select_path($path);
ok($selection -> path_is_selected($path));

$selection -> unselect_path($path);
ok(not $selection -> path_is_selected($path));

###############################################################################

my $iter = $model -> get_iter($path);

is($model -> get($iter, 0), "ble");

$selection -> select_iter($iter);
ok($selection -> iter_is_selected($iter));

$selection -> unselect_iter($iter);
ok(not $selection -> iter_is_selected($iter));

###############################################################################

$selection -> set_mode("multiple");

$selection -> select_all();
is($selection -> count_selected_rows(), 5);

$selection -> unselect_all();
is($selection -> count_selected_rows(), 0);

my $path_start = Gtk2::TreePath -> new_from_string(3);
my $path_end = Gtk2::TreePath -> new_from_string(4);

$selection -> select_range($path_start, $path_end);
is($selection -> count_selected_rows(), 2);

SKIP: {
	skip("unselect_range is new in 2.2.x", 1)
		unless ((Gtk2 -> get_version_info())[1] >= 2);

	$selection -> unselect_range($path_start, $path_end);
	is($selection -> count_selected_rows(), 0);
}

###############################################################################

$selection -> unselect_all();

$selection -> set_select_function(sub {
	my ($selection, $model, $path, $selected) = @_;

	isa_ok($selection, "Gtk2::TreeSelection");
	isa_ok($model, "Gtk2::ListStore");
	isa_ok($path, "Gtk2::TreePath");

	return 0;
});

$selection -> select_path(Gtk2::TreePath -> new_from_string(1));
is($selection -> count_selected_rows(), 0);

$selection -> set_select_function(sub { return 1; });

###############################################################################

$selection -> select_path(Gtk2::TreePath -> new_from_string(1));

$selection -> selected_foreach(sub {
	my ($model, $path, $iter) = @_;

	is($model -> get($iter, 0), "ble");

	isa_ok($model, "Gtk2::ListStore");
	isa_ok($path, "Gtk2::TreePath");
	isa_ok($iter, "Gtk2::TreeIter");
});

###############################################################################

Glib::Idle -> add(sub {
	Gtk2 -> main_quit();
	return 0;
});

Gtk2 -> main();

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
