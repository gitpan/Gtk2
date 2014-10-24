#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 3;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GdkX11.t,v 1.3 2004/02/27 05:31:48 muppetman Exp $

my $window = Gtk2::Window -> new();
$window -> realize();

SKIP: {
  skip("Doesn't seem to be the X11 backend", 3)
    unless ($window -> window() -> can("get_xid"));

  like($window -> window() -> get_xid(), qr/^\d+$/);
  like($window -> window() -> XID(), qr/^\d+$/);
  like($window -> window() -> XWINDOW(), qr/^\d+$/);

  SKIP: {
    skip("GdkDisplay is new in 2.2", 0)
      unless Gtk2->CHECK_VERSION (2, 2, 0);

    my $display = Gtk2::Gdk::Display -> get_default();

    $display -> grab();
    $display -> ungrab();
  }
}

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
