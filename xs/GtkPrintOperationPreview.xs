/*
 * Copyright (c) 2006 by the gtk2-perl team (see the file AUTHORS)
 *
 * Licensed under the LGPL, see LICENSE file for more information.
 *
 * $Id: GtkPrintOperationPreview.xs 2054 2008-10-05 12:49:36Z tsch $
 */

#include "gtk2perl.h"

MODULE = Gtk2::PrintOperationPreview	PACKAGE = Gtk2::PrintOperationPreview	PREFIX = gtk_print_operation_preview_

void gtk_print_operation_preview_render_page (GtkPrintOperationPreview *preview, gint page_nr);

void gtk_print_operation_preview_end_preview (GtkPrintOperationPreview *preview);

gboolean gtk_print_operation_preview_is_selected (GtkPrintOperationPreview *preview, gint page_nr);
