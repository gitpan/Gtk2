#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 1, noinit => 1;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkCellRendererText.t,v 1.1 2004/02/08 21:28:07 kaffeetisch Exp $

my $text = Gtk2::CellRendererText -> new();
isa_ok($text, "Gtk2::CellRendererText");

$text -> set_fixed_height_from_font(5);

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
