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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkImageMenuItem.xs,v 1.6 2003/09/14 20:07:43 rwmcfa1 Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::ImageMenuItem	PACKAGE = Gtk2::ImageMenuItem	PREFIX = gtk_image_menu_item_

## GtkWidget* gtk_image_menu_item_new (void)
## GtkWidget* gtk_image_menu_item_new_with_mnemonic (const gchar *label)
## GtkWidget* gtk_image_menu_item_new_with_label (const gchar *label)
GtkWidget *
gtk_image_menu_item_news (class, label=NULL)
	SV * class
	const gchar * label
    ALIAS:
	Gtk2::ImageMenuItem::new = 0
	Gtk2::ImageMenuItem::new_with_mnemonic = 1
	Gtk2::ImageMenuItem::new_with_label = 2
    CODE:
	UNUSED(class);
	if( label ) {
		if (ix == 2)
			RETVAL = gtk_image_menu_item_new_with_label (label);
		else
			RETVAL = gtk_image_menu_item_new_with_mnemonic(label);
	} else
		RETVAL = gtk_image_menu_item_new();
    OUTPUT:
	RETVAL

## GtkWidget* gtk_image_menu_item_new_from_stock (const gchar *stock_id, GtkAccelGroup *accel_group)
GtkWidget *
gtk_image_menu_item_new_from_stock (class, stock_id, accel_group)
	SV            * class
	const gchar   * stock_id
	GtkAccelGroup * accel_group
    C_ARGS:
	stock_id, accel_group
    CLEANUP:
	UNUSED(class);

## void gtk_image_menu_item_set_image (GtkImageMenuItem *image_menu_item, GtkWidget *image)
void
gtk_image_menu_item_set_image (image_menu_item, image)
	GtkImageMenuItem * image_menu_item
	GtkWidget        * image

## GtkWidget* gtk_image_menu_item_get_image (GtkImageMenuItem *image_menu_item)
GtkWidget *
gtk_image_menu_item_get_image (image_menu_item)
	GtkImageMenuItem * image_menu_item

