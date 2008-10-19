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
 * $Id: GtkSeparatorMenuItem.xs,v 1.7 2008/10/05 12:49:35 kaffeetisch Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::SeparatorMenuItem	PACKAGE = Gtk2::SeparatorMenuItem	PREFIX = gtk_separator_menu_item_

## GtkWidget* gtk_separator_menu_item_new (void)
GtkWidget *
gtk_separator_menu_item_new (class)
    C_ARGS:
	/* void */

