#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 7;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkImageMenuItem.t,v 1.6 2004/02/20 21:38:46 kaffeetisch Exp $

my $item = Gtk2::ImageMenuItem -> new();
isa_ok($item, "Gtk2::ImageMenuItem");

$item = Gtk2::ImageMenuItem -> new("_Bla");
isa_ok($item, "Gtk2::ImageMenuItem");

$item = Gtk2::ImageMenuItem -> new_with_label("Bla");
isa_ok($item, "Gtk2::ImageMenuItem");

$item = Gtk2::ImageMenuItem -> new_with_mnemonic("Bla");
isa_ok($item, "Gtk2::ImageMenuItem");

$item = Gtk2::ImageMenuItem -> new_from_stock("gtk-ok");
isa_ok($item, "Gtk2::ImageMenuItem");

$item = Gtk2::ImageMenuItem -> new_from_stock("gtk-ok", Gtk2::AccelGroup -> new());
isa_ok($item, "Gtk2::ImageMenuItem");

my $image = Gtk2::Image -> new_from_stock("gtk-quit", "menu");

$item -> set_image($image);
is($item -> get_image(), $image);

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
