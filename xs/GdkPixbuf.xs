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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GdkPixbuf.xs,v 1.17 2003/11/12 03:14:57 pcg Exp $
 */

#include "gtk2perl.h"

static void
gtk2perl_pixbuf_destroy_notify (guchar * pixels,
                                gpointer data)
{
	PERL_UNUSED_VAR (pixels);

	gperl_sv_free ((SV*)data);
}

MODULE = Gtk2::Gdk::Pixbuf	PACKAGE = Gtk2::Gdk::Pixbuf	PREFIX = gdk_pixbuf_

=for enum GdkPixbufAlphaMode
=cut

 ## void gdk_pixbuf_render_to_drawable (GdkPixbuf *pixbuf, GdkDrawable *drawable, GdkGC *gc, int src_x, int src_y, int dest_x, int dest_y, int width, int height, GdkRgbDither dither, int x_dither, int y_dither)
void
gdk_pixbuf_render_to_drawable (pixbuf, drawable, gc, src_x, src_y, dest_x, dest_y, width, height, dither, x_dither, y_dither)
	GdkPixbuf *pixbuf
	GdkDrawable *drawable
	GdkGC *gc
	int src_x
	int src_y
	int dest_x
	int dest_y
	int width
	int height
	GdkRgbDither dither
	int x_dither
	int y_dither

 ## void gdk_pixbuf_render_to_drawable_alpha (GdkPixbuf *pixbuf, GdkDrawable *drawable, int src_x, int src_y, int dest_x, int dest_y, int width, int height, GdkPixbufAlphaMode alpha_mode, int alpha_threshold, GdkRgbDither dither, int x_dither, int y_dither)
void
gdk_pixbuf_render_to_drawable_alpha (pixbuf, drawable, src_x, src_y, dest_x, dest_y, width, height, alpha_mode, alpha_threshold, dither, x_dither, y_dither)
	GdkPixbuf *pixbuf
	GdkDrawable *drawable
	int src_x
	int src_y
	int dest_x
	int dest_y
	int width
	int height
	GdkPixbufAlphaMode alpha_mode
	int alpha_threshold
	GdkRgbDither dither
	int x_dither
	int y_dither

=for apidoc
=for signature pixmap = $pixbuf->render_pixmap_and_mask_for_colormap ($colormap, $alpha_threshold)
=for signature (pixmap, mask) = $pixbuf->render_pixmap_and_mask_for_colormap ($colormap, $alpha_threshold)
=cut
void
gdk_pixbuf_render_pixmap_and_mask_for_colormap (pixbuf, colormap, alpha_threshold)
	GdkPixbuf *pixbuf
	GdkColormap *colormap
	int alpha_threshold
        PPCODE:
{
        GdkPixmap *pm;
        GdkBitmap *bm;

        gdk_pixbuf_render_pixmap_and_mask_for_colormap (pixbuf, colormap, &pm, GIMME_V == G_ARRAY ? &bm : 0, alpha_threshold);
        XPUSHs (newSVGdkPixmap (pm));
        if (GIMME_V == G_ARRAY)
          XPUSHs (newSVGdkBitmap (bm));
}


=for apidoc
=for signature pixmap = $pixbuf->render_pixmap_and_mask ($alpha_threshold)
=for signature (pixmap, mask) = $pixbuf->render_pixmap_and_mask ($alpha_threshold)
=cut
void
gdk_pixbuf_render_pixmap_and_mask (pixbuf, alpha_threshold)
	GdkPixbuf *pixbuf
	int alpha_threshold
        PPCODE:
{
        GdkPixmap *pm;
        GdkBitmap *bm;

        gdk_pixbuf_render_pixmap_and_mask (pixbuf, &pm, GIMME_V == G_ARRAY ? &bm : 0, alpha_threshold);
        XPUSHs (newSVGdkPixmap (pm));
        if (GIMME_V == G_ARRAY)
          XPUSHs (newSVGdkBitmap (bm));
}


##  GQuark gdk_pixbuf_error_quark (void) G_GNUC_CONST 

### handled by Glib::Object
##  GdkPixbuf *gdk_pixbuf_ref (GdkPixbuf *pixbuf) 
##  void gdk_pixbuf_unref (GdkPixbuf *pixbuf) 

##  GdkColorspace gdk_pixbuf_get_colorspace (const GdkPixbuf *pixbuf) 
GdkColorspace
gdk_pixbuf_get_colorspace (pixbuf)
	GdkPixbuf *pixbuf

##  int gdk_pixbuf_get_n_channels (const GdkPixbuf *pixbuf) 
int
gdk_pixbuf_get_n_channels (pixbuf)
	GdkPixbuf *pixbuf

##  gboolean gdk_pixbuf_get_has_alpha (const GdkPixbuf *pixbuf) 
gboolean
gdk_pixbuf_get_has_alpha (pixbuf)
	GdkPixbuf *pixbuf

##  int gdk_pixbuf_get_bits_per_sample (const GdkPixbuf *pixbuf) 
int
gdk_pixbuf_get_bits_per_sample (pixbuf)
	GdkPixbuf *pixbuf

##  guchar *gdk_pixbuf_get_pixels (const GdkPixbuf *pixbuf) 
guchar *
gdk_pixbuf_get_pixels (pixbuf)
	GdkPixbuf *pixbuf

##  int gdk_pixbuf_get_width (const GdkPixbuf *pixbuf) 
int
gdk_pixbuf_get_width (pixbuf)
	GdkPixbuf *pixbuf

##  int gdk_pixbuf_get_height (const GdkPixbuf *pixbuf) 
int
gdk_pixbuf_get_height (pixbuf)
	GdkPixbuf *pixbuf

##  int gdk_pixbuf_get_rowstride (const GdkPixbuf *pixbuf) 
int
gdk_pixbuf_get_rowstride (pixbuf)
	GdkPixbuf *pixbuf

##  GdkPixbuf *gdk_pixbuf_new (GdkColorspace colorspace, gboolean has_alpha, int bits_per_sample, int width, int height) 
GdkPixbuf_noinc *
gdk_pixbuf_new (class, colorspace, has_alpha, bits_per_sample, width, height)
	GdkColorspace colorspace
	gboolean has_alpha
	int bits_per_sample
	int width
	int height
    C_ARGS:
	colorspace, has_alpha, bits_per_sample, width, height

##  GdkPixbuf *gdk_pixbuf_copy (const GdkPixbuf *pixbuf) 
GdkPixbuf_noinc *
gdk_pixbuf_copy (pixbuf)
	GdkPixbuf *pixbuf

##  GdkPixbuf *gdk_pixbuf_new_subpixbuf (GdkPixbuf *src_pixbuf, int src_x, int src_y, int width, int height) 
GdkPixbuf_noinc *
gdk_pixbuf_new_subpixbuf (src_pixbuf, src_x, src_y, width, height)
	GdkPixbuf *src_pixbuf
	int src_x
	int src_y
	int width
	int height

##  GdkPixbuf *gdk_pixbuf_new_from_file (const char *filename, GError **error) 
GdkPixbuf_noinc *
gdk_pixbuf_new_from_file (class, filename)
	GPerlFilename filename
    PREINIT:
        GError *error = NULL;
    CODE:
	RETVAL = gdk_pixbuf_new_from_file (filename, &error);
	if (!RETVAL)
		gperl_croak_gerror (filename, error);
    OUTPUT:
	RETVAL

###  GdkPixbuf *gdk_pixbuf_new_from_data (const guchar *data, GdkColorspace colorspace, gboolean has_alpha, int bits_per_sample, int width, int height, int rowstride, GdkPixbufDestroyNotify destroy_fn, gpointer destroy_fn_data) 
=for apidoc

In C this function allows you to wrap a GdkPixbuf structure around existing
pixel data.  In Perl, we have to use C<pack> to generate a scalar containing
the pixel data, and pass that scalar to C<new_from_data>, which copies the
scalar to keep it around.  It also manages the memory automagically, so there's
no need for a destruction notifier function.  This all means that if you change
your copy of the data scalar later, the pixbuf will I<not> reflect that, but
because of the way perl manages string data and scalars, it would be pretty
fragile to do that in the first place.  If you need to modify a pixbuf's data
after it has been created, you can create new pixbufs for the changed regions
and use C<< $pixbuf->composite >>, or try a different approach (possibly use a
server-side pixmap and gdk drawing primitives, or something like libart).

=cut
GdkPixbuf_noinc *
gdk_pixbuf_new_from_data (class, data, colorspace, has_alpha, bits_per_sample, width, height, rowstride)
	SV * data
	GdkColorspace colorspace
	gboolean has_alpha
	int bits_per_sample
	int width
	int height
	int rowstride
    PREINIT:
	SV * real_data;
    CODE:
	if (!SvTRUE (data) || !SvPOK (data))
		croak ("expecting a packed string for pixel data");
	real_data = gperl_sv_copy (data);
	RETVAL = gdk_pixbuf_new_from_data (SvPV_nolen (real_data),
	                                   colorspace, has_alpha,
					   bits_per_sample,
					   width, height, rowstride,
					   gtk2perl_pixbuf_destroy_notify,
					   real_data);
    OUTPUT:
	RETVAL

##  GdkPixbuf *gdk_pixbuf_new_from_xpm_data (const char **data) 
GdkPixbuf_noinc *
gdk_pixbuf_new_from_xpm_data (class, data, ...)
    PREINIT:
	char ** lines;
	int i;
    CODE:
	lines = g_new (char *, items - 1);
	for (i = 1; i < items; i++)
		lines[i-1] = SvPV_nolen (ST (i));
	RETVAL = gdk_pixbuf_new_from_xpm_data((const char**)lines);
	g_free(lines);
    OUTPUT:
	RETVAL

## croaks on error
##  GdkPixbuf* gdk_pixbuf_new_from_inline (gint data_length, const guint8 *data, gboolean copy_pixels, GError **error) 
GdkPixbuf_noinc *
gdk_pixbuf_new_from_inline (class, data_length, data, copy_pixels)
	gint data_length
	const guchar *data
	gboolean copy_pixels
    PREINIT:
	GError * error = NULL;
    CODE:
	RETVAL = gdk_pixbuf_new_from_inline (data_length, data, 
	                                     copy_pixels, &error);
	if (!RETVAL)
		gperl_croak_gerror (NULL, error);
    OUTPUT:
	RETVAL

##  void gdk_pixbuf_fill (GdkPixbuf *pixbuf, guint32 pixel) 
void
gdk_pixbuf_fill (pixbuf, pixel)
	GdkPixbuf *pixbuf
	guint32 pixel


### croaks on error
##  gboolean gdk_pixbuf_save (GdkPixbuf *pixbuf, const char *filename, const char *type, GError **error, ...) 
void
gdk_pixbuf_save (pixbuf, filename, type, ...)
	GdkPixbuf *pixbuf
	GPerlFilename filename
	gchar *type
    PREINIT:
	GError * error = NULL;
	char ** option_keys = NULL;
	char ** option_vals = NULL;
	int i, nkeys;
	gboolean worked;
    CODE:
	/* collect key/val pairs from the argument stack and 
	 * call gdk_pixbuf_savev */
#define FIRST_KEY 3
	nkeys = (items - FIRST_KEY) / 2;
	/* always allocate them.  doesn't hurt.  always one longer for the
	 * null-terminator, which is set by g_new0. */
	option_keys = g_new0 (char *, nkeys + 1);
	option_vals = g_new0 (char *, nkeys + 1);

	for (i = 0 ; i < nkeys ; i++) {
		/* NOT copies */
		option_keys[i] = SvPV_nolen (ST (FIRST_KEY + i*2 + 0));
		option_vals[i] = SvPV_nolen (ST (FIRST_KEY + i*2 + 1));
	}

	worked = gdk_pixbuf_savev (pixbuf, filename, type, 
	                           option_keys, option_vals, &error);
	/* don't free the strings themselves! */
	g_free (option_keys);
	g_free (option_vals);
	if (!worked)
		gperl_croak_gerror (filename, error);
#undef FIRST_KEY


##  GdkPixbuf *gdk_pixbuf_add_alpha (const GdkPixbuf *pixbuf, gboolean substitute_color, guchar r, guchar g, guchar b) 
GdkPixbuf_noinc *
gdk_pixbuf_add_alpha (pixbuf, substitute_color, r, g, b)
	GdkPixbuf *pixbuf
	gboolean substitute_color
	guchar r
	guchar g
	guchar b

##  void gdk_pixbuf_copy_area (const GdkPixbuf *src_pixbuf, int src_x, int src_y, int width, int height, GdkPixbuf *dest_pixbuf, int dest_x, int dest_y) 
void
gdk_pixbuf_copy_area (src_pixbuf, src_x, src_y, width, height, dest_pixbuf, dest_x, dest_y)
	GdkPixbuf *src_pixbuf
	int src_x
	int src_y
	int width
	int height
	GdkPixbuf *dest_pixbuf
	int dest_x
	int dest_y

##  void gdk_pixbuf_saturate_and_pixelate (const GdkPixbuf *src, GdkPixbuf *dest, gfloat saturation, gboolean pixelate) 
void
gdk_pixbuf_saturate_and_pixelate (src, dest, saturation, pixelate)
	GdkPixbuf *src
	GdkPixbuf *dest
	gfloat saturation
	gboolean pixelate

##  void gdk_pixbuf_scale (const GdkPixbuf *src, GdkPixbuf *dest, int dest_x, int dest_y, int dest_width, int dest_height, double offset_x, double offset_y, double scale_x, double scale_y, GdkInterpType interp_type) 
void
gdk_pixbuf_scale (src, dest, dest_x, dest_y, dest_width, dest_height, offset_x, offset_y, scale_x, scale_y, interp_type)
	GdkPixbuf *src
	GdkPixbuf *dest
	int dest_x
	int dest_y
	int dest_width
	int dest_height
	double offset_x
	double offset_y
	double scale_x
	double scale_y
	GdkInterpType interp_type

##  void gdk_pixbuf_composite (const GdkPixbuf *src, GdkPixbuf *dest, int dest_x, int dest_y, int dest_width, int dest_height, double offset_x, double offset_y, double scale_x, double scale_y, GdkInterpType interp_type, int overall_alpha) 
void
gdk_pixbuf_composite (src, dest, dest_x, dest_y, dest_width, dest_height, offset_x, offset_y, scale_x, scale_y, interp_type, overall_alpha)
	GdkPixbuf *src
	GdkPixbuf *dest
	int dest_x
	int dest_y
	int dest_width
	int dest_height
	double offset_x
	double offset_y
	double scale_x
	double scale_y
	GdkInterpType interp_type
	int overall_alpha

##  void gdk_pixbuf_composite_color (const GdkPixbuf *src, GdkPixbuf *dest, int dest_x, int dest_y, int dest_width, int dest_height, double offset_x, double offset_y, double scale_x, double scale_y, GdkInterpType interp_type, int overall_alpha, int check_x, int check_y, int check_size, guint32 color1, guint32 color2) 
void
gdk_pixbuf_composite_color (src, dest, dest_x, dest_y, dest_width, dest_height, offset_x, offset_y, scale_x, scale_y, interp_type, overall_alpha, check_x, check_y, check_size, color1, color2)
	GdkPixbuf *src
	GdkPixbuf *dest
	int dest_x
	int dest_y
	int dest_width
	int dest_height
	double offset_x
	double offset_y
	double scale_x
	double scale_y
	GdkInterpType interp_type
	int overall_alpha
	int check_x
	int check_y
	int check_size
	guint32 color1
	guint32 color2

### returns NULL if there's not enough memory
##  GdkPixbuf *gdk_pixbuf_scale_simple (const GdkPixbuf *src, int dest_width, int dest_height, GdkInterpType interp_type) 
GdkPixbuf_noinc *
gdk_pixbuf_scale_simple (src, dest_width, dest_height, interp_type)
	GdkPixbuf *src
	int dest_width
	int dest_height
	GdkInterpType interp_type

##  GdkPixbuf *gdk_pixbuf_composite_color_simple (const GdkPixbuf *src, int dest_width, int dest_height, GdkInterpType interp_type, int overall_alpha, int check_size, guint32 color1, guint32 color2) 
GdkPixbuf *
gdk_pixbuf_composite_color_simple (src, dest_width, dest_height, interp_type, overall_alpha, check_size, color1, color2)
	GdkPixbuf *src
	int dest_width
	int dest_height
	GdkInterpType interp_type
	int overall_alpha
	int check_size
	guint32 color1
	guint32 color2


MODULE = Gtk2::Gdk::Pixbuf	PACKAGE = Gtk2::Gdk::PixbufAnimation	PREFIX = gdk_pixbuf_animation_

##  GdkPixbufAnimation *gdk_pixbuf_animation_new_from_file (const char *filename, GError **error) 
GdkPixbufAnimation_noinc *
gdk_pixbuf_animation_new_from_file (class, filename)
	GPerlFilename filename
    PREINIT:
	GError * error = NULL;
    CODE:
	RETVAL = gdk_pixbuf_animation_new_from_file (filename, &error);
	if (!RETVAL)
		gperl_croak_gerror (filename, error);
    OUTPUT:
	RETVAL

### handled by Glib::Object
###  GdkPixbufAnimation *gdk_pixbuf_animation_ref (GdkPixbufAnimation *animation) 
###  void gdk_pixbuf_animation_unref (GdkPixbufAnimation *animation) 

##  int gdk_pixbuf_animation_get_width (GdkPixbufAnimation *animation) 
int
gdk_pixbuf_animation_get_width (animation)
	GdkPixbufAnimation *animation

##  int gdk_pixbuf_animation_get_height (GdkPixbufAnimation *animation) 
int
gdk_pixbuf_animation_get_height (animation)
	GdkPixbufAnimation *animation

##  gboolean gdk_pixbuf_animation_is_static_image (GdkPixbufAnimation *animation) 
gboolean
gdk_pixbuf_animation_is_static_image (animation)
	GdkPixbufAnimation *animation

##  GdkPixbuf *gdk_pixbuf_animation_get_static_image (GdkPixbufAnimation *animation) 
GdkPixbuf *
gdk_pixbuf_animation_get_static_image (animation)
	GdkPixbufAnimation *animation

## there's no typemap for GTimeVal.
## GTimeVal is in GLib, same as unix' struct timeval.
## timeval is seconds and microseconds, which we can get from Time::HiRes.
## so, we'll take seconds and microseconds.  if neither is available,
## pass NULL to the wrapped function to get the current time.
###  GdkPixbufAnimationIter *gdk_pixbuf_animation_get_iter (GdkPixbufAnimation *animation, const GTimeVal *start_time) 
=for apidoc

The seconds and microseconds values are available from Time::HiRes, which is
standard since perl 5.8.0.  If both are undef or omitted, the function uses the
current time.

=cut
GdkPixbufAnimationIter_noinc *
gdk_pixbuf_animation_get_iter (animation, start_time_seconds=0, start_time_microseconds=0)
	GdkPixbufAnimation *animation
	guint start_time_seconds
	guint start_time_microseconds
    CODE:
	if (start_time_microseconds) {
		GTimeVal start_time;
		start_time.tv_sec = start_time_seconds;
		start_time.tv_usec = start_time_microseconds;
		RETVAL = gdk_pixbuf_animation_get_iter (animation,
		                                        &start_time);
	} else
		RETVAL = gdk_pixbuf_animation_get_iter (animation, NULL);
    OUTPUT:
	RETVAL

MODULE = Gtk2::Gdk::Pixbuf	PACKAGE = Gtk2::Gdk::PixbufAnimationIter	PREFIX = gdk_pixbuf_animation_iter_

int gdk_pixbuf_animation_iter_get_delay_time (GdkPixbufAnimationIter *iter) 

GdkPixbuf *gdk_pixbuf_animation_iter_get_pixbuf (GdkPixbufAnimationIter *iter) 

gboolean gdk_pixbuf_animation_iter_on_currently_loading_frame (GdkPixbufAnimationIter *iter) 

###  gboolean gdk_pixbuf_animation_iter_advance (GdkPixbufAnimationIter *iter, const GTimeVal *current_time) 
gboolean
gdk_pixbuf_animation_iter_advance (iter, current_time_seconds=0, current_time_microseconds=0)
	GdkPixbufAnimationIter *iter
	guint current_time_seconds
	guint current_time_microseconds
    CODE:
	if (current_time_microseconds) {
		GTimeVal current_time;
		current_time.tv_sec = current_time_seconds;
		current_time.tv_usec = current_time_microseconds;
		RETVAL = gdk_pixbuf_animation_iter_advance (iter,
		                                            &current_time);
	} else
		RETVAL = gdk_pixbuf_animation_iter_advance (iter, NULL);
     OUTPUT:
	RETVAL


MODULE = Gtk2::Gdk::Pixbuf	PACKAGE = Gtk2::Gdk::Pixbuf	PREFIX = gdk_pixbuf_

#if GTK_CHECK_VERSION(2,2,0)

## there's no typemap entry for GdkPixbufFormat, because there's no
## boxed type support.  it's an information structure, so we'll just
## hashify it so you can use Data::Dumper on it.
##
# returned strings should be freed
###  gchar *gdk_pixbuf_format_get_name (GdkPixbufFormat *format) 
###  gchar *gdk_pixbuf_format_get_description (GdkPixbufFormat *format) 
###  gchar ** gdk_pixbuf_format_get_mime_types (GdkPixbufFormat *format)
###  gchar ** gdk_pixbuf_format_get_extensions (GdkPixbufFormat *format)
###  gboolean gdk_pixbuf_format_is_writable (GdkPixbufFormat *format) 

###  GSList *gdk_pixbuf_get_formats (void) 
## list should be freed, but not formats
void
gdk_pixbuf_get_formats (class=NULL)
    PREINIT:
	GSList * formats, * i;
    PPCODE:
	formats = gdk_pixbuf_get_formats ();
	for (i = formats ; i != NULL ; i = i->next) {
		gchar * s;
		gchar ** strv;
		int j;
		AV * av;
		GdkPixbufFormat * format = (GdkPixbufFormat*) i->data;
		HV * hv = newHV ();

		s = gdk_pixbuf_format_get_name (format);
		hv_store (hv, "name", 4, newSVGChar (s), 0);
		g_free (s);

		s = gdk_pixbuf_format_get_description (format);
		hv_store (hv, "description", 11, newSVGChar (s), 0);
		g_free (s);

		strv = gdk_pixbuf_format_get_mime_types (format);
		av = newAV ();
		for (j = 0 ; strv && strv[j] ; j++)
			av_store (av, j, newSVGChar (strv[j]));
		hv_store (hv, "mime_types", 10, newRV_noinc ((SV*) av), 0);
		g_strfreev (strv);

		strv = gdk_pixbuf_format_get_extensions (format);
		av = newAV ();
		for (j = 0 ; strv && strv[j] ; j++)
			av_store (av, j, newSVGChar (strv[j]));
		hv_store (hv, "extensions", 10, newRV_noinc ((SV*) av), 0);
		g_strfreev (strv);

		XPUSHs (sv_2mortal (newRV_noinc ((SV*) hv)));
	}
	g_slist_free (formats);

#endif /* >= 2.2.0 */
