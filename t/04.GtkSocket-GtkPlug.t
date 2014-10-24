#########################
# GtkWindow Tests
# 	- rm
#########################
#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/04.GtkSocket-GtkPlug.t,v 1.8 2003/09/22 00:04:24 rwmcfa1 Exp $
#

use strict;
use warnings;

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Gtk2;
use Test::More;

if ($^O eq 'MSWin32')
{
	plan skip_all => "socket and plug not implemented on win32";
	# ...despite patches that have been around for a long time
}
elsif( not Gtk2->init_check )
{
	plan skip_all =>
		'Gtk2->init_check failed, probably unable to open DISPLAY';
}
else
{
	plan tests => 4;
}

#########################

ok( my $win = Gtk2::Window->new );

ok( my $socket = Gtk2::Socket->new );
$win->add($socket);

ok( my $id = $socket->get_id );

my $str = "$^X -Mblib -e '\$id = $id;\n\n".<<EOL;
use Gtk2;

Gtk2->init;

\$plug = Gtk2::Plug->new($id);
\$plug->set_border_width(10);

\$btn = Gtk2::Button->new("gtk-quit");
\$btn->signal_connect( "clicked" => sub {
		Gtk2->main_quit;
		1;
	} );
\$plug->add(\$btn);

\$plug->show_all;

Glib::Timeout->add( 100, sub {
		\$btn->clicked;
		0;
	} );

Gtk2->main;'
EOL

use strict;
use warnings;

my $pid = fork;
if( $pid < 0 )
{
	die "fork failed, no use trying";
}
if( $pid == 0 )
{
	exec($str);
	exit 0;
}
else
{
	$socket->signal_connect('plug-removed' => sub {
		Gtk2->main_quit;
		1;
	});
	$win->show_all;
	Gtk2->main;
	ok( waitpid($pid, 0) );
}

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list)

This library is free software; you can redistribute it and/or modify it under
the terms of the GNU Library General Public License as published by the Free
Software Foundation; either version 2.1 of the License, or (at your option) any
later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU Library General Public License for more
details.

You should have received a copy of the GNU Library General Public License along
with this library; if not, write to the Free Software Foundation, Inc., 59
Temple Place - Suite 330, Boston, MA  02111-1307  USA.
