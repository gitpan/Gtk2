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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkCheckButton.xs,v 1.6 2003/07/08 20:47:46 rwmcfa1 Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::CheckButton	PACKAGE = Gtk2::CheckButton	PREFIX = gtk_check_button_

## GtkWidget* gtk_check_button_new (void)
## GtkWidget* gtk_check_button_new_with_mnemonic (const gchar *label)
## GtkWidget* gtk_check_button_new_with_label (const gchar *label)
GtkWidget*
gtk_check_button_news (class, label=NULL)
	SV * class
	const gchar * label
    ALIAS:
	Gtk2::CheckButton::new = 0
	Gtk2::CheckButton::new_with_mnemonic = 1
	Gtk2::CheckButton::new_with_label = 2
    CODE:
	if (label) {
		if (ix == 2)
			RETVAL = gtk_check_button_new_with_label (label);
		else /* if (ix == 1) */
			RETVAL = gtk_check_button_new_with_mnemonic (label);
	} else
		RETVAL = gtk_check_button_new ();
    OUTPUT:
	RETVAL

## void _gtk_check_button_get_props (GtkCheckButton *check_button, gint *indicator_size, gint *indicator_spacing)
