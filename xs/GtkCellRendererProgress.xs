/*
 * Copyright (c) 2004 by the gtk2-perl team (see the file AUTHORS)
 *
 * Licensed under the LGPL, see LICENSE file for more information.
 *
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkCellRendererProgress.xs,v 1.1 2005/01/02 16:25:51 kaffeetisch Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::CellRendererProgress	PACKAGE = Gtk2::CellRendererProgress	PREFIX = gtk_cell_renderer_progress_

##  GtkCellRenderer * gtk_cell_renderer_progress_new (void);
GtkCellRenderer *
gtk_cell_renderer_progress_new (class)
    C_ARGS:
	/* void */
