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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkEntry.xs,v 1.6 2003/09/22 00:04:25 rwmcfa1 Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::Entry	PACKAGE = Gtk2::Entry	PREFIX = gtk_entry_

BOOT:
	{
	AV * isa = get_av ("Gtk2::Entry::ISA", TRUE);
	av_push (isa, newSVpv ("Gtk2::Editable", 0));
	}

GtkWidget*
gtk_entry_new (class)
	SV * class
    C_ARGS:
	/* void */
    CLEANUP:
	UNUSED(class);

##GtkWidget* gtk_entry_new_with_max_length (gint max)
GtkWidget *
gtk_entry_new_with_max_length (class, max)
	SV   * class
	gint   max
    C_ARGS:
	max
    CLEANUP:
	UNUSED(class);

void
gtk_entry_set_visibility (entry, visible)
	GtkEntry *entry
	gboolean visible

gboolean
gtk_entry_get_visibility (entry)
	GtkEntry *entry

# FIXME  need typemap for gunichar
 ## void gtk_entry_set_invisible_char (GtkEntry *entry, gunichar ch)
 ##void
 ##gtk_entry_set_invisible_char (entry, ch)
 ##	GtkEntry *entry
 ##	gunichar ch
 #
# FIXME need typemap for gunichar
 ## gunichar gtk_entry_get_invisible_char (GtkEntry *entry)
 ##gunichar
 ##gtk_entry_get_invisible_char (entry)
 ##	GtkEntry *entry

void
gtk_entry_set_has_frame (entry, setting)
	GtkEntry *entry
	gboolean setting

gboolean
gtk_entry_get_has_frame (entry)
	GtkEntry *entry

void
gtk_entry_set_max_length (entry, max)
	GtkEntry      *entry
	gint           max

gint
gtk_entry_get_max_length (entry)
	GtkEntry *entry

void
gtk_entry_set_activates_default (entry, setting)
	GtkEntry *entry
	gboolean setting

gboolean
gtk_entry_get_activates_default (entry)
	GtkEntry *entry

void
gtk_entry_set_width_chars (entry, n_chars)
	GtkEntry *entry
	gint n_chars

gint
gtk_entry_get_width_chars (entry)
	GtkEntry *entry

void
gtk_entry_set_text (entry, text)
	GtkEntry      *entry
	const gchar   *text

# had G_CONST_RETURN
const gchar*
gtk_entry_get_text (entry)
	GtkEntry      *entry

PangoLayout*
gtk_entry_get_layout (entry)
	GtkEntry *entry

 ## void gtk_entry_get_layout_offsets (GtkEntry *entry, gint *x, gint *y)
void
gtk_entry_get_layout_offsets (GtkEntry *entry, OUTLIST gint x, OUTLIST gint y)

void
gtk_entry_append_text (entry, text)
	GtkEntry    * entry
	const gchar * text

void
gtk_entry_prepend_text (entry, text)
	GtkEntry    * entry
	const gchar * text

void
gtk_entry_set_position (entry, position)
	GtkEntry * entry
	gint       position

void
gtk_entry_select_region (entry, start, end)
	GtkEntry * entry
	gint       start
	gint       end

void
gtk_entry_set_editable (entry, editable)
	GtkEntry * entry
	gboolean   editable

