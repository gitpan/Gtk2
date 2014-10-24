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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkHButtonBox.xs,v 1.7 2003/09/22 00:04:25 rwmcfa1 Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::HButtonBox	PACKAGE = Gtk2::HButtonBox	PREFIX = gtk_hbutton_box_

## GtkWidget* gtk_hbutton_box_new (void)
GtkWidget *
gtk_hbutton_box_new (class)
	SV * class
    C_ARGS:
	/*void*/
    CLEANUP:
	UNUSED(class);

## GtkButtonBoxStyle gtk_hbutton_box_get_layout_default (void)
GtkButtonBoxStyle
gtk_hbutton_box_get_layout_default (class)
	SV * class
    C_ARGS:
	/*void*/
    CLEANUP:
	UNUSED(class);

## void gtk_hbutton_box_set_spacing_default (gint spacing)
void
gtk_hbutton_box_set_spacing_default (class, spacing)
	SV * class
	gint spacing
    C_ARGS:
	spacing
    CLEANUP:
	UNUSED(class);

## void gtk_hbutton_box_set_layout_default (GtkButtonBoxStyle layout)
void
gtk_hbutton_box_set_layout_default (class, layout)
	SV * class
	GtkButtonBoxStyle layout
    C_ARGS:
	layout
    CLEANUP:
	UNUSED(class);

##gint gtk_hbutton_box_get_spacing_default (void)
gint
gtk_hbutton_box_get_spacing_default (class)
	SV * class
    C_ARGS:
	/*void*/
    CLEANUP:
	UNUSED(class);

