#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 1;

# $Id: GtkInputDialog.t,v 1.5 2008/10/05 12:49:35 kaffeetisch Exp $

my $dialog = Gtk2::InputDialog -> new();
isa_ok($dialog, "Gtk2::InputDialog");

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
