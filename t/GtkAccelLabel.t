#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 4;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkAccelLabel.t,v 1.6 2007/03/17 14:54:25 kaffeetisch Exp $

my $button = Gtk2::Button -> new("Blub");

my $label = Gtk2::AccelLabel -> new("Bla");
isa_ok($label, "Gtk2::AccelLabel");

$label -> set_accel_widget($button);
is($label -> get_accel_widget(), $button);

like($label -> get_accel_width(), qr/^\d+$/);
ok(! $label -> refetch());

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
