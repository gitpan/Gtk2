#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 2, noinit => 1, skip_all => "Currently broken"; # FIXME

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkStock.t,v 1.5.6.1 2005/01/31 19:56:49 kaffeetisch Exp $

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
is_deeply(Gtk2::Stock -> lookup("gtk2perl-test-script"), $items[0]);

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
