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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkStatusbar.xs,v 1.4 2003/09/14 20:07:43 rwmcfa1 Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::Statusbar	PACKAGE = Gtk2::Statusbar	PREFIX = gtk_statusbar_

## GtkWidget* gtk_statusbar_new (void)
GtkWidget *
gtk_statusbar_new (class)
	SV * class
    C_ARGS:
	/* void */
    CLEANUP:
	UNUSED(class);

## void gtk_statusbar_pop (GtkStatusbar *statusbar, guint context_id)
void
gtk_statusbar_pop (statusbar, context_id)
	GtkStatusbar * statusbar
	guint          context_id

## void gtk_statusbar_remove (GtkStatusbar *statusbar, guint context_id, guint message_id)
void
gtk_statusbar_remove (statusbar, context_id, message_id)
	GtkStatusbar * statusbar
	guint          context_id
	guint          message_id

## void gtk_statusbar_set_has_resize_grip (GtkStatusbar *statusbar, gboolean setting)
void
gtk_statusbar_set_has_resize_grip (statusbar, setting)
	GtkStatusbar * statusbar
	gboolean       setting

## gboolean gtk_statusbar_get_has_resize_grip (GtkStatusbar *statusbar)
gboolean
gtk_statusbar_get_has_resize_grip (statusbar)
	GtkStatusbar * statusbar

##guint gtk_statusbar_get_context_id (GtkStatusbar *statusbar, const gchar *context_description)
guint
gtk_statusbar_get_context_id (statusbar, context_description)
	GtkStatusbar * statusbar
	gchar        * context_description

##guint gtk_statusbar_push (GtkStatusbar *statusbar, guint context_id, const gchar *text)
guint
gtk_statusbar_push (statusbar, context_id, text)
	GtkStatusbar * statusbar
	guint          context_id
	gchar        * text

