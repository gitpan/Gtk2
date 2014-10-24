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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkHScrollBar.xs,v 1.5 2003/09/14 20:07:43 rwmcfa1 Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::HScrollBar	PACKAGE = Gtk2::HScrollBar	PREFIX = gtk_hscrollbar_

## GtkWidget* gtk_hscrollbar_new (GtkAdjustment *adjustment)
GtkWidget *
gtk_hscrollbar_new (class, adjustment=NULL)
	SV            * class
	GtkAdjustment_ornull * adjustment
    C_ARGS:
	adjustment
    CLEANUP:
	UNUSED(class);

