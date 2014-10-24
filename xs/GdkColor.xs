/*
 * Copyright (c) 2003 by the gtk2-perl team (see the file AUTHORS)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GdkColor.xs,v 1.6 2003/08/18 07:59:54 muppetman Exp $
 */

#include "gtk2perl.h"

/*
GdkColormap is a direct GObject subclass; be sure to use GdkColormap_noinc in the
proper places.

GdkColor is a plain structure treated as a boxed type.  use GdkColor_own and
GdkColor_copy in all the right places.
*/

MODULE = Gtk2::Gdk::Color	PACKAGE = Gtk2::Gdk::Colormap	PREFIX = gdk_colormap_

 ## GdkColormap* gdk_colormap_new (GdkVisual *visual, gboolean allocate)
GdkColormap_noinc*
gdk_colormap_new (visual, allocate)
	GdkVisual *visual
	gboolean allocate

 ## deprecated
 ## GdkColormap* gdk_colormap_ref (GdkColormap *cmap)
 ## deprecated
 ## void gdk_colormap_unref (GdkColormap *cmap)

 ## GdkColormap* gdk_colormap_get_system (void)
GdkColormap*
gdk_colormap_get_system (class)
	SV * class
    C_ARGS:


 ## deprecated
 ## gint gdk_colormap_get_system_size (void)

 ## gint gdk_colormap_alloc_colors (GdkColormap *colormap, GdkColor *colors, gint ncolors, gboolean writeable, gboolean best_match, gboolean *success)
## success becomes an array of TRUE or FALSE corresponding to each input
## color, telling whether each one was successfully allocated.  the return
## value is the number that were NOT allocated.
void
gdk_colormap_alloc_colors (colormap, writeable, best_match, ...)
	GdkColormap *colormap
	gboolean writeable
	gboolean best_match
    PREINIT:
	gint ncolors, i;
	GdkColor *colors = NULL;
	GdkColor **argcolors = NULL; /* so we can modify the ones passed in */
	gboolean *success = NULL;
    PPCODE:
#define first 3
	ncolors = items - first;
	if (ncolors < 1)
		XSRETURN_EMPTY;
	colors = g_new0 (GdkColor, ncolors);
	argcolors = g_new0 (GdkColor*, ncolors);
	success = g_new0 (gboolean, ncolors);
	for (i = 0 ; i < ncolors ; i++) {
		argcolors[i] = SvGdkColor (ST (first + i));
		colors[i] = *(argcolors[i]);
	}
	gdk_colormap_alloc_colors (colormap, colors, ncolors, writeable,
	                           best_match, success);
	EXTEND (SP, ncolors);
	for (i = 0 ; i < ncolors ; i++) {
		*(argcolors[i]) = colors[i];
		PUSHs (sv_2mortal (newSViv (success[i])));
	}
	g_free (colors);
	g_free (success);
#undef first

 ## gboolean gdk_colormap_alloc_color (GdkColormap *colormap, GdkColor *color, gboolean writeable, gboolean best_match)
gboolean
gdk_colormap_alloc_color (colormap, color, writeable, best_match)
	GdkColormap *colormap
	GdkColor *color
	gboolean writeable
	gboolean best_match

 # this deallocates colors in the colormap, as allocated by alloc_color(s)
 # above; it has nothing to do with memory management.  we do need this.
 ## void gdk_colormap_free_colors (GdkColormap *colormap, GdkColor *colors, gint ncolors)
void
gdk_colormap_free_colors (colormap, ...)
	GdkColormap *colormap
    PREINIT:
	GdkColor *colors;
	gint ncolors, i;
    CODE:
#define first 1
	ncolors = items - first;
	if (ncolors < 1)
		XSRETURN_EMPTY;
	colors = g_new (GdkColor, ncolors);
	for (i = 0; i < ncolors ; i++) {
		GdkColor * c = (GdkColor*) SvGdkColor (ST (i + first));
		colors[i] = *c;
	}
	gdk_colormap_free_colors (colormap, colors, ncolors);
	g_free (colors);
#undef first

 ## void gdk_colormap_query_color (GdkColormap *colormap, gulong pixel, GdkColor *result)
GdkColor_copy *
gdk_colormap_query_color (colormap, pixel)
	GdkColormap *colormap
	gulong pixel
    PREINIT:
	GdkColor result;
    CODE:
	gdk_colormap_query_color (colormap, pixel, &result);	
	RETVAL = &result;
    OUTPUT:
	RETVAL

MODULE = Gtk2::Gdk::Color	PACKAGE = Gtk2::Gdk::Color	PREFIX = gdk_color_

GdkColor_own *
gdk_color_new (class, red, green, blue)
	SV * class
	int red
	int green
	int blue
    PREINIT:
	GdkColor c;
    CODE:
	c.red = red;
	c.green = green;
	c.blue = blue;
	RETVAL = gdk_color_copy (&c);
    OUTPUT:
	RETVAL

 # unnecessary, taken care of by the GBoxed::DESTROY method
 ## void gdk_color_free (GdkColor *color)

 # can return undef if the color isn't properly parsed
 ## gint gdk_color_parse (const gchar *spec, GdkColor *color)
GdkColor_own *
gdk_color_parse (class, spec)
	SV * class
	const gchar *spec
    PREINIT:
	GdkColor c;
    CODE:
	RETVAL = gdk_color_copy (&c);
	if (!gdk_color_parse (spec, RETVAL)) {
		gdk_color_free (RETVAL);
		XSRETURN_UNDEF;
	}
    OUTPUT:
	RETVAL

 ## guint gdk_color_hash (const GdkColor *colora)
guint
gdk_color_hash (colora)
	GdkColor *colora

 ## gboolean gdk_color_equal (const GdkColor *colora, const GdkColor *colorb)
gboolean
gdk_color_equal (colora, colorb)
	GdkColor *colora
	GdkColor *colorb

 ## deprecated
 ## gint gdk_color_white (GdkColormap *colormap, GdkColor *color)
 ## deprecated
 ## gint gdk_color_black (GdkColormap *colormap, GdkColor *color)
 ## deprecated
 ## gint gdk_color_alloc (GdkColormap *colormap, GdkColor *color)
 ## deprecated
 ## gint gdk_color_change (GdkColormap *colormap, GdkColor *color)
 ## deprecated
 ## void gdk_colors_free (GdkColormap *colormap, gulong *pixels, gint npixels, gulong planes)


## accessors for struct members

guint32
gdk_color_pixel (color)
	GdkColor *color
    CODE:
	RETVAL = color->pixel;
    OUTPUT:
    	RETVAL

guint16
gdk_color_red (color)
	GdkColor *color
   CODE:
	RETVAL = color->red;
    OUTPUT:
    	RETVAL

guint16
gdk_color_green (color)
	GdkColor *color
    CODE:
	RETVAL = color->green;
    OUTPUT:
    	RETVAL

guint16
gdk_color_blue (color)
	GdkColor *color
    CODE:
	RETVAL = color->blue;
    OUTPUT:
    	RETVAL

