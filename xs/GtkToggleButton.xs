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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkToggleButton.xs,v 1.5 2003/05/22 14:23:24 muppetman Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::ToggleButton	PACKAGE = Gtk2::ToggleButton	PREFIX = gtk_toggle_button_

GtkWidget*
gtk_toggle_button_news (class, label=NULL)
	SV * class
	const gchar * label
    ALIAS:
	Gtk2::ToggleButton::new = 0
	Gtk2::ToggleButton::new_with_mnemonic = 1
	Gtk2::ToggleButton::new_with_label = 2
    CODE:
	if (label) {
		if (ix == 2)
			RETVAL = gtk_toggle_button_new_with_label (label);
		else
			RETVAL = gtk_toggle_button_new_with_mnemonic (label);
	} else
		RETVAL = gtk_toggle_button_new ();
    OUTPUT:
	RETVAL

void
gtk_toggle_button_set_mode (toggle_button, draw_indicator)
	GtkToggleButton *toggle_button
	gboolean draw_indicator

gboolean
gtk_toggle_button_get_mode (toggle_button)
	GtkToggleButton *toggle_button

void
gtk_toggle_button_set_active (toggle_button, is_active)
	GtkToggleButton *toggle_button
	gboolean is_active

gboolean
gtk_toggle_button_get_active (toggle_button)
	GtkToggleButton *toggle_button

void
gtk_toggle_button_toggled (toggle_button)
	GtkToggleButton *toggle_button

void
gtk_toggle_button_set_inconsistent (toggle_button, setting)
	GtkToggleButton *toggle_button
	gboolean setting

gboolean
gtk_toggle_button_get_inconsistent (toggle_button)
	GtkToggleButton *toggle_button

