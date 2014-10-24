#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 9;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkRadioMenuItem.t,v 1.8.12.1 2007/03/17 14:58:34 kaffeetisch Exp $

my $item_one = Gtk2::RadioMenuItem -> new();
isa_ok($item_one, "Gtk2::RadioMenuItem");

my $item_two = Gtk2::RadioMenuItem -> new($item_one);
isa_ok($item_two, "Gtk2::RadioMenuItem");

my $item_three = Gtk2::RadioMenuItem -> new_with_label([], "Bla");
isa_ok($item_three, "Gtk2::RadioMenuItem");

my $item_four = Gtk2::RadioMenuItem -> new_with_mnemonic([$item_one, $item_two], "_Bla");
isa_ok($item_four, "Gtk2::RadioMenuItem");

$item_three -> set_group($item_one);

is_deeply($item_one -> get_group(), [$item_one, $item_two, $item_three, $item_four]);

SKIP: {
  skip("the from_widget variants are new in 2.4", 4)
    unless Gtk2->CHECK_VERSION (2, 4, 0);

  my $item_five = Gtk2::RadioMenuItem -> new_from_widget($item_one);
  isa_ok($item_five, "Gtk2::RadioMenuItem");

  my $item_six = Gtk2::RadioMenuItem -> new_with_label_from_widget($item_two, "Bla");
  isa_ok($item_six, "Gtk2::RadioMenuItem");

  my $item_seven = Gtk2::RadioMenuItem -> new_with_mnemonic_from_widget($item_three, "_Bla");
  isa_ok($item_seven, "Gtk2::RadioMenuItem");

  is_deeply($item_one -> get_group(), [$item_one, $item_two, $item_three, $item_four, $item_five, $item_six, $item_seven]);
}

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
