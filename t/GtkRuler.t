#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 3, noinit => 1;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkRuler.t,v 1.5 2004/02/03 22:27:20 kaffeetisch Exp $

my $ruler = Gtk2::VRuler -> new();
isa_ok($ruler, "Gtk2::Ruler");

$ruler -> set_metric("pixels");
is($ruler -> get_metric(), "pixels");

$ruler -> set_range(0, 100, 10, 100);
is_deeply([$ruler -> get_range], [0, 100, 10, 100]);

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
