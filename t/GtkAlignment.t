#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 2, noinit => 1;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkAlignment.t,v 1.7.2.1 2004/03/17 02:47:13 muppetman Exp $

my $alignment = Gtk2::Alignment -> new(2.3, 4.2, 7, 13);
isa_ok($alignment, "Gtk2::Alignment");

$alignment -> set(2.3, 4.2, 7, 13);

SKIP: {
  skip("[sg]et_padding are new in 2.4", 1)
    unless Gtk2->CHECK_VERSION (2, 4, 0);

  $alignment -> set_padding(1, 2, 3, 4);
  is_deeply([$alignment -> get_padding()], [1, 2, 3, 4]);
}

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
