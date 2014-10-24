#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 2, noinit => 1;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkVScrollbar.t,v 1.5 2004/02/03 22:27:20 kaffeetisch Exp $

my $adjustment = Gtk2::Adjustment -> new(0, 0, 100, 1, 5, 10);

my $bar = Gtk2::VScrollbar -> new($adjustment);
isa_ok($bar, "Gtk2::Scrollbar");
isa_ok($bar, "Gtk2::VScrollbar");

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
