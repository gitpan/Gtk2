#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper
  tests => 8,
  at_least_version => [2, 6, 0, "GtkFileChooserButton is new in 2.6"];

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkFileChooserButton.t,v 1.3 2006/01/18 19:04:10 kaffeetisch Exp $

my $dialog = Gtk2::FileChooserDialog -> new("Urgs", undef, "open",
                                            "gtk-cancel" => "cancel",
                                            "gtk-ok" => "ok");

my $button = Gtk2::FileChooserButton -> new("Urgs", "open");
isa_ok($button, "Gtk2::FileChooserButton");
ginterfaces_ok($button);

$button = Gtk2::FileChooserButton -> new_with_backend("Urgs", "open", "backend");
isa_ok($button, "Gtk2::FileChooserButton");
isa_ok($button, "Gtk2::FileChooser");

$button = Gtk2::FileChooserButton -> new_with_dialog($dialog);
isa_ok($button, "Gtk2::FileChooserButton");
isa_ok($button, "Gtk2::FileChooser");

$button -> set_title("Urgs");
is($button -> get_title(), "Urgs");

$button -> set_width_chars(23);
is($button -> get_width_chars(), 23);

__END__

Copyright (C) 2004 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
