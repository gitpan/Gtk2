/*
 * Copyright (c) 2006 by the gtk2-perl team (see the file AUTHORS)
 *
 * Licensed under the LGPL, see LICENSE file for more information.
 *
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkPaperSize.xs,v 1.1 2006/06/20 16:49:17 kaffeetisch Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::PaperSize	PACKAGE = Gtk2::PaperSize	PREFIX = gtk_paper_size_

# GtkPaperSize *gtk_paper_size_new (const gchar *name);
GtkPaperSize_own *gtk_paper_size_new (class, const gchar_ornull *name)
    C_ARGS:
	name

# GtkPaperSize *gtk_paper_size_new_from_ppd (const gchar *ppd_name, const gchar *ppd_display_name, gdouble width, gdouble height);
GtkPaperSize_own *gtk_paper_size_new_from_ppd (class, const gchar *ppd_name, const gchar *ppd_display_name, gdouble width, gdouble height)
    C_ARGS:
	ppd_name, ppd_display_name, width, height

# GtkPaperSize *gtk_paper_size_new_custom (const gchar *name, const gchar *display_name, gdouble width, gdouble height, GtkUnit unit);
GtkPaperSize_own *gtk_paper_size_new_custom (class, const gchar *name, const gchar *display_name, gdouble width, gdouble height, GtkUnit unit)
    C_ARGS:
	name, display_name, width, height, unit

gboolean gtk_paper_size_is_equal (GtkPaperSize *size1, GtkPaperSize *size2);

const gchar *gtk_paper_size_get_name (GtkPaperSize *size);

const gchar *gtk_paper_size_get_display_name (GtkPaperSize *size);

const gchar_ornull *gtk_paper_size_get_ppd_name (GtkPaperSize *size);

gdouble gtk_paper_size_get_width (GtkPaperSize *size, GtkUnit unit);

gdouble gtk_paper_size_get_height (GtkPaperSize *size, GtkUnit unit);

gboolean gtk_paper_size_is_custom (GtkPaperSize *size);

void gtk_paper_size_set_size (GtkPaperSize *size, gdouble width, gdouble height, GtkUnit unit);

gdouble gtk_paper_size_get_default_top_margin (GtkPaperSize *size, GtkUnit unit);

gdouble gtk_paper_size_get_default_bottom_margin (GtkPaperSize *size, GtkUnit unit);

gdouble gtk_paper_size_get_default_left_margin (GtkPaperSize *size, GtkUnit unit);

gdouble gtk_paper_size_get_default_right_margin (GtkPaperSize *size, GtkUnit unit);

# G_CONST_RETURN gchar *gtk_paper_size_get_default (void);
const gchar *gtk_paper_size_get_default (class)
    C_ARGS:
	/* void */
