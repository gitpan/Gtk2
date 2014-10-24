#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 2, noinit => 1;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkSizeGroup.t,v 1.5 2004/02/03 22:27:20 kaffeetisch Exp $

my $group = Gtk2::SizeGroup -> new("vertical");
isa_ok($group, "Gtk2::SizeGroup");

$group -> set_mode("horizontal");
is($group -> get_mode(), "horizontal");

my $label = Gtk2::Label -> new("Bla");

$group -> add_widget($label);
$group -> remove_widget($label);

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
