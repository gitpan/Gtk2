#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 10;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkScrolledWindow.t,v 1.7.4.1 2006/05/26 17:58:47 kaffeetisch Exp $

my $window = Gtk2::ScrolledWindow -> new();
isa_ok($window, "Gtk2::ScrolledWindow");

my $adjustment = Gtk2::Adjustment -> new(0, 0, 100, 1, 5, 10);

$window -> set_hadjustment($adjustment);
is($window -> get_hadjustment(), $adjustment);

$window -> set_vadjustment($adjustment);
is($window -> get_vadjustment(), $adjustment);

$window = Gtk2::ScrolledWindow -> new(undef, undef);
isa_ok($window, "Gtk2::ScrolledWindow");

my $label = Gtk2::Label -> new("Bla");
$window -> add_with_viewport($label);

$window = Gtk2::ScrolledWindow -> new($adjustment, $adjustment);
isa_ok($window, "Gtk2::ScrolledWindow");

$window -> set_policy("always", "automatic");
is_deeply([$window -> get_policy()], ["always", "automatic"]);

$window -> set_placement("bottom-right");
is($window -> get_placement(), "bottom-right");

$window -> set_shadow_type("etched-in");
is($window -> get_shadow_type(), "etched-in");

SKIP: {
  skip("new 2.8 stuff", 2)
    unless Gtk2->CHECK_VERSION (2, 8, 0);

  isa_ok($window -> get_hscrollbar(), "Gtk2::HScrollbar");
  isa_ok($window -> get_vscrollbar(), "Gtk2::VScrollbar");
}

__END__

Copyright (C) 2003-2005 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
