#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 8;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkLayout.t,v 1.6 2006/11/04 13:36:42 kaffeetisch Exp $

my $layout = Gtk2::Layout -> new();
isa_ok($layout, "Gtk2::Layout");

$layout = Gtk2::Layout -> new(undef, undef);
isa_ok($layout, "Gtk2::Layout");

my $adjustment = Gtk2::Adjustment -> new(0, 0, 100, 1, 5, 10);

$layout -> set_hadjustment($adjustment);
is($layout -> get_hadjustment(), $adjustment);

$layout -> set_vadjustment($adjustment);
is($layout -> get_vadjustment(), $adjustment);

$layout = Gtk2::Layout -> new($adjustment, $adjustment);
isa_ok($layout, "Gtk2::Layout");

my $label = Gtk2::Label -> new("Bla");

$layout -> put($label, 23, 42);
$layout -> move($label, 5, 5);

$layout -> set_size(10, 10);
is_deeply([$layout -> get_size()], [10, 10]);

is($layout -> bin_window(), undef);

my $window = Gtk2::Window -> new();
$window -> add($layout);
$layout -> realize();
isa_ok($layout -> bin_window(), "Gtk2::Gdk::Window");

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
