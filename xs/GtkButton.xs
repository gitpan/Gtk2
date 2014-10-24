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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkButton.xs,v 1.6 2003/09/14 20:07:43 rwmcfa1 Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::Button	PACKAGE = Gtk2::Button	PREFIX = gtk_button_

GtkWidget *
gtk_button_news (class, label=NULL)
	SV * class
	const gchar * label
    ALIAS:
	Gtk2::Button::new = 0
	Gtk2::Button::new_with_mnemonic = 1
	Gtk2::Button::new_with_label = 2
    CODE:
	UNUSED(class);
	if (label) {
		if (ix == 2)
			RETVAL = gtk_button_new_with_label (label);
		else
			RETVAL = gtk_button_new_with_mnemonic (label);
	} else
		RETVAL = gtk_button_new ();
    OUTPUT:
	RETVAL

GtkWidget *
gtk_button_new_from_stock (class, stock_id)
	SV * class
	const gchar * stock_id
    C_ARGS:
	stock_id
    CLEANUP:
	UNUSED(class);

void
gtk_button_pressed (button)
	GtkButton * button

void
gtk_button_released (button)
	GtkButton * button

void
gtk_button_clicked (button)
	GtkButton * button

void
gtk_button_enter (button)
	GtkButton * button

void
gtk_button_leave (button)
	GtkButton * button

void
gtk_button_set_relief (button, newstyle)
	GtkButton * button
	GtkReliefStyle  newstyle

GtkReliefStyle
gtk_button_get_relief (button)
	GtkButton * button


void
gtk_button_set_label (button, label)
	GtkButton * button
	const gchar * label

# had G_CONST_RETURN
const gchar *
gtk_button_get_label (button)
	GtkButton * button

void
gtk_button_set_use_underline (button, use_underline)
	GtkButton * button
	gboolean     use_underline

gboolean
gtk_button_get_use_underline (button)
	GtkButton * button

void
gtk_button_set_use_stock (button, use_stock)
	GtkButton * button
	gboolean     use_stock

gboolean
gtk_button_get_use_stock (button)
	GtkButton * button
