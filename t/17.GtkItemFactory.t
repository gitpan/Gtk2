#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/17.GtkItemFactory.t,v 1.3 2003/08/19 14:25:13 rwmcfa1 Exp $
#

#########################
# Gtk2::ItemFactory Tests
# 	- rm
#########################

#########################

use Gtk2;
use Test::More;

if( Gtk2->init_check )
{
	plan tests => 9;
}
else
{
	plan skip_all =>
		'Gtk2->init_check failed, probably unable to open DISPLAY';
}

#########################

my @actions_used = (qw/1 0 0 0 0/);
my @items = (
	[
		'/_Menu',
		undef,
		undef,
		undef,
		'<Branch>',
	],
	[
		'/_Menu/Test _1',
		undef,
		\&callback,
		1,
		'<StockItem>',
		'gtk-execute'
	],
	{
		path => '/_Menu/Test _2',
		callback => \&callback,
		callback_action => 2,
		item_type => '<StockItem>',
		extra_data => 'gtk-execute'
	},
	{
		path => '/_Menu/Sub _Menu',
		item_type => '<Branch>',
	},
	[
		'/_Menu/Sub Menu/Test _1',
		undef,
		\&callback,
		3,
		'<StockItem>',
		'gtk-execute'
	],
	[
		'/_Menu/Sub Menu/Test _2',
		undef,
		sub { $actions_used[4]++; },
		undef,
		undef,
	],
	[
		'/_Menu/_Quit',
		undef,
		sub { Gtk2->main_quit; },
		5,
		'<StockItem>',
		'gtk-quit'
	],
);

sub callback
{
	shift;
	$actions_used[shift]++;
}

ok( Gtk2->init );

ok( my $win = Gtk2::Window->new );

ok( my $fac = Gtk2::ItemFactory->new('Gtk2::MenuBar', '<main>', undef) );

$fac->create_items(44, @items);

ok( my $menu = $fac->get_widget('<main>') );

$win->add($menu);

$win->show_all;

Glib::Idle->add( sub {
		$fac->get_widget('/Menu/Test 1')->activate;
		$fac->get_widget('/Menu/Test 2')->activate;
		$fac->get_widget('/Menu/Sub Menu/Test 1')->activate;
		$fac->get_widget('/Menu/Sub Menu/Test 2')->activate;
		$fac->get_widget('/Menu/Quit')->activate;
	});

Gtk2->main;

foreach (@actions_used)
{
	ok( $_ );
}
