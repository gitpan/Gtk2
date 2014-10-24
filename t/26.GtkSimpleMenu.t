#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/26.GtkSimpleMenu.t,v 1.4 2003/11/29 17:20:46 rwmcfa1 Exp $
#

use strict;
use warnings;

#########################
# GtkSimpleMenu Tests
# 	- rm
#########################

use Gtk2;
use Test::More;

if( Gtk2->init_check )
{
	plan tests => 43;
	require_ok( 'Gtk2::SimpleMenu' );
}
else
{
	plan skip_all =>
		'Gtk2->init_check failed, probably unable to open DISPLAY';
}

#########################

require './t/ignore_keyboard.pl';

use Data::Dumper;

sub callback
{
	ok(1) unless( $_[1] % 2 );
}

sub default_callback
{
	ok(1) if( $_[1] % 2 );
}

my $action = 0;
my $menu_tree = [
	_File  => {
		item_type  => '<Branch>',
		children => [
			_New       => {
				callback => \&callback,
				callback_action => $action++,
				accelerator => '<ctrl>N',
			},
			_Save      => {
				callback_action => $action++,
				accelerator => '<ctrl>S',
			},
			'Save _As' => {
				callback => \&callback,
				callback_action => $action++,
				accelerator => '<ctrl>A',
			},
			_Exit      => {
				callback => sub { ok(1); Gtk2->main_quit; },
				callback_action => $action++,
				accelerator => '<ctrl>E',
			},
		],
	},
	_Edit  => {
		item_type => '<Branch>',
		children => [
			_Copy  => {
				callback => \&callback,
				callback_action => $action++,
			},
			_Paste => {
				callback_action => $action++,
			},
		],
	},
	_Tools => {
		item_type => '<Branch>',
		children => [
			_Tearoff => {
				item_type => '<Tearoff>',
			},
			_CheckItem => {
				callback => \&callback,
				callback_action => $action++,
				item_type => '<CheckItem>',
			},
			_ToggleItem => {
				callback_action => $action++,
				item_type => '<ToggleItem>',
			},
			_StockItem => {
				callback => \&callback,
				callback_action => $action++,
				item_type => '<StockItem>',
				extra_data => 'gtk-execute',
			},
			_Radios => {
				item_type => '<Branch>',
				children => [
					'Radio _1' => {
						callback_action => $action++,
						item_type  => '<RadioItem>',
						groupid => 1,
					},
					'Radio _2' => {
						callback => \&callback,
						callback_action => $action++,
						item_type  => '<RadioItem>',
						groupid => 1,
					},
					'Radio _3' => {
						callback_action => $action++,
						item_type  => '<RadioItem>',
						groupid => 1,
					},
				],
			},
			Separator => {
				item_type => '<Separator>',
			},
#			image menu item types are not supported at this point
#			_Image => {
#				callback => \&callback,
#				callback_action => $action++,
#				item_type => '<ImageItem>',
#			},
		],
	},
	_Help  => {
		item_type => '<Branch>',
		children => [
			_Introduction => {
				callback => \&callback,
				callback_action => $action++,
			},
			_About        => {
				callback_action => $action++,
			}
		],
	},
];

ok( my $menu = Gtk2::SimpleMenu->new(
				menu_tree        => $menu_tree,
				default_callback => \&default_callback,
				user_data        => 'user data',
				keep_entries     => 1,
				keep_menu_tree   => 1,
			) );

ok( $menu->{widget} );
ok( $menu->{accel_group} );
ok( $menu->{entries} );
ok( $menu->{menu_tree} );

ok( my $rdo = $menu->get_widget('/Tools/Radios/Radio 2') );
$rdo->set_active(1);

my $win = Gtk2::Window->new;

$win->add($menu->{widget});
ok(1);

$win->add_accel_group($menu->{accel_group});
ok(1);

Glib::Idle->add( sub {
		my $tmp;
		foreach (@{$menu->{entries}})
		{
			$tmp = $_->[4];
			unless( $tmp eq '<Branch>' 
			    or $tmp eq '<Tearoff>' 
	    		    or $tmp eq '<Separator>' )
			{
				$tmp = $_->[0];
				$tmp =~ s/_//g;
				if( $tmp ne '/File/Exit' )
				{
					ok( $tmp = $menu->get_widget ($tmp) );
					$tmp->activate;
				}
			}
		}
		ok( $tmp = $menu->get_widget ('/File/Exit') );
		$tmp->activate;
	});

$win->show_all;
Gtk2->main;
ok(1);

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
