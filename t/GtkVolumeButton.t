#!/usr/bin/perl
use strict;
use warnings;
use Gtk2::TestHelper
  tests => 1,
  at_least_version => [2, 12, 0, 'GtkVolumeButton appeared in 2.12'];

# $Id: GtkVolumeButton.t,v 1.2 2008/03/10 20:54:36 kaffeetisch Exp $

my $button = Gtk2::VolumeButton->new;
isa_ok ($button, 'Gtk2::VolumeButton');

__END__

Copyright (C) 2007 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
