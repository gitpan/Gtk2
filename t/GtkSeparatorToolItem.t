#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkSeparatorToolItem.t,v 1.2.2.1 2004/03/17 02:47:13 muppetman Exp $
#

use Gtk2::TestHelper
	at_least_version => [2, 4, 0, "Action-based menus are new in 2.4"],
	tests => 3;


my $item = Gtk2::SeparatorToolItem->new;
isa_ok ($item, 'Gtk2::SeparatorToolItem');


$item->set_draw (TRUE);
ok ($item->get_draw);

$item->set_draw (FALSE);
ok (!$item->get_draw);

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
