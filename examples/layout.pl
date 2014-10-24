#!/usr/bin/perl -w
#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/examples/layout.pl,v 1.4 2003/05/22 14:23:22 muppetman Exp $
#


# Copyright (c) 2003 by ross mcfarland

use strict;
use Gtk2;

use Data::Dumper;

use constant TRUE => 1;
use constant FALSE => 0;

Gtk2->init;

# Initialize GTK
Gtk2->init;

my $window = Gtk2::Window->new("toplevel");
$window->set_title("Damnit");
$window->set_default_size(640,480);

my $scwin = Gtk2::ScrolledWindow->new(undef, undef);
$scwin->set_policy('automatic', 'automatic');
$window->add($scwin);

$window->signal_connect( "destroy" => sub {
		Gtk2->main_quit;
	});

$window->set_border_width(10);

my $layout = Gtk2::Layout->new(undef,undef);
$layout->set_size(640, 480);
$scwin->add($layout);

my $btn = Gtk2::Button->new_from_stock("gtk-quit");
$btn->set_size_request(100, 50);
$layout->put($btn, 100, 120);
my $i = 1;
$btn->signal_connect( 'enter' => sub {
		print Dumper( @_ );
		if( $i > 14 )
		{
			$_[0]->set_label("Ok, Fine Then.");
			$_[0]->signal_connect( "clicked" => sub {
					Gtk2->main_quit;
				});
			return 1;
		}
		elsif( $i > 9 )
		{
			$_[0]->set_label("Quit Already!");
		}
		elsif( $i > 4 )
		{
			$_[0]->set_label("Perhaps, X");
		}
		elsif( $i > 0 )
		{
			$_[0]->set_label("Ha-Ha");
		}
		$_[1][1]->move($_[0], rand(520), rand(410));
		$i++;
		1;
	}, [ $window, $layout ]  );

$window->show_all;


# Enter the event loop
Gtk2->main;

exit 0;
