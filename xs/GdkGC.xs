/*
 * Copyright (c) 2003 by the gtk2-perl team (see the file AUTHORS)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the 
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330, 
 * Boston, MA  02111-1307  USA.
 *
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GdkGC.xs,v 1.20 2005/10/10 20:13:14 kaffeetisch Exp $
 */

#include "gtk2perl.h"

/*
 * GdkGCValues code ported from Gtk-Perl 0.7009.  There's no boxed type
 * support for this structure, but since it's only used in a couple of
 * functions in this file, we can scrape by without typemaps.
 */
SV *
newSVGdkGCValues (GdkGCValues * v)
{
	HV * h;
	SV * r;
	
	if (!v)
		return newSVsv (&PL_sv_undef);
		
	h = newHV ();
	r = newRV_noinc ((SV*)h);

	hv_store (h, "foreground", 10, newSVGdkColor_copy (&v->foreground), 0);
	hv_store (h, "background", 10, newSVGdkColor_copy (&v->background), 0);
	if (v->font) hv_store (h, "font", 4, newSVGdkFont (v->font), 0);
	hv_store (h, "function", 8, newSVGdkFunction (v->function), 0);
	hv_store (h, "fill", 4, newSVGdkFill (v->fill), 0);
	if (v->tile) hv_store (h, "tile", 4, newSVGdkPixmap (v->tile), 0);
	if (v->stipple) hv_store (h, "stipple", 7, newSVGdkPixmap (v->stipple), 0);
	if (v->clip_mask) hv_store (h, "clip_mask", 9, newSVGdkPixmap (v->clip_mask), 0);
	hv_store (h, "subwindow_mode", 14, newSVGdkSubwindowMode (v->subwindow_mode), 0);
	hv_store (h, "ts_x_origin", 11, newSViv (v->ts_x_origin), 0);
	hv_store (h, "ts_y_origin", 11, newSViv (v->ts_y_origin), 0);
	hv_store (h, "clip_x_origin", 13, newSViv (v->clip_x_origin), 0);
	hv_store (h, "clip_y_origin", 13, newSViv (v->clip_y_origin), 0);
	hv_store (h, "graphics_exposures", 18, newSViv (v->graphics_exposures), 0);
	hv_store (h, "line_width", 10, newSViv (v->line_width), 0);
	hv_store (h, "line_style", 10, newSVGdkLineStyle (v->line_style), 0);
	hv_store (h, "cap_style", 9, newSVGdkCapStyle (v->cap_style), 0);
	hv_store (h, "join_style", 10, newSVGdkJoinStyle (v->join_style), 0);
	
	return r;
}

void
SvGdkGCValues (SV * data, GdkGCValues * v, GdkGCValuesMask * m)
{
	HV * h;
	SV ** s;
	GdkGCValuesMask mask = 0;

	if ((!data) || (!SvOK (data)) || (!SvRV (data)) ||
	     (SvTYPE (SvRV (data)) != SVt_PVHV))
		return;
		
	h = (HV*) SvRV (data);

	if (!v)
		v = gperl_alloc_temp (sizeof(GdkGCValues));

	if ((s=hv_fetch (h, "foreground", 10, 0)) && SvOK (*s)) {
		v->foreground = *((GdkColor*) SvGdkColor (*s));
		mask |= GDK_GC_FOREGROUND;
	}
	if ((s=hv_fetch (h, "background", 10, 0)) && SvOK (*s)) {
		v->background = *((GdkColor*) SvGdkColor (*s));
		mask |= GDK_GC_BACKGROUND;
	}
	if ((s=hv_fetch (h, "font", 4, 0)) && SvOK (*s)) {
		v->font = SvGdkFont (*s);
		mask |= GDK_GC_FONT;
	}
	if ((s=hv_fetch (h, "function", 8, 0)) && SvOK (*s)) {
		v->function = SvGdkFunction (*s);
		mask |= GDK_GC_FUNCTION;
	}
	if ((s=hv_fetch (h, "fill", 4, 0)) && SvOK (*s)) {
		v->fill = SvGdkFill (*s);
		mask |= GDK_GC_FILL;
	}
	if ((s=hv_fetch (h, "tile", 4, 0)) && SvOK (*s)) {
		v->tile = SvGdkPixmap (*s);
		mask |= GDK_GC_TILE;
	}
	if ((s=hv_fetch (h, "stipple", 7, 0)) && SvOK (*s)) {
		v->stipple = SvGdkPixmap (*s);
		mask |= GDK_GC_STIPPLE;
	}
	if ((s=hv_fetch (h, "clip_mask", 9, 0)) && SvOK (*s)) {
		v->clip_mask = SvGdkPixmap (*s);
		mask |= GDK_GC_CLIP_MASK;
	}
	if ((s=hv_fetch (h, "subwindow_mode", 14, 0)) && SvOK (*s)) {
		v->subwindow_mode = SvGdkSubwindowMode (*s);
		mask |= GDK_GC_SUBWINDOW;
	}
	if ((s=hv_fetch (h, "ts_x_origin", 11, 0)) && SvOK (*s)) {
		v->ts_x_origin = SvIV (*s);
		mask |= GDK_GC_TS_X_ORIGIN;
	}
	if ((s=hv_fetch (h, "ts_y_origin", 11, 0)) && SvOK (*s)) {
		v->ts_y_origin = SvIV (*s);
		mask |= GDK_GC_TS_Y_ORIGIN;
	}
	if ((s=hv_fetch (h, "clip_x_origin", 13, 0)) && SvOK (*s)) {
		v->clip_x_origin = SvIV (*s);
		mask |= GDK_GC_CLIP_X_ORIGIN;
	}
	if ((s=hv_fetch (h, "clip_y_origin", 13, 0)) && SvOK (*s)) {
		v->clip_y_origin = SvIV (*s);
		mask |= GDK_GC_CLIP_Y_ORIGIN;
	}
	if ((s=hv_fetch (h, "graphics_exposures", 18, 0)) && SvOK (*s)) {
		v->graphics_exposures = SvIV (*s);
		mask |= GDK_GC_EXPOSURES;
	}
	if ((s=hv_fetch (h, "line_width", 10, 0)) && SvOK (*s)) {
		v->line_width= SvIV (*s);
		mask |= GDK_GC_LINE_WIDTH;
	}
	if ((s=hv_fetch (h, "line_style", 10, 0)) && SvOK (*s)) {
		v->line_style= SvGdkLineStyle (*s);
		mask |= GDK_GC_LINE_STYLE;
	}
	if ((s=hv_fetch (h, "cap_style", 9, 0)) && SvOK (*s)) {
		v->cap_style = SvGdkCapStyle (*s);
		mask |= GDK_GC_CAP_STYLE;
	}
	if ((s=hv_fetch (h, "join_style", 10, 0)) && SvOK (*s)) {
		v->join_style = SvGdkJoinStyle (*s);
		mask |= GDK_GC_JOIN_STYLE;
	}

	if (m)
		*m = mask;
}

MODULE = Gtk2::Gdk::GC	PACKAGE = Gtk2::Gdk::GC	PREFIX = gdk_gc_

BOOT:
	/* the gdk backends override the public GdkGC with private,
	 * back-end-specific types.  tell gperl_get_object not to 
	 * complain about them.  */
	gperl_object_set_no_warn_unreg_subclass (GDK_TYPE_GC, TRUE);



 ## taken care of by typemaps
 ## void gdk_gc_unref (GdkGC *gc)

 ##GdkGC * gdk_gc_new (GdkDrawable * drawable);
 ##GdkGC * gdk_gc_new_with_values (GdkDrawable * drawable, GdkGCValues * values);
GdkGC_noinc*
gdk_gc_new (class, GdkDrawable * drawable, SV * values=NULL)
    ALIAS:
	new_with_values = 1
    CODE:
	if (values && SvOK (values)) {
		GdkGCValuesMask m;
		GdkGCValues v;
		SvGdkGCValues (values, &v, &m);
		RETVAL = gdk_gc_new_with_values (drawable, &v, m);
	} else {
		if (ix == 1)
			warn ("passed empty values to new_with_values");
		RETVAL = gdk_gc_new (drawable);
	}
    OUTPUT:
	RETVAL


# ## void gdk_gc_get_values (GdkGC *gc, GdkGCValues *values)
SV *
gdk_gc_get_values (gc)
	GdkGC *gc
    PREINIT:
	GdkGCValues values;
    CODE:
	gdk_gc_get_values (gc, &values);
	RETVAL = newSVGdkGCValues (&values);
    OUTPUT:
	RETVAL

 ## void gdk_gc_set_values (GdkGC *gc, GdkGCValues *values, GdkGCValuesMask values_mask)
void
gdk_gc_set_values (gc, values)
	GdkGC *gc
	SV *values
    PREINIT:
	GdkGCValues v;
	GdkGCValuesMask m;
    CODE:
	SvGdkGCValues (values, &v, &m);
	gdk_gc_set_values (gc, &v, m);

 ## void gdk_gc_set_foreground (GdkGC *gc, GdkColor *color)
void
gdk_gc_set_foreground (gc, color)
	GdkGC *gc
	GdkColor *color

 ## void gdk_gc_set_background (GdkGC *gc, GdkColor *color)
void
gdk_gc_set_background (gc, color)
	GdkGC *gc
	GdkColor *color

 ## void gdk_gc_set_font (GdkGC *gc, GdkFont *font)
void
gdk_gc_set_font (gc, font)
	GdkGC *gc
	GdkFont *font

 ## void gdk_gc_set_function (GdkGC *gc, GdkFunction function)
void
gdk_gc_set_function (gc, function)
	GdkGC *gc
	GdkFunction function

 ## void gdk_gc_set_fill (GdkGC *gc, GdkFill fill)
void
gdk_gc_set_fill (gc, fill)
	GdkGC *gc
	GdkFill fill

 ## void gdk_gc_set_tile (GdkGC *gc, GdkPixmap *tile)
void
gdk_gc_set_tile (gc, tile)
	GdkGC *gc
	GdkPixmap *tile

 ## void gdk_gc_set_stipple (GdkGC *gc, GdkPixmap *stipple)
void
gdk_gc_set_stipple (gc, stipple)
	GdkGC *gc
	GdkPixmap *stipple

 ## void gdk_gc_set_ts_origin (GdkGC *gc, gint x, gint y)
void
gdk_gc_set_ts_origin (gc, x, y)
	GdkGC *gc
	gint x
	gint y

 ## void gdk_gc_set_clip_origin (GdkGC *gc, gint x, gint y)
void
gdk_gc_set_clip_origin (gc, x, y)
	GdkGC *gc
	gint x
	gint y

 ## void gdk_gc_set_clip_mask (GdkGC *gc, GdkBitmap *mask)
void
gdk_gc_set_clip_mask (gc, mask)
	GdkGC *gc
	SV *mask
    CODE:
	gdk_gc_set_clip_mask (gc, SvGdkBitmap_ornull (mask));

 ## void gdk_gc_set_clip_rectangle (GdkGC *gc, GdkRectangle *rectangle)
void
gdk_gc_set_clip_rectangle (gc, rectangle)
	GdkGC *gc
	GdkRectangle_ornull *rectangle

 ## void gdk_gc_set_clip_region (GdkGC *gc, GdkRegion *region)
void
gdk_gc_set_clip_region (gc, region)
	GdkGC *gc
	GdkRegion_ornull *region

 ## void gdk_gc_set_subwindow (GdkGC *gc, GdkSubwindowMode mode)
void
gdk_gc_set_subwindow (gc, mode)
	GdkGC *gc
	GdkSubwindowMode mode

 ## void gdk_gc_set_exposures (GdkGC *gc, gboolean exposures)
void
gdk_gc_set_exposures (gc, exposures)
	GdkGC *gc
	gboolean exposures

 ## void gdk_gc_set_line_attributes (GdkGC *gc, gint line_width, GdkLineStyle line_style, GdkCapStyle cap_style, GdkJoinStyle join_style)
void
gdk_gc_set_line_attributes (gc, line_width, line_style, cap_style, join_style)
	GdkGC *gc
	gint line_width
	GdkLineStyle line_style
	GdkCapStyle cap_style
	GdkJoinStyle join_style

 ## void gdk_gc_set_dashes (GdkGC *gc, gint dash_offset, gint8 dash_list[], gint n)
=for apidoc
=for arg ... of integers, the length of the dash segments
Sets the way dashed-lines are drawn. Lines will be drawn with alternating on
and off segments of the lengths specified in list of dashes. The manner in
which the on and off segments are drawn is determined by the line_style value
of the GC.
=cut
void
gdk_gc_set_dashes (gc, dash_offset, ...)
	GdkGC * gc
	gint    dash_offset
    PREINIT:
	gint8 * dash_list;
	gint    n;
    CODE:
	n = --items-1;
	dash_list = g_new(gint8, n);
	for( ; items > 1; items-- )
		dash_list[items-2] = (gint8) SvIV(ST(items));
	gdk_gc_set_dashes(gc, dash_offset, dash_list, n);
	g_free(dash_list);

 ## void gdk_gc_offset (GdkGC *gc, gint x_offset, gint y_offset)
void
gdk_gc_offset (gc, x_offset, y_offset)
	GdkGC *gc
	gint x_offset
	gint y_offset

 ## void gdk_gc_copy (GdkGC *dst_gc, GdkGC *src_gc)
void
gdk_gc_copy (dst_gc, src_gc)
	GdkGC *dst_gc
	GdkGC *src_gc

 ## void gdk_gc_set_colormap (GdkGC *gc, GdkColormap *colormap)
void
gdk_gc_set_colormap (gc, colormap)
	GdkGC *gc
	GdkColormap *colormap

 ##  GdkColormap *colormap gdk_gc_get_colormap (GdkGC *gc)
GdkColormap *
gdk_gc_get_colormap (gc)
	GdkGC *gc

 ## void gdk_gc_set_rgb_fg_color (GdkGC *gc, GdkColor *color)
void
gdk_gc_set_rgb_fg_color (gc, color)
	GdkGC *gc
	GdkColor *color

 ## void gdk_gc_set_rgb_bg_color (GdkGC *gc, GdkColor *color)
void
gdk_gc_set_rgb_bg_color (gc, color)
	GdkGC *gc
	GdkColor *color

#if GTK_CHECK_VERSION(2,2,0)

 ## GdkScreen * gdk_gc_get_screen (GdkGC *gc)
GdkScreen *
gdk_gc_get_screen (gc)
	GdkGC *gc

#endif /* have GdkScreen */
