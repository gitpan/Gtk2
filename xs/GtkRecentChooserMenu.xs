/*
 * Copyright (c) 2006 by the gtk2-perl team (see the file AUTHORS)
 *
 * Licensed under the LGPL, see LICENSE file for more information.
 *
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkRecentChooserMenu.xs,v 1.1 2006/07/02 20:04:52 ebassi Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::RecentChooserMenu	PACKAGE = Gtk2::RecentChooserMenu	PREFIX = gtk_recent_chooser_menu_

BOOT:
	gperl_prepend_isa ("Gtk2::RecentChooserMenu", "Gtk2::RecentChooser");

GtkWidget *
gtk_recent_chooser_menu_new (class)
    C_ARGS:
        /* void */

GtkWidget *
gtk_recent_chooser_menu_new_for_manager (class, GtkRecentManager *manager)
    C_ARGS:
        manager

gboolean
gtk_recent_chooser_menu_get_show_numbers (GtkRecentChooserMenu *menu)

void
gtk_recent_chooser_menu_set_show_numbers (GtkRecentChooserMenu *menu, gboolean show_numbers)
