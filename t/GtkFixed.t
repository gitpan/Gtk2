#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 2, noinit => 1;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkFixed.t,v 1.5 2004/02/03 22:27:20 kaffeetisch Exp $

my $fixed = Gtk2::Fixed -> new();
isa_ok($fixed, "Gtk2::Fixed");

my $label = Gtk2::Label -> new("Bla");

$fixed -> put($label, 23, 42);
$fixed -> move($label, 5, 5);

$fixed -> set_has_window(1);
is($fixed -> get_has_window(), 1);

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
