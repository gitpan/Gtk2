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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkCellRendererText.xs,v 1.3 2003/05/22 14:23:23 muppetman Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::CellRendererText	PACKAGE = Gtk2::CellRendererText	PREFIX = gtk_cell_renderer_text_

##GtkWidget* gtk_cell_renderer_text_new (void);
GtkCellRenderer *
gtk_cell_renderer_text_new (class)
	SV * class
    C_ARGS:

## void gtk_cell_renderer_text_set_fixed_height_from_font (GtkCellRendererText *renderer, gint number_of_rows)
void
gtk_cell_renderer_text_set_fixed_height_from_font (renderer, number_of_rows)
	GtkCellRendererText * renderer
	gint                  number_of_rows

