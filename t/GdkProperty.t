#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 46;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GdkProperty.t,v 1.7 2008/02/11 21:10:52 kaffeetisch Exp $

my $window = Gtk2::Window -> new();
$window -> realize();

my $name = Gtk2::Gdk::Atom -> intern("WM_NAME", 1);
my $icon_name = Gtk2::Gdk::Atom -> intern("WM_ICON_NAME", 1);
my $strut = Gtk2::Gdk::Atom -> intern("_NET_WM_STRUT", 0);
my $strut_partial = Gtk2::Gdk::Atom -> intern("_NET_WM_STRUT_PARTIAL", 0);

my $string = Gtk2::Gdk::Atom -> new("STRING");
my $cardinal = Gtk2::Gdk::Atom -> new("CARDINAL");

foreach ($name, $strut, $strut_partial, $string, $cardinal) {
  isa_ok($_, "Gtk2::Gdk::Atom");
}

is($name -> name(), "WM_NAME");
is($icon_name -> name(), "WM_ICON_NAME");
is($strut -> name(), "_NET_WM_STRUT");
is($strut_partial -> name(), "_NET_WM_STRUT_PARTIAL");
is($string -> name(), "STRING");
is($cardinal -> name(), "CARDINAL");

$window -> window() -> property_change($name, $string, Gtk2::Gdk::CHARS, "replace", "Bla\0Bla\0Bla");
$window -> window() -> property_change($icon_name, $string, Gtk2::Gdk::CHARS, "replace", "Bla Bla Bla");
$window -> window() -> property_change($strut, $cardinal, Gtk2::Gdk::USHORTS, "replace", 0, 0, 26, 0);
$window -> window() -> property_change($strut_partial, $cardinal, Gtk2::Gdk::ULONGS, "replace", 0, 0, 26, 0, 0, 0, 0, 0, 0, 1279, 0, 0);

my ($atom, $format, @data);

($atom, $format, @data) = $window -> window() -> property_get($name, $string, 0, 1024, 0);
is($atom -> name(), "STRING");
is($format, Gtk2::Gdk::CHARS);
is(@data, 1);
is($data[0], "Bla\0Bla\0Bla");

($atom, $format, @data) = $window -> window() -> property_get($icon_name, $string, 0, 1024, 0);
is($atom -> name(), "STRING");
is($format, Gtk2::Gdk::CHARS);
is(@data, 1);
is($data[0], "Bla Bla Bla");

($atom, $format, @data) = $window -> window() -> property_get($strut, $cardinal, 0, 1024, 0);
is($atom -> name(), "CARDINAL");
is($format, Gtk2::Gdk::USHORTS);
is_deeply([@data], [0, 0, 26, 0]);

($atom, $format, @data) = $window -> window() -> property_get($strut_partial, $cardinal, 0, 1024, 0);
is($atom -> name(), "CARDINAL");
is($format, Gtk2::Gdk::ULONGS);
is_deeply([@data], [0, 0, 26, 0, 0, 0, 0, 0, 0, 1279, 0, 0]);

$window -> window() -> property_delete($name);
$window -> window() -> property_delete($strut);
$window -> window() -> property_delete($strut_partial);

is_deeply([Gtk2::Gdk -> text_property_to_text_list($string, Gtk2::Gdk::CHARS, "Bla\0Bla\0Bla")],
          [qw(Bla Bla Bla)]);
is_deeply([Gtk2::Gdk -> text_property_to_utf8_list($string, Gtk2::Gdk::CHARS, "Bla\0Bla\0Bla")],
          [qw(Bla Bla Bla)]);

($atom, $format, @data) = Gtk2::Gdk -> string_to_compound_text("Bla");
SKIP: {
  skip 'atom tests', 4 unless defined $atom;
  is($atom -> name(), "COMPOUND_TEXT");
  is($format, Gtk2::Gdk::CHARS);
  is(@data, 1);
  is($data[0], "Bla");
}

($atom, $format, @data) = Gtk2::Gdk -> utf8_to_compound_text("Bla");
SKIP: {
  skip 'atom tests', 4 unless defined $atom;
  is($atom -> name(), "COMPOUND_TEXT");
  is($format, Gtk2::Gdk::CHARS);
  is(@data, 1);
  is($data[0], "Bla");
}

SKIP: {
  skip("GdkDisplay is new 2.2", 10)
    unless (Gtk2 -> CHECK_VERSION(2, 2, 0));

  my $display = Gtk2::Gdk::Display -> get_default();

  is_deeply([Gtk2::Gdk -> text_property_to_text_list_for_display($display, $string, Gtk2::Gdk::CHARS, "Bla\0Bla\0Bla")],
          [qw(Bla Bla Bla)]);
  is_deeply([Gtk2::Gdk -> text_property_to_utf8_list_for_display($display, $string, Gtk2::Gdk::CHARS, "Bla\0Bla\0Bla")],
          [qw(Bla Bla Bla)]);

  ($atom, $format, @data) = Gtk2::Gdk -> string_to_compound_text_for_display($display, "Bla");
  is($atom -> name(), "COMPOUND_TEXT");
  is($format, Gtk2::Gdk::CHARS);
  is(@data, 1);
  is($data[0], "Bla");

  ($atom, $format, @data) = Gtk2::Gdk -> utf8_to_compound_text_for_display($display, "Bla");
  is($atom -> name(), "COMPOUND_TEXT");
  is($format, Gtk2::Gdk::CHARS);
  is(@data, 1);
  is($data[0], "Bla");
}

is(Gtk2::Gdk -> utf8_to_string_target("Bla"), "Bla");

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
