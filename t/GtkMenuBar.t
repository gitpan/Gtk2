#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 1, noinit => 1;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkMenuBar.t,v 1.5 2004/02/03 22:27:20 kaffeetisch Exp $

my $bar = Gtk2::MenuBar -> new();
isa_ok($bar, "Gtk2::MenuBar");

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
