#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 1, noinit => 1;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkTearoffMenuItem.t,v 1.5 2004/02/03 22:27:20 kaffeetisch Exp $

my $item = Gtk2::TearoffMenuItem -> new();
isa_ok($item, "Gtk2::TearoffMenuItem");

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
