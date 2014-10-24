#!/usr/bin/perl -w
use strict;
use Glib qw/TRUE FALSE/;
use Gtk2;
use Test::More;

eval "use Cairo";

if (!$@ && Gtk2::Pango -> CHECK_VERSION(1, 10, 0)) {
  plan tests => 10;
} else {
  plan skip_all => "Need Cairo";
}

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/PangoCairo.t,v 1.1 2005/09/29 22:43:30 kaffeetisch Exp $

my $fontmap = Gtk2::Pango::Cairo::FontMap -> new();
isa_ok($fontmap, "Gtk2::Pango::Cairo::FontMap");
isa_ok($fontmap, "Gtk2::Pango::FontMap");

$fontmap = Gtk2::Pango::Cairo::FontMap -> get_default();
isa_ok($fontmap, "Gtk2::Pango::Cairo::FontMap");
isa_ok($fontmap, "Gtk2::Pango::FontMap");

$fontmap -> set_resolution(72);
is($fontmap -> get_resolution(), 72);

my $context = $fontmap -> create_context();
isa_ok($context, "Gtk2::Pango::Context");

# Just to make sure this is a valid Gtk2::Pango::FontMap
isa_ok(($fontmap -> list_families())[0], "Gtk2::Pango::FontFamily");

my $target = Cairo::ImageSurface -> create("argb32", 100, 100);
my $cr = Cairo::Context -> create($target);

Gtk2::Pango::Cairo::update_context($cr, $context);

my $options = Cairo::FontOptions -> create();

Gtk2::Pango::Cairo::Context::set_font_options($context, $options);
isa_ok(Gtk2::Pango::Cairo::Context::get_font_options($context),
       "Cairo::FontOptions");

Gtk2::Pango::Cairo::Context::set_resolution($context, 72);
is(Gtk2::Pango::Cairo::Context::get_resolution($context), 72);

my $layout = Gtk2::Pango::Cairo::create_layout($cr);
isa_ok($layout, "Gtk2::Pango::Layout");

Gtk2::Pango::Cairo::update_layout($cr, $layout);
Gtk2::Pango::Cairo::show_layout($cr, $layout);
Gtk2::Pango::Cairo::layout_path($cr, $layout);

# FIXME: Test pango_cairo_show_glyph_string, pango_cairo_glyph_string_path,
# pango_cairo_show_layout_line, pango_cairo_layout_line_path.

__END__

Copyright (C) 2005 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
