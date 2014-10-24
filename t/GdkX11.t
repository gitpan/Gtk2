#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 11;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GdkX11.t,v 1.10 2008/01/09 20:28:36 kaffeetisch Exp $

my $window = Gtk2::Window -> new();
$window -> realize();

SKIP: {
  skip("X11 stuff", 9)
    unless $window -> window() -> can("get_xid");

  like($window -> window() -> get_xid(), qr/^\d+$/);
  like($window -> window() -> XID(), qr/^\d+$/);
  like($window -> window() -> XWINDOW(), qr/^\d+$/);
  like(Gtk2::Gdk::X11 -> get_server_time($window -> window()), qr/^\d+$/);

  SKIP: {
    skip("2.2 stuff", 3)
      unless Gtk2->CHECK_VERSION(2, 2, 0);

    my $display = Gtk2::Gdk::Display -> get_default();

    # Should we really do this?
    $display -> grab();
    $display -> ungrab();

    my $screen = Gtk2::Gdk::Screen -> get_default();

    like($screen -> get_screen_number(), qr/^\d+$/);
    ok(defined $screen -> get_window_manager_name());
    ok(not $screen -> supports_net_wm_hint(Gtk2::Gdk::Atom -> new("just-testing")));
  }

  SKIP: {
    skip("2.4 stuff", 0)
      unless Gtk2 -> CHECK_VERSION(2, 4, 0);

    my $display = Gtk2::Gdk::Display -> get_default();

    $display -> register_standard_event_type(1, 2);
  }

  SKIP: {
    skip("2.6 stuff", 0)
      unless Gtk2->CHECK_VERSION(2, 6, 0);

    $window -> window() -> set_user_time(time());
  }

  SKIP: {
    skip("2.8 stuff", 1)
      unless Gtk2->CHECK_VERSION(2, 8, 0);

    $window -> window() -> move_to_current_desktop();

    my $display = Gtk2::Gdk::Display -> get_default();

    $display -> set_cursor_theme("just-testing", 23);
    like($display -> get_user_time(), qr/^\d+$/);
  }

  SKIP: {
    skip '2.12 stuff', 1
      unless Gtk2->CHECK_VERSION(2, 12, 0);

    my $display = Gtk2::Gdk::Display -> get_default();
    my $startup_id = $display -> get_startup_notification_id();
    ok(TRUE); # $startup_id might be undef, so we can't really test
  }
}

SKIP: {
  skip("not-multihead-safe stuff", 2)
    unless UNIVERSAL::can("Gtk2::Gdk::X11", "net_wm_supports");

  like(Gtk2::Gdk::X11 -> get_default_screen(), qr/^\d+$/);
  ok(not Gtk2::Gdk::X11 -> net_wm_supports(Gtk2::Gdk::Atom -> new("just-testing")));

  # Should we really do this?
  Gtk2::Gdk::X11 -> grab_server();
  Gtk2::Gdk::X11 -> ungrab_server();
}

__END__

Copyright (C) 2003-2005 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
