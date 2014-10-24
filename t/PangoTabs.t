#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 6, noinit => 1;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/PangoTabs.t,v 1.5.2.1 2004/04/04 17:16:39 kaffeetisch Exp $

SKIP: {
  skip("PangoTabs was broken prior to 1.3.3", 6)
    unless (Gtk2::Pango -> CHECK_VERSION(1, 3, 3));

  my $array = Gtk2::Pango::TabArray -> new(8, 0);
  isa_ok($array, "Gtk2::Pango::TabArray");

  $array = Gtk2::Pango::TabArray -> new_with_positions(2, 1, "left", 8, "left", 16);
  isa_ok($array, "Gtk2::Pango::TabArray");

  $array -> resize(3);
  is($array -> get_size(), 3);

  $array -> set_tab(2, "left", 24);
  is_deeply([$array -> get_tab(2)], ["left", 24]);

  is_deeply([$array -> get_tabs()], ["left", 8, "left", 16, "left", 24]);

  is($array -> get_positions_in_pixels(), 1);
}

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
