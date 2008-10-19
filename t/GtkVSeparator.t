#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 2, noinit => 1;

# $Id: GtkVSeparator.t,v 1.6 2008/10/05 12:49:35 kaffeetisch Exp $

my $separator = Gtk2::VSeparator -> new();
isa_ok($separator, "Gtk2::Separator");
isa_ok($separator, "Gtk2::VSeparator");

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
