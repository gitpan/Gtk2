/*
 * Copyright (c) 2007 by the gtk2-perl team (see the file AUTHORS)
 *
 * Licensed under the LGPL, see LICENSE file for more information.
 *
 * $Id: GtkScaleButton.xs,v 1.1 2007/06/16 12:39:25 kaffeetisch Exp $
 */

#include "gtk2perl.h"

#define ICONS_FROM_STACK(offset, icons)					\
	if (items > offset) {						\
		int i;							\
		icons = g_new0 (gchar *, items - offset);		\
		for (i = offset; i < items; i++) {			\
			icons[i - offset] = SvPV_nolen (ST (i));	\
		}							\
	}								\

MODULE = Gtk2::ScaleButton	PACKAGE = Gtk2::ScaleButton	PREFIX = gtk_scale_button_

# GtkWidget * gtk_scale_button_new (GtkIconSize size, gdouble min, gdouble max, gdouble step, const gchar **icons);
GtkWidget *
gtk_scale_button_new (class, GtkIconSize size, gdouble min, gdouble max, gdouble step, ...)
    PREINIT:
	gchar **icons = NULL;
    CODE:
	ICONS_FROM_STACK (5, icons);
	RETVAL = gtk_scale_button_new (size, min, max, step, (const gchar **) icons);
	g_free (icons); /* NULL-safe */
    OUTPUT:
	RETVAL

# void gtk_scale_button_set_icons (GtkScaleButton *button, const gchar **icons);
void
gtk_scale_button_set_icons (GtkScaleButton *button, ...)
    PREINIT:
	gchar **icons = NULL;
    CODE:
	ICONS_FROM_STACK (1, icons);
	gtk_scale_button_set_icons (button, (const gchar **) icons);
	g_free (icons); /* NULL-safe */

gdouble gtk_scale_button_get_value (GtkScaleButton *button);

void gtk_scale_button_set_value (GtkScaleButton *button, gdouble value);

GtkAdjustment * gtk_scale_button_get_adjustment (GtkScaleButton *button);

void gtk_scale_button_set_adjustment (GtkScaleButton *button, GtkAdjustment *adjustment);
