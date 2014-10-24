#!/usr/bin/perl
use strict;
use warnings;
use Gtk2::TestHelper
  tests => 5,
  at_least_version => [2, 13, 6, 'GtkToolShell is new in 2.14'], # FIXME: 2.14
  ;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkToolShell.t,v 1.1 2008/08/16 13:54:13 kaffeetisch Exp $

my $toolbar = Gtk2::Toolbar->new ();
isa_ok ($toolbar, 'Gtk2::ToolShell');

ok (defined $toolbar->get_icon_size ());
ok (defined $toolbar->get_orientation ());
ok (defined $toolbar->get_relief_style ());
ok (defined $toolbar->get_style ());
$toolbar->rebuild_menu ();

__END__

Copyright (C) 2008 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
