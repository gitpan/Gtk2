#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 2, noinit => 1;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkObject.t,v 1.2 2004/02/03 22:27:20 kaffeetisch Exp $

my $label = Gtk2::Object -> new("Gtk2::Label", "Bla");
isa_ok($label, "Gtk2::Object");
isa_ok($label, "Gtk2::Label");

$label -> destroy();

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
