/*
 * Copyright (c) 2004-2005 by the gtk2-perl team (see the file AUTHORS)
 *
 * Licensed under the LGPL, see LICENSE file for more information.
 *
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkIconView.xs,v 1.7 2005/09/18 15:07:22 kaffeetisch Exp $
 */
#include "gtk2perl.h"

static GPerlCallback *
gtk2perl_icon_view_foreach_func_create (SV * func, SV * data)
{
	GType param_types [2];
	param_types[0] = GTK_TYPE_ICON_VIEW;
	param_types[1] = GTK_TYPE_TREE_PATH;
	return gperl_callback_new (func, data, G_N_ELEMENTS (param_types),
				   param_types, G_TYPE_NONE);
}
static void
gtk2perl_icon_view_foreach_func (GtkIconView      *icon_view,
				 GtkTreePath      *path,
				 gpointer          data)
{
	gperl_callback_invoke ((GPerlCallback*) data, NULL, icon_view, path);
}


MODULE = Gtk2::IconView PACKAGE = Gtk2::IconView PREFIX = gtk_icon_view_

GtkWidget * gtk_icon_view_new (class)
    C_ARGS:
	/* void */

GtkWidget * gtk_icon_view_new_with_model (class, model)
	GtkTreeModel * model
    C_ARGS:
	model

void gtk_icon_view_set_model (GtkIconView * icon_view, GtkTreeModel * model);

GtkTreeModel * gtk_icon_view_get_model (GtkIconView * icon_view);

void gtk_icon_view_set_text_column (GtkIconView * icon_view, gint column);

gint gtk_icon_view_get_text_column (GtkIconView * icon_view);

void gtk_icon_view_set_markup_column (GtkIconView * icon_view, gint column);

gint gtk_icon_view_get_markup_column (GtkIconView * icon_view);

void gtk_icon_view_set_pixbuf_column (GtkIconView * icon_view, gint column);

gint gtk_icon_view_get_pixbuf_column (GtkIconView * icon_view);

void gtk_icon_view_set_orientation (GtkIconView * icon_view, GtkOrientation orientation);

GtkOrientation gtk_icon_view_get_orientation (GtkIconView * icon_view);

void gtk_icon_view_set_columns (GtkIconView *icon_view, gint columns);

gint gtk_icon_view_get_columns (GtkIconView *icon_view);

void gtk_icon_view_set_item_width (GtkIconView *icon_view, gint item_width);

gint gtk_icon_view_get_item_width (GtkIconView *icon_view);

void gtk_icon_view_set_spacing (GtkIconView *icon_view, gint spacing);

gint gtk_icon_view_get_spacing (GtkIconView *icon_view);

void gtk_icon_view_set_row_spacing (GtkIconView *icon_view, gint row_spacing);

gint gtk_icon_view_get_row_spacing (GtkIconView *icon_view);

void gtk_icon_view_set_column_spacing (GtkIconView *icon_view, gint column_spacing);

gint gtk_icon_view_get_column_spacing (GtkIconView *icon_view);

void gtk_icon_view_set_margin (GtkIconView *icon_view, gint margin);

gint gtk_icon_view_get_margin (GtkIconView *icon_view);

GtkTreePath_own * gtk_icon_view_get_path_at_pos (GtkIconView * icon_view, gint x, gint y);

## void gtk_icon_view_selected_foreach (GtkIconView * icon_view, GtkIconViewForeachFunc func, gpointer data);
void
gtk_icon_view_selected_foreach (GtkIconView * icon_view, SV * func, SV * data=NULL);
    PREINIT:
	GPerlCallback * callback;
    CODE:
	callback = gtk2perl_icon_view_foreach_func_create (func, data);
	gtk_icon_view_selected_foreach (icon_view,
					gtk2perl_icon_view_foreach_func,
					callback);
	gperl_callback_destroy (callback);


void gtk_icon_view_set_selection_mode (GtkIconView * icon_view, GtkSelectionMode mode);

GtkSelectionMode gtk_icon_view_get_selection_mode (GtkIconView * icon_view);

void gtk_icon_view_select_path (GtkIconView * icon_view, GtkTreePath * path);

void gtk_icon_view_unselect_path (GtkIconView * icon_view, GtkTreePath * path);

gboolean gtk_icon_view_path_is_selected (GtkIconView * icon_view, GtkTreePath * path);

## GList * gtk_icon_view_get_selected_items (GtkIconView * icon_view);
void
gtk_icon_view_get_selected_items (GtkIconView * icon_view)
    PREINIT:
	GList * list;
    PPCODE:
	list = gtk_icon_view_get_selected_items (icon_view);
	if (list)
	{
		GList * curr;

		for (curr = list; curr; curr = g_list_next (curr))
			XPUSHs (sv_2mortal (newSVGtkTreePath (curr->data)));

		g_list_foreach (list, (GFunc)gtk_tree_path_free, NULL);
		g_list_free (list);
	}
	else
		XSRETURN_EMPTY;

void gtk_icon_view_select_all (GtkIconView * icon_view);

void gtk_icon_view_unselect_all (GtkIconView * icon_view);

void gtk_icon_view_item_activated (GtkIconView * icon_view, GtkTreePath * path);

#if GTK_CHECK_VERSION(2, 8, 0)

## gboolean gtk_icon_view_get_cursor (GtkIconView *icon_view, GtkTreePath **path, GtkCellRenderer **cell);
void
gtk_icon_view_get_cursor (icon_view)
	GtkIconView *icon_view
    PREINIT:
	GtkTreePath *path = NULL;
	GtkCellRenderer *cell = NULL;
    PPCODE:
	if (!gtk_icon_view_get_cursor (icon_view, &path, &cell))
		XSRETURN_EMPTY;
	EXTEND (sp, 2);
	PUSHs (sv_2mortal (newSVGtkTreePath_own (path)));
	PUSHs (sv_2mortal (newSVGtkCellRenderer (cell)));

void gtk_icon_view_set_cursor (GtkIconView *icon_view, GtkTreePath *path, GtkCellRenderer_ornull *cell, gboolean start_editing);

## gboolean gtk_icon_view_get_item_at_pos (GtkIconView *icon_view, gint x, gint y, GtkTreePath **path, GtkCellRenderer **cell);
void
gtk_icon_view_get_item_at_pos (icon_view, x, y)
	GtkIconView *icon_view
	gint x
	gint y
    PREINIT:
	GtkTreePath *path = NULL;
	GtkCellRenderer *cell = NULL;
    PPCODE:
	if (!gtk_icon_view_get_item_at_pos (icon_view, x, y, &path, &cell))
		XSRETURN_EMPTY;
	EXTEND (sp, 2);
	PUSHs (sv_2mortal (newSVGtkTreePath_own (path)));
	PUSHs (sv_2mortal (newSVGtkCellRenderer (cell)));


## gboolean gtk_icon_view_get_visible_range (GtkIconView *icon_view, GtkTreePath **start_path, GtkTreePath **end_path);
void
gtk_icon_view_get_visible_range (icon_view)
	GtkIconView *icon_view
    PREINIT:
	GtkTreePath *start_path = NULL, *end_path = NULL;
    PPCODE:
	if (!gtk_icon_view_get_visible_range(icon_view, &start_path, &end_path))
		XSRETURN_EMPTY;
	EXTEND (sp, 2);
	PUSHs (sv_2mortal (newSVGtkTreePath_own (start_path)));
	PUSHs (sv_2mortal (newSVGtkTreePath_own (end_path)));

void gtk_icon_view_scroll_to_path (GtkIconView *icon_view, GtkTreePath *path, gboolean use_align, gfloat row_align, gfloat col_align);

## void gtk_icon_view_enable_model_drag_source (GtkIconView *icon_view, GdkModifierType start_button_mask, const GtkTargetEntry *targets, gint n_targets, GdkDragAction actions);
=for apidoc
=for arg ... of Gtk2::TargetEntry's
=cut
void
gtk_icon_view_enable_model_drag_source (icon_view, start_button_mask, actions, ...)
	GtkIconView *icon_view
	GdkModifierType start_button_mask
	GdkDragAction actions
    PREINIT:
	GtkTargetEntry * targets = NULL;
	gint n_targets, i;
    CODE:
#define FIRST_TARGET 3
	n_targets = items - FIRST_TARGET;
	targets = g_new (GtkTargetEntry, n_targets);
	for (i = 0 ; i < n_targets ; i++)
		gtk2perl_read_gtk_target_entry (ST (i+FIRST_TARGET), targets+i);
	gtk_icon_view_enable_model_drag_source (icon_view, start_button_mask,
	                                        targets, n_targets, actions);
#undef FIRST_TARGET
    CLEANUP:
	g_free (targets);

## void gtk_icon_view_enable_model_drag_dest (GtkIconView *icon_view, const GtkTargetEntry *targets, gint n_targets, GdkDragAction actions);
=for apidoc
=for arg ... of Gtk2::TargetEntry's
=cut
void
gtk_icon_view_enable_model_drag_dest (icon_view, actions, ...)
	GtkIconView *icon_view
	GdkDragAction actions
    PREINIT:
	GtkTargetEntry * targets = NULL;
	gint n_targets, i;
    CODE:
#define FIRST_TARGET 2
	n_targets = items - FIRST_TARGET;
	targets = g_new (GtkTargetEntry, n_targets);
	for (i = 0 ; i < n_targets ; i++)
		gtk2perl_read_gtk_target_entry (ST (i+FIRST_TARGET), targets+i);
	gtk_icon_view_enable_model_drag_dest (icon_view, targets, n_targets,
	                                      actions);
#undef FIRST_TARGET
    CLEANUP:
	g_free (targets);

void gtk_icon_view_unset_model_drag_source (GtkIconView *icon_view);

void gtk_icon_view_unset_model_drag_dest (GtkIconView *icon_view);

void gtk_icon_view_set_reorderable (GtkIconView *icon_view, gboolean reorderable);

gboolean gtk_icon_view_get_reorderable (GtkIconView *icon_view);

void gtk_icon_view_set_drag_dest_item (GtkIconView *icon_view, GtkTreePath *path, GtkIconViewDropPosition pos);

## void gtk_icon_view_get_drag_dest_item (GtkIconView *icon_view, GtkTreePath **path, GtkIconViewDropPosition *pos);
void gtk_icon_view_get_drag_dest_item (GtkIconView *icon_view, OUTLIST GtkTreePath *path, OUTLIST GtkIconViewDropPosition pos);

## gboolean gtk_icon_view_get_dest_item_at_pos (GtkIconView *icon_view, gint drag_x, gint drag_y, GtkTreePath **path, GtkIconViewDropPosition *pos);
void
gtk_icon_view_get_dest_item_at_pos (icon_view, drag_x, drag_y)
	GtkIconView *icon_view
	gint drag_x
	gint drag_y
    PREINIT:
	GtkTreePath *path = NULL;
	GtkIconViewDropPosition pos;
    PPCODE:
	if (!gtk_icon_view_get_dest_item_at_pos (icon_view, drag_x, drag_y, &path, &pos))
		XSRETURN_EMPTY;
	EXTEND (sp, 2);
	PUSHs (sv_2mortal (newSVGtkTreePath_own (path)));
	PUSHs (sv_2mortal (newSVGtkIconViewDropPosition (pos)));

GdkPixmap_noinc *gtk_icon_view_create_drag_icon (GtkIconView *icon_view, GtkTreePath *path);

#endif