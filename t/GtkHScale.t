#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 2;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkHScale.t,v 1.6 2005/09/18 15:07:22 kaffeetisch Exp $

my $adjustment = Gtk2::Adjustment -> new(0, 0, 100, 1, 5, 10);

my $scale = Gtk2::HScale -> new($adjustment);
isa_ok($scale, "Gtk2::HScale");

$scale = Gtk2::HScale -> new_with_range(0, 100, 1);
isa_ok($scale, "Gtk2::HScale");

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
