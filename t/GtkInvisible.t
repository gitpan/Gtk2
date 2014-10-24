#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 3;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkInvisible.t,v 1.5 2004/02/27 05:31:48 muppetman Exp $

my $invisible = Gtk2::Invisible -> new();
isa_ok($invisible, "Gtk2::Invisible");

SKIP: {
  skip("GdkScreen is new in 2.2", 2)
    unless Gtk2->CHECK_VERSION (2, 2, 0);

  my $screen = Gtk2::Gdk::Screen -> get_default();

  $invisible = Gtk2::Invisible -> new_for_screen($screen);
  isa_ok($invisible, "Gtk2::Invisible");

  $invisible -> set_screen($screen);
  is($invisible -> get_screen(), $screen);
}

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
