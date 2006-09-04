/*
 * Copyright (c) 2006 by the gtk2-perl team (see the file AUTHORS)
 *
 * Licensed under the LGPL, see LICENSE file for more information.
 *
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkRecentChooserWidget.xs,v 1.1 2006/07/02 20:04:52 ebassi Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::RecentChooserWidget	PACKAGE = Gtk2::RecentChooserWidget	PREFIX = gtk_recent_chooser_widget_

BOOT:
	gperl_prepend_isa ("Gtk2::RecentChooserWidget", "Gtk2::RecentChooser");

GtkWidget *
gtk_recent_chooser_widget_new (class)
    C_ARGS:
        /* void */

GtkWidget *
gtk_recent_chooser_widget_new_for_manager (class, manager)
	GtkRecentManager *manager
    C_ARGS:
        manager
