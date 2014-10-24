/*
 * Copyright (c) 2005 by the gtk2-perl team (see the file AUTHORS)
 *
 * Licensed under the LGPL, see LICENSE file for more information.
 *
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/PangoCairo.xs,v 1.4 2006/08/07 18:36:11 kaffeetisch Exp $
 */

#include "gtk2perl.h"
#include <cairo-perl.h>

MODULE = Gtk2::Pango::Cairo	PACKAGE = Gtk2::Pango::Cairo::FontMap	PREFIX = pango_cairo_font_map_

BOOT:
	gperl_set_isa ("Gtk2::Pango::Cairo::FontMap", "Gtk2::Pango::FontMap");

# PangoFontMap *pango_cairo_font_map_new (void);
SV *
pango_cairo_font_map_new (class)
    ALIAS:
	Gtk2::Pango::Cairo::FontMap::get_default = 1
    PREINIT:
	PangoFontMap *fontmap;
	HV *stash;
    CODE:
	switch (ix) {
	    case 0:
		fontmap = pango_cairo_font_map_new ();
		RETVAL = newSVPangoFontMap_noinc (fontmap);
		break;

	    case 1:
		fontmap = pango_cairo_font_map_get_default();
		RETVAL = newSVPangoFontMap (fontmap);
		break;

	    default:
		fontmap = NULL; stash = NULL; RETVAL = NULL;
		g_assert_not_reached ();
	}

	stash = gperl_object_stash_from_type (PANGO_TYPE_CAIRO_FONT_MAP);
	sv_bless (RETVAL, stash);
    OUTPUT:
	RETVAL

void pango_cairo_font_map_set_resolution (PangoCairoFontMap *fontmap, double dpi);

double pango_cairo_font_map_get_resolution (PangoCairoFontMap *fontmap);

PangoContext *pango_cairo_font_map_create_context (PangoCairoFontMap *fontmap);

# --------------------------------------------------------------------------- #

MODULE = Gtk2::Pango::Cairo	PACKAGE = Gtk2::Pango::Cairo	PREFIX = pango_cairo_

void pango_cairo_update_context (cairo_t *cr, PangoContext *context);

PangoLayout *pango_cairo_create_layout (cairo_t *cr);

void pango_cairo_update_layout (cairo_t *cr, PangoLayout *layout);

void pango_cairo_show_glyph_string (cairo_t *cr, PangoFont *font, PangoGlyphString *glyphs);

# FIXME: Need PangoLayoutLine support.
# void pango_cairo_show_layout_line (cairo_t *cr, PangoLayoutLine *line);

void pango_cairo_show_layout (cairo_t *cr, PangoLayout *layout);

void pango_cairo_glyph_string_path (cairo_t *cr, PangoFont *font, PangoGlyphString *glyphs);

# FIXME: Need PangoLayoutLine support.
# void pango_cairo_layout_line_path (cairo_t *cr, PangoLayoutLine *line);

void pango_cairo_layout_path (cairo_t *cr, PangoLayout *layout);

#if PANGO_CHECK_VERSION (1, 14, 0)

void pango_cairo_show_error_underline (cairo_t *cr, double x, double y, double width, double height);

void pango_cairo_error_underline_path (cairo_t *cr, double x, double y, double width, double height);

#endif

MODULE = Gtk2::Pango::Cairo	PACKAGE = Gtk2::Pango::Cairo::Context	PREFIX = pango_cairo_context_

void pango_cairo_context_set_font_options (PangoContext *context, const cairo_font_options_t *options);

# const cairo_font_options_t *pango_cairo_context_get_font_options (PangoContext *context);
const cairo_font_options_t *pango_cairo_context_get_font_options (PangoContext *context);
    CODE:
	RETVAL = cairo_font_options_copy (
			pango_cairo_context_get_font_options (context));
    OUTPUT:
	RETVAL

void pango_cairo_context_set_resolution (PangoContext *context, double dpi);

double pango_cairo_context_get_resolution (PangoContext *context);
