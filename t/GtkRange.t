#!/usr/bin/perl -w
# vim: set ft=perl :
use strict;
use Gtk2::TestHelper tests => 10;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkRange.t,v 1.11 2008/09/06 20:11:04 kaffeetisch Exp $

my $adjustment = Gtk2::Adjustment -> new(0, 0, 100, 1, 5, 10);

my $range = Gtk2::HScale -> new($adjustment);
isa_ok($range, "Gtk2::Range");

$range -> set_adjustment($adjustment);
is($range -> get_adjustment(), $adjustment);

$range -> set_update_policy("continuous");
is($range -> get_update_policy(), "continuous");

$range -> set_inverted(1);
is($range -> get_inverted(), 1);

$range -> set_value(23.42);
delta_ok($range -> get_value(), 23.42);

$range -> set_increments(1, 5);
$range -> set_range(0, 100);

SKIP: {
        skip 'new stuff in 2.10', 2
                unless Gtk2 -> CHECK_VERSION(2, 10, 0);

        $range -> set_lower_stepper_sensitivity('off');
        is ($range -> get_lower_stepper_sensitivity, 'off');

	$range -> set_upper_stepper_sensitivity('on');
	is ($range -> get_upper_stepper_sensitivity, 'on');
}

SKIP: {
        skip 'new stuff in 2.12', 3
                unless Gtk2 -> CHECK_VERSION(2, 12, 0);

	$range -> set_show_fill_level(TRUE);
	ok($range -> get_show_fill_level());

	$range -> set_restrict_to_fill_level(FALSE);
	ok(!$range -> get_restrict_to_fill_level());

	$range -> set_fill_level(0.23);
	delta_ok($range -> get_fill_level(), 0.23);
}

__END__

Copyright (C) 2003,2006 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
