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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkFileSelection.xs,v 1.6 2003/05/22 14:23:23 muppetman Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::FileSelection	PACKAGE = Gtk2::FileSelection	PREFIX = gtk_file_selection_


GtkWidget *
member_widget (fs)
	GtkFileSelection* fs
    ALIAS:
	Gtk2::FileSelection::ok_button       = 0
	Gtk2::FileSelection::cancel_button   = 1
	Gtk2::FileSelection::dir_list        = 2
	Gtk2::FileSelection::file_list       = 3
	Gtk2::FileSelection::selection_entry = 4
	Gtk2::FileSelection::selection_text  = 5
	Gtk2::FileSelection::main_vbox       = 6
	Gtk2::FileSelection::help_button     = 7
    CODE:
	switch (ix) {
		case 0: RETVAL = fs->ok_button;       break;
		case 1: RETVAL = fs->cancel_button;   break;
		case 2: RETVAL = fs->dir_list;        break;
		case 3: RETVAL = fs->file_list;       break;
		case 4: RETVAL = fs->selection_entry; break;
		case 5: RETVAL = fs->selection_text;  break;
		case 6: RETVAL = fs->main_vbox;       break;
		case 7: RETVAL = fs->help_button;     break;
	}
    OUTPUT:
	RETVAL

## GtkWidget* gtk_file_selection_new (const gchar *title)
GtkWidget *
gtk_file_selection_new (class, title)
	SV          * class
	const gchar * title
    C_ARGS:
	title

## void gtk_file_selection_set_filename (GtkFileSelection *filesel, const gchar *filename)
void
gtk_file_selection_set_filename (filesel, filename)
	GtkFileSelection * filesel
	const gchar      * filename

## void gtk_file_selection_complete (GtkFileSelection *filesel, const gchar *pattern)
void
gtk_file_selection_complete (filesel, pattern)
	GtkFileSelection * filesel
	const gchar      * pattern

## void gtk_file_selection_show_fileop_buttons (GtkFileSelection *filesel)
void
gtk_file_selection_show_fileop_buttons (filesel)
	GtkFileSelection * filesel

## void gtk_file_selection_hide_fileop_buttons (GtkFileSelection *filesel)
void
gtk_file_selection_hide_fileop_buttons (filesel)
	GtkFileSelection * filesel

## void gtk_file_selection_set_select_multiple (GtkFileSelection *filesel, gboolean select_multiple)
void
gtk_file_selection_set_select_multiple (filesel, select_multiple)
	GtkFileSelection * filesel
	gboolean           select_multiple

## gboolean gtk_file_selection_get_select_multiple (GtkFileSelection *filesel)
gboolean
gtk_file_selection_get_select_multiple (filesel)
	GtkFileSelection * filesel

# G_CONST_RETURN
const gchar *
gtk_file_selection_get_filename (filesel)
	GtkFileSelection * filesel

## TODO: what about the utf8'ieness of all of this
void
gtk_file_selection_get_selections (filesel)
	GtkFileSelection * filesel
    PREINIT:
	int      i;
	gchar ** rets;
	gchar *  curr;
    PPCODE:
	rets = gtk_file_selection_get_selections(filesel);
	for( i = 0, curr = rets[0]; curr != NULL; i++ )
	{
		curr = rets[i];
		XPUSHs(sv_2mortal(newSVpv(
			g_filename_to_utf8(curr, -1, NULL, NULL, NULL), 
			PL_na)));
	}
	g_strfreev(rets);

