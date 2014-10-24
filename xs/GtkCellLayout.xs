/*
 * Copyright (c) 2003 by the gtk2-perl team (see the file AUTHORS)
 *
 * Licensed under the LGPL, see LICENSE file for more information.
 *
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkCellLayout.xs,v 1.3 2004/02/22 19:57:33 kaffeetisch Exp $
 */

#include "gtk2perl.h"

/*
typedef void (* GtkCellLayoutDataFunc) (GtkCellLayout   *cell_layout,
                                        GtkCellRenderer *cell,
                                        GtkTreeModel    *tree_model,
                                        GtkTreeIter     *iter,
                                        gpointer         data);
*/

static void
gtk2perl_cell_layout_data_func (GtkCellLayout   *cell_layout,
                                GtkCellRenderer *cell,
                                GtkTreeModel    *tree_model,
                                GtkTreeIter     *iter,
                                gpointer         data)
{
	GPerlCallback * callback = (GPerlCallback *) data;

	gperl_callback_invoke (callback, NULL, cell_layout, cell,
	                       tree_model, iter);
}

MODULE = Gtk2::CellLayout	PACKAGE = Gtk2::CellLayout	PREFIX = gtk_cell_layout_


void gtk_cell_layout_pack_start (GtkCellLayout *cell_layout, GtkCellRenderer *cell, gboolean expand);

void gtk_cell_layout_pack_end (GtkCellLayout *cell_layout, GtkCellRenderer *cell, gboolean expand);

void gtk_cell_layout_clear (GtkCellLayout *cell_layout);

void gtk_cell_layout_set_attributes (GtkCellLayout *cell_layout, GtkCellRenderer *cell, ...);
    PREINIT:
	gint i;
    CODE:
	if (items < 4 || 0 != (items - 2) % 2)
		croak ("usage: $cell_layout->set_attributes (name => column, ...)\n"
		       "   expecting a list of name => column pairs"); 
	for (i = 2 ; i < items ; i+=2) {
		gtk_cell_layout_add_attribute (cell_layout, cell,
		                               SvPV_nolen (ST (i)),
		                               SvIV (ST (i+1)));
	}

void gtk_cell_layout_add_attribute (GtkCellLayout *cell_layout, GtkCellRenderer *cell, const gchar *attribute, gint column);

###void gtk_cell_layout_set_cell_data_func (GtkCellLayout *cell_layout, GtkCellRenderer *cell, GtkCellLayoutDataFunc func, gpointer func_data, GDestroyNotify destroy);
void gtk_cell_layout_set_cell_data_func (GtkCellLayout *cell_layout, GtkCellRenderer *cell, SV * func, SV * func_data=NULL);
    PREINIT:
	GType param_types[] = {
		GTK_TYPE_CELL_LAYOUT,
		GTK_TYPE_CELL_RENDERER,
		GTK_TYPE_TREE_MODEL,
		GTK_TYPE_TREE_ITER
	};
	GPerlCallback * callback;
    CODE:
	callback = gperl_callback_new (func, func_data, 4, param_types,
	                               G_TYPE_NONE);
	gtk_cell_layout_set_cell_data_func
	                    (cell_layout, cell,
	                     gtk2perl_cell_layout_data_func, callback,
		             (GDestroyNotify) gperl_callback_destroy);

void gtk_cell_layout_clear_attributes (GtkCellLayout *cell_layout, GtkCellRenderer *cell);

void gtk_cell_layout_reorder (GtkCellLayout *cell_layout, GtkCellRenderer *cell, gint position)

