#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 6, noinit => 1;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkStock.t,v 1.6.2.1 2005/06/22 22:22:13 kaffeetisch Exp $

use Gtk2::Gdk::Keysyms;

my @items = (
  {
    stock_id => "gtk2perl-test-script",
    label => "_gtk2perl test script",
    modifier => [qw(shift-mask control-mask)],
    keyval => $Gtk2::Gdk::Keysyms{ KP_Enter },
    translation_domain => "de_DE"
  },
  {
    stock_id => "gtk2perl-bla"
  }
);

Gtk2::Stock -> add(@items);
is_deeply([(Gtk2::Stock -> list_ids())[0, 1]], ["gtk2perl-test-script", "gtk2perl-bla"]);

my $test = Gtk2::Stock -> lookup("gtk2perl-test-script");
is($test -> { stock_id }, $items[0] -> { stock_id });
is($test -> { label }, $items[0] -> { label });
is($test -> { modifier }, $items[0] -> { modifier });
is($test -> { keyval }, $items[0] -> { keyval });
is($test -> { translation_domain }, $items[0] -> { translation_domain });

__END__

Copyright (C) 2003-2005 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
