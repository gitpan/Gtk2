#!/usr/bin/perl -w

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkFontButton.t,v 1.4.2.1 2004/03/17 02:47:13 muppetman Exp $

use Gtk2::TestHelper
	tests => 12,
	at_least_version => [2, 4, 0, "GtkFontButton is new in 2.4"],
	;

my $fbn;
$fbn = Gtk2::FontButton->new;
isa_ok ($fbn, 'Gtk2::FontButton');
$fbn = Gtk2::FontButton->new_with_font ("monospace");
isa_ok ($fbn, 'Gtk2::FontButton');


$fbn->set_title ("slartibartfast");
is ($fbn->get_title, "slartibartfast");


$fbn->set_use_font (FALSE);
ok (!$fbn->get_use_font);

$fbn->set_use_font (TRUE);
ok ($fbn->get_use_font);


$fbn->set_use_size (FALSE);
ok (!$fbn->get_use_size);

$fbn->set_use_size (TRUE);
ok ($fbn->get_use_size);


$fbn->set_show_style (FALSE);
ok (!$fbn->get_show_style);

$fbn->set_show_style (TRUE);
ok ($fbn->get_show_style);


$fbn->set_show_size (FALSE);
ok (!$fbn->get_show_size);

$fbn->set_show_size (TRUE);
ok ($fbn->get_show_size);


$fbn->set_font_name ("sans");
like ($fbn->get_font_name, qr/sans/i);

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
