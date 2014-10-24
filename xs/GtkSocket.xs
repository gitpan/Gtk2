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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkSocket.xs,v 1.5 2003/09/14 20:07:43 rwmcfa1 Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::Socket	PACKAGE = Gtk2::Socket	PREFIX = gtk_socket_

#ifndef GDK_WINDOWING_WIN32 /* no plug/socket on win32 despite patches exist for years. */

## GtkWidget* gtk_socket_new (void)
GtkWidget *
gtk_socket_new (class)
	SV * class
    C_ARGS:
	/* void */
    CLEANUP:
	UNUSED(class);

## void gtk_socket_add_id (GtkSocket *socket, GdkNativeWindow window_id)
void
gtk_socket_add_id (socket, window_id)
	GtkSocket       * socket
	GdkNativeWindow   window_id

## GdkNativeWindow gtk_socket_get_id (GtkSocket *socket)
GdkNativeWindow
gtk_socket_get_id (socket)
	GtkSocket * socket

## void gtk_socket_steal (GtkSocket *socket, GdkNativeWindow wid)
void
gtk_socket_steal (socket, wid)
	GtkSocket       * socket
	GdkNativeWindow   wid

#endif

