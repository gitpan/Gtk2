#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 1, noinit => 1;

# $Id: GtkDrawingArea.t 2054 2008-10-05 12:49:36Z tsch $

my $area = Gtk2::DrawingArea -> new();
isa_ok($area, "Gtk2::DrawingArea");

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
