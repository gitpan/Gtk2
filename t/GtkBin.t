#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 2;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkBin.t,v 1.7 2006/09/10 17:30:24 kaffeetisch Exp $

my $container = Gtk2::Container -> new(Gtk2::Window::);
my $label = Gtk2::Label -> new("Bla");

$container -> add($label);
is($container -> get_child(), $label);
is($container -> child(), $label);

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
