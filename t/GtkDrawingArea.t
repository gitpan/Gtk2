#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 1, noinit => 1;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkDrawingArea.t,v 1.5 2004/02/03 22:27:20 kaffeetisch Exp $

my $area = Gtk2::DrawingArea -> new();
isa_ok($area, "Gtk2::DrawingArea");

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
