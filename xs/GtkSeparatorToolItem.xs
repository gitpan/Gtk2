/*
 * Copyright (c) 2003 by the gtk2-perl team (see the file AUTHORS)
 *
 * Licensed under the LGPL, see LICENSE file for more information.
 *
 * $Id: GtkSeparatorToolItem.xs,v 1.4 2008/10/05 12:49:35 kaffeetisch Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::SeparatorToolItem PACKAGE = Gtk2::SeparatorToolItem PREFIX = gtk_separator_tool_item_

GtkToolItem *gtk_separator_tool_item_new (class);
    C_ARGS:
	/*void*/

gboolean gtk_separator_tool_item_get_draw (GtkSeparatorToolItem *item);

void gtk_separator_tool_item_set_draw (GtkSeparatorToolItem *tool_item, gboolean draw);
