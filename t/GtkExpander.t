#!/usr/bin/perl -w

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkExpander.t,v 1.4.2.1 2004/03/17 02:47:13 muppetman Exp $

use Gtk2::TestHelper
	tests => 14,
	noinit => 1,
	at_least_version => [2, 4, 0, "GtkExpander is new in 2.4"],
	;

my $expander = Gtk2::Expander->new;
my $expander1 = Gtk2::Expander->new ('hi there');
my $expander2 = Gtk2::Expander->new_with_mnemonic ('_Hi there');

isa_ok ($expander, 'Gtk2::Expander');
isa_ok ($expander1, 'Gtk2::Expander');
isa_ok ($expander2, 'Gtk2::Expander');

$expander->set_expanded (FALSE);
ok (!$expander->get_expanded);

$expander->set_expanded (TRUE);
ok ($expander->get_expanded);

$expander->set_spacing (0);
is ($expander->get_spacing, 0);

$expander->set_spacing (6);
is ($expander->get_spacing, 6);

$expander->set_spacing (1);
is ($expander->get_spacing, 1);


$expander->set_label ('a different label');
is ($expander->get_label, 'a different label');

$expander->set_use_underline (TRUE);
ok ($expander->get_use_underline);

$expander->set_use_underline (FALSE);
ok (!$expander->get_use_underline);

$expander->set_use_markup (TRUE);
ok ($expander->get_use_markup);

$expander->set_use_markup (FALSE);
ok (!$expander->get_use_markup);


my $label = Gtk2::Label->new ('foo');
$expander->set_label_widget ($label);
is ($expander->get_label_widget, $label);

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
