#!/usr/bin/perl
use strict;
use warnings;
use Gtk2::TestHelper
  tests => 9,
  at_least_version => [2, 12, 0, 'GtkScaleButton appeared in 2.12'];

# $Id: GtkScaleButton.t,v 1.4 2008/08/17 16:32:11 kaffeetisch Exp $

my $button;

$button = Gtk2::ScaleButton->new ('menu', 0, 100, 2);
is ($button->get ('icons'), undef);

$button = Gtk2::ScaleButton->new ('menu', 0, 100, 2, 'gtk-ok', 'gtk-cancel');
is_deeply ($button->get ('icons'), ['gtk-ok', 'gtk-cancel']);

$button->set_icons ('gtk-cancel', 'gtk-ok');
is_deeply ($button->get ('icons'), ['gtk-cancel', 'gtk-ok']);

$button->set_value (50);
is ($button->get_value, 50);

my $adj = Gtk2::Adjustment->new (50, 0, 100, 2, 10, 20);
$button->set_adjustment ($adj);
is ($button->get_adjustment, $adj);

SKIP: {
  skip 'new 2.14 stuff', 4
    unless Gtk2->CHECK_VERSION(2, 13, 6); # FIXME: 2.14

  isa_ok ($button->get_popup (), 'Gtk2::Widget');
  isa_ok ($button->get_plus_button (), 'Gtk2::Widget');
  isa_ok ($button->get_minus_button (), 'Gtk2::Widget');

  $button->set_orientation ('horizontal');
  is ($button->get_orientation (), 'horizontal');
}

__END__

Copyright (C) 2007 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
