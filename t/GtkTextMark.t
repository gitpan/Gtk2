#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 5, noinit => 1;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkTextMark.t,v 1.2 2004/02/03 22:27:20 kaffeetisch Exp $

my $buffer = Gtk2::TextBuffer -> new();
my $iter = $buffer -> get_start_iter();

$buffer -> insert($iter, "Lore ipsem dolor.  I think that is misspelled.\n");

my $mark = $buffer -> create_mark("bla", $iter, 1);
is($mark -> get_name(), "bla");
is($mark -> get_buffer(), $buffer);
is($mark -> get_left_gravity(), 1);

$mark -> set_visible(1);
is($mark -> get_visible(), 1);

$buffer -> delete_mark($mark);
is($mark -> get_deleted(), 1);

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
