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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkImage.xs,v 1.9 2003/09/14 20:07:43 rwmcfa1 Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::Image	PACKAGE = Gtk2::Image	PREFIX = gtk_image_

GtkWidget*
gtk_image_new (class)
	SV * class
    C_ARGS:
	/*void*/
    CLEANUP:
	UNUSED(class);

 ## GtkWidget* gtk_image_new_from_pixmap (GdkPixmap *pixmap, GdkBitmap *mask)
GtkWidget*
gtk_image_new_from_pixmap (class, pixmap, mask)
	SV * class
	GdkPixmap_ornull * pixmap
	GdkBitmap_ornull * mask
    C_ARGS:
	pixmap, mask
    CLEANUP:
	UNUSED(class);

 ## GtkWidget* gtk_image_new_from_image (GdkImage *image, GdkBitmap *mask)
GtkWidget*
gtk_image_new_from_image (class, image, mask)
	SV * class
	GdkImage_ornull *image
	GdkBitmap_ornull *mask
    C_ARGS:
	image, mask
    CLEANUP:
	UNUSED(class);

GtkWidget*
gtk_image_new_from_file (class, filename)
	SV * class
	const gchar *filename
    C_ARGS:
	filename
    CLEANUP:
	UNUSED(class);

 ## GtkWidget* gtk_image_new_from_pixbuf (GdkPixbuf *pixbuf)
GtkWidget*
gtk_image_new_from_pixbuf (class, pixbuf)
	SV * class
	GdkPixbuf_ornull * pixbuf
    C_ARGS:
	pixbuf
    CLEANUP:
	UNUSED(class);

GtkWidget*
gtk_image_new_from_stock (class, stock_id, size)
	SV * class
	const gchar *stock_id
	GtkIconSize size
    C_ARGS:
	stock_id, size
    CLEANUP:
	UNUSED(class);
 
 ## GtkWidget* gtk_image_new_from_icon_set (GtkIconSet *icon_set, GtkIconSize size)
GtkWidget*
gtk_image_new_from_icon_set (class, icon_set, size)
	SV * class
	GtkIconSet *icon_set
	GtkIconSize size
    C_ARGS:
	icon_set, size
    CLEANUP:
	UNUSED(class);

 ## GtkWidget* gtk_image_new_from_animation (GdkPixbufAnimation *animation)
GtkWidget*
gtk_image_new_from_animation (SV * class, GdkPixbufAnimation *animation)
    C_ARGS:
	animation
    CLEANUP:
	UNUSED(class);

 ## void gtk_image_set_from_pixmap (GtkImage *image, GdkPixmap *pixmap, GdkBitmap *mask)
void
gtk_image_set_from_pixmap (image, pixmap, mask)
	GtkImage * image
	GdkPixmap_ornull * pixmap
	GdkBitmap_ornull * mask

void
gtk_image_set_from_image (image, gdk_image, mask)
	GtkImage *image
	GdkImage_ornull *gdk_image
	GdkBitmap_ornull *mask

void
gtk_image_set_from_file (image, filename)
	GtkImage *image
	const gchar *filename

void
gtk_image_set_from_pixbuf (image, pixbuf)
	GtkImage *image
	GdkPixbuf_ornull *pixbuf

void
gtk_image_set_from_stock (image, stock_id, size)
	GtkImage *image
	const gchar *stock_id
	GtkIconSize size

void
gtk_image_set_from_icon_set (image, icon_set, size)
	GtkImage *image
	GtkIconSet *icon_set
	GtkIconSize size

void
gtk_image_set_from_animation (GtkImage *image, GdkPixbufAnimation *animation)

GtkImageType
gtk_image_get_storage_type (image)
	GtkImage *image

 ## void gtk_image_get_pixmap (GtkImage *image, GdkPixmap **pixmap, GdkBitmap **mask)
void gtk_image_get_pixmap (GtkImage *image, OUTLIST GdkPixmap * pixmap, OUTLIST GdkBitmap * mask)

 ## void gtk_image_get_image (GtkImage *image, GdkImage **gdk_image, GdkBitmap **mask)
void gtk_image_get_image (GtkImage *image, OUTLIST GdkImage *gdk_image, OUTLIST GdkBitmap *mask)

GdkPixbuf*
gtk_image_get_pixbuf (image)
	GtkImage *image

void
gtk_image_get_stock (image)
	GtkImage *image
    PREINIT:
	gchar *stock_id;
	GtkIconSize size;
    PPCODE:
	gtk_image_get_stock (image, &stock_id, &size);
	EXTEND (SP, 2);
	PUSHs (sv_2mortal (newSVpv (stock_id, 0)));
	PUSHs (sv_2mortal (newSVGtkIconSize (size)));

 ## void gtk_image_get_icon_set (GtkImage *image, GtkIconSet **icon_set, GtkIconSize *size)
void gtk_image_get_icon_set (GtkImage *image, OUTLIST GtkIconSet *icon_set, OUTLIST GtkIconSize size)

GdkPixbufAnimation* gtk_image_get_animation (GtkImage *image)

# deprecated
 ## void gtk_image_get (GtkImage *image, GdkImage **val, GdkBitmap **mask)
 ##void gtk_image_set (GtkImage *image, GdkImage *val, GdkBitmap *mask)

