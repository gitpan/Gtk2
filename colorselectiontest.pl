#!/usr/bin/perl -w
#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/colorselectiontest.pl,v 1.3 2003/05/17 13:31:01 rwmcfa1 Exp $
#

use Gtk2;

Gtk2->init;

my @colors = (
	Gtk2::Gdk::Color->new (0,0,0),
	Gtk2::Gdk::Color->new (65535,0,0),
	Gtk2::Gdk::Color->new (0,65535,0),
	Gtk2::Gdk::Color->new (0,0,65535),
	Gtk2::Gdk::Color->new (65535,65535,65535),
);

my $string = Gtk2::ColorSelection->palette_to_string (@colors);
@colors = Gtk2::ColorSelection->palette_from_string ($string);

use Data::Dumper;
print "$string\n" . Dumper (\@colors)."\n";
