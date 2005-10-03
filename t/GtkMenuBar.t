#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 3, noinit => 1;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkMenuBar.t,v 1.7 2005/09/18 15:07:22 kaffeetisch Exp $

my $bar = Gtk2::MenuBar -> new();
isa_ok($bar, "Gtk2::MenuBar");

SKIP: {
  skip("new 2.8 stuff", 2)
    unless Gtk2->CHECK_VERSION (2, 8, 0);

  $bar -> set_child_pack_direction("ltr");
  is($bar -> get_child_pack_direction(), "ltr");

  $bar -> set_pack_direction("rtl");
  is($bar -> get_pack_direction(), "rtl");
}

__END__

Copyright (C) 2003-2005 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
