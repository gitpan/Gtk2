#!/usr/bin/perl -w
#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/examples/colorselectiontest.pl,v 1.1 2003/07/02 20:30:04 rwmcfa1 Exp $
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
