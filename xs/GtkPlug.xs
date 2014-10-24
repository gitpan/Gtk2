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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkPlug.xs,v 1.5 2003/07/24 00:58:38 pcg Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::Plug	PACKAGE = Gtk2::Plug	PREFIX = gtk_plug_

#ifndef GDK_WINDOWING_WIN32 /* no plug/socket on win32 despite patches exist for years. */

## void gtk_plug_construct (GtkPlug *plug, GdkNativeWindow socket_id)
void
gtk_plug_construct (plug, socket_id)
	GtkPlug         * plug
	GdkNativeWindow   socket_id

# for 2.2 compat this function needs to be updated to include
# the for_display version
## GtkWidget* gtk_plug_new (GdkNativeWindow socket_id)
GtkWidget *
gtk_plug_new (class, socket_id)
	SV              * class
	GdkNativeWindow   socket_id
    C_ARGS:
	socket_id

#if GTK_CHECK_VERSION(2,2,0)

##GtkWidget * gtk_plug_new_for_display (GdkDisplay *display, GdkNativeWindow socket_id)
GtkWidget *
gtk_plug_new_for_display (display, socket_id)
	GdkDisplay *display
	GdkNativeWindow socket_id

## void gtk_plug_construct_for_disaplay (GtkPlug *plug, GdkDisplay * display, GdkNativeWindow socket_id)
void
gtk_plug_construct_for_display (plug, display, socket_id)
	GtkPlug         * plug
	GdkDisplay      * display
	GdkNativeWindow   socket_id

#endif

## GdkNativeWindow gtk_plug_get_id (GtkPlug *plug)
GdkNativeWindow
gtk_plug_get_id (plug)
	GtkPlug * plug

## void _gtk_plug_add_to_socket (GtkPlug *plug, GtkSocket *socket)
#void
#_gtk_plug_add_to_socket (plug, socket)
#	GtkPlug   * plug
#	GtkSocket * socket

## void _gtk_plug_remove_from_socket (GtkPlug *plug, GtkSocket *socket)
#void
#_gtk_plug_remove_from_socket (plug, socket)
#	GtkPlug   * plug
#	GtkSocket * socket

#endif
