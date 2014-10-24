#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 5;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkColorSelectionDialog.t,v 1.4 2004/02/03 22:27:20 kaffeetisch Exp $

my $dialog = Gtk2::ColorSelectionDialog -> new("Bla");
isa_ok($dialog, "Gtk2::ColorSelectionDialog");
isa_ok($dialog -> colorsel(), "Gtk2::ColorSelection");
isa_ok($dialog -> ok_button(), "Gtk2::Button");
isa_ok($dialog -> cancel_button(), "Gtk2::Button");
isa_ok($dialog -> help_button(), "Gtk2::Button");

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
