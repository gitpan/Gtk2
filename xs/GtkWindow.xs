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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkWindow.xs,v 1.9 2003/05/22 14:23:24 muppetman Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::Window	PACKAGE = Gtk2::Window	PREFIX = gtk_window_

## GtkWidget* gtk_window_new (GtkWindowType type)
GtkWidget *
gtk_window_new (class, type=GTK_WINDOW_TOPLEVEL)
	SV            * class
	GtkWindowType   type
    C_ARGS:
	type

## void gtk_window_set_title (GtkWindow *window, const gchar *title)
void
gtk_window_set_title (window, title)
	GtkWindow   * window
	const gchar * title

## void gtk_window_set_wmclass (GtkWindow *window, const gchar *wmclass_name, const gchar *wmclass_class)
void
gtk_window_set_wmclass (window, wmclass_name, wmclass_class)
	GtkWindow   * window
	const gchar * wmclass_name
	const gchar * wmclass_class

## void gtk_window_set_role (GtkWindow *window, const gchar *role)
void
gtk_window_set_role (window, role)
	GtkWindow   * window
	const gchar * role

##G_CONST_RETURN gchar* gtk_window_get_role   (GtkWindow *window)
const gchar *
gtk_window_get_role (window)
	GtkWindow *window

## void gtk_window_add_accel_group (GtkWindow *window, GtkAccelGroup *accel_group)
void
gtk_window_add_accel_group (window, accel_group)
	GtkWindow     * window
	GtkAccelGroup * accel_group

## void gtk_window_remove_accel_group (GtkWindow *window, GtkAccelGroup *accel_group)
void
gtk_window_remove_accel_group (window, accel_group)
	GtkWindow     * window
	GtkAccelGroup * accel_group

## void gtk_window_set_position (GtkWindow *window, GtkWindowPosition position)
void
gtk_window_set_position (window, position)
	GtkWindow         * window
	GtkWindowPosition   position

## gboolean gtk_window_activate_focus (GtkWindow *window)
gboolean
gtk_window_activate_focus (window)
	GtkWindow * window

## GtkWidget * gtk_window_get_focus (GtkWindow *window)
GtkWidget_ornull *
gtk_window_get_focus (window)
	GtkWindow * window

## void gtk_window_set_focus (GtkWindow *window, GtkWidget *focus)
void
gtk_window_set_focus (window, focus)
	GtkWindow        * window
	GtkWidget_ornull * focus

## void gtk_window_set_default (GtkWindow *window, GtkWidget *default_widget)
void
gtk_window_set_default (window, default_widget)
	GtkWindow        * window
	GtkWidget_ornull * default_widget

## gboolean gtk_window_activate_default (GtkWindow *window)
gboolean
gtk_window_activate_default (window)
	GtkWindow * window

## void gtk_window_set_default_size (GtkWindow *window, gint width, gint height)
void
gtk_window_set_default_size (window, width, height)
	GtkWindow * window
	gint        width
	gint        height

## void gtk_window_set_modal (GtkWindow *window, gboolean modal)
void
gtk_window_set_modal (window, modal)
	GtkWindow * window
	gboolean    modal

## void gtk_window_set_transient_for (GtkWindow *window, GtkWindow *parent)
void
gtk_window_set_transient_for (window, parent)
	GtkWindow        * window
	GtkWindow_ornull * parent

## void gtk_window_set_type_hint (GtkWindow *window, GdkWindowTypeHint hint)
void
gtk_window_set_type_hint (window, hint)
	GtkWindow         * window
	GdkWindowTypeHint   hint

## G_CONST_RETURN gchar* gtk_window_get_title (GtkWindow *window)
const gchar *
gtk_window_get_title (window)
	GtkWindow * window

## GtkWindow* gtk_window_get_transient_for (GtkWindow *window)
GtkWindow_ornull *
gtk_window_get_transient_for (window)
	GtkWindow * window

## GdkWindowTypeHint gtk_window_get_type_hint (GtkWindow *window)
GdkWindowTypeHint
gtk_window_get_type_hint (window)
	GtkWindow * window

## void gtk_window_set_destroy_with_parent (GtkWindow *window, gboolean setting)
void
gtk_window_set_destroy_with_parent (window, setting)
	GtkWindow * window
	gboolean    setting

## gboolean gtk_window_get_destroy_with_parent (GtkWindow *window)
gboolean
gtk_window_get_destroy_with_parent (window)
	GtkWindow * window

## void gtk_window_set_resizable (GtkWindow *window, gboolean resizable)
void
gtk_window_set_resizable (window, resizable)
	GtkWindow * window
	gboolean    resizable

## gboolean gtk_window_get_resizable (GtkWindow *window)
gboolean
gtk_window_get_resizable (window)
	GtkWindow * window

## void gtk_window_set_gravity (GtkWindow *window, GdkGravity gravity)
void
gtk_window_set_gravity (window, gravity)
	GtkWindow  * window
	GdkGravity   gravity

## GdkGravity gtk_window_get_gravity (GtkWindow *window)
GdkGravity
gtk_window_get_gravity (window)
	GtkWindow * window

# TODO: GDkGeometry not in typemap
## void gtk_window_set_geometry_hints (GtkWindow *window, GtkWidget *geometry_widget, GdkGeometry *geometry, GdkWindowHints geom_mask)
#void
#gtk_window_set_geometry_hints (window, geometry_widget, geometry, geom_mask)
#	GtkWindow      * window
#	GtkWidget      * geometry_widget
#	GdkGeometry    * geometry
#	GdkWindowHints   geom_mask

## gboolean gtk_window_get_has_frame (GtkWindow *window)
gboolean
gtk_window_get_has_frame (window)
	GtkWindow * window

## void gtk_window_set_frame_dimensions (GtkWindow *window, gint left, gint top, gint right, gint bottom)
void
gtk_window_set_frame_dimensions (window, left, top, right, bottom)
	GtkWindow * window
	gint        left
	gint        top
	gint        right
	gint        bottom

## void gtk_window_get_frame_dimensions (GtkWindow *window, gint *left, gint *top, gint *right, gint *bottom)
void
gtk_window_get_frame_dimensions (GtkWindow * window, OUTLIST gint left, OUTLIST gint top, OUTLIST gint right, OUTLIST gint bottom)

## void gtk_window_set_decorated (GtkWindow *window, gboolean setting)
void
gtk_window_set_decorated (window, setting)
	GtkWindow * window
	gboolean    setting

## gboolean gtk_window_get_decorated (GtkWindow *window)
gboolean
gtk_window_get_decorated (window)
	GtkWindow * window

## void gtk_window_set_icon_list (GtkWindow *window, GList *list)
void
gtk_window_set_icon_list (window, ...)
	GtkWindow * window
    PREINIT:
	GList * list = NULL;
    PPCODE:
	for( items--; items > 0; items-- )
		list = g_list_prepend(list, SvGdkPixbuf(ST(items)));
	if( list )
	{
		gtk_window_set_icon_list(window, list);
		g_list_free(list);
	}

# GList* gtk_window_get_icon_list (GtkWindow *window)
void
gtk_window_get_icon_list (window)
	GtkWindow * window
    PREINIT:
	GList * list, * i;
    PPCODE:
	list = gtk_window_get_icon_list (window);
	if (!list)
		XSRETURN_EMPTY;
	for (i = list ; i != NULL ; i = i->next)
		XPUSHs (sv_2mortal (newSVGdkPixbuf (i->data)));
	g_list_free (list);

## void gtk_window_set_icon (GtkWindow *window, GdkPixbuf *icon)
void
gtk_window_set_icon (window, icon)
	GtkWindow        * window
	GdkPixbuf_ornull * icon

#if GTK_CHECK_VERSION(2,2,0)

#gboolean gtk_window_set_icon_from_file (GtkWindow *window, const gchar *filename, GError **err)
void
gtk_window_set_icon_from_file (window, filename)
	GtkWindow     * window
	const gchar   * filename
    PREINIT:
	GError * err = NULL;
    CODE:
	if (!gtk_window_set_icon_from_file(window, filename, &err))
		gperl_croak_gerror (filename, err);

#gboolean gtk_window_set_default_icon_from_file (GtkWindow *window, const gchar *filename, GError **err)
void
gtk_window_set_default_icon_from_file (class, filename)
	SV            * class
	const gchar   * filename
    PREINIT:
	GError * err = NULL;
    CODE:
	if (!gtk_window_set_default_icon_from_file(filename, &err))
		gperl_croak_gerror (filename, err);

#endif

## GdkPixbuf* gtk_window_get_icon (GtkWindow *window)
GdkPixbuf *
gtk_window_get_icon (window)
	GtkWindow * window


## void gtk_window_set_default_icon_list (GList *list)
void
gtk_window_set_default_icon_list (class, pixbuf, ...)
	SV * class
	SV * pixbuf
    PREINIT:
	int i;
	GList * list = NULL;
    CODE:
	for (i = 1; i < items ; i++)
		list = g_list_append (list, SvGdkPixbuf (ST (i)));
	gtk_window_set_default_icon_list (list);
	g_list_free (list);

## GList* gtk_window_get_default_icon_list (void)
void
gtk_window_get_default_icon_list (class)
	SV * class
    PREINIT:
	GList * list, * tmp;
    PPCODE:
	list = gtk_window_get_default_icon_list ();
	for (tmp = list ; tmp != NULL ; tmp = tmp->next)
		XPUSHs (sv_2mortal (newSVGdkPixbuf (tmp->data)));
	g_list_free (list);

## gboolean gtk_window_get_modal (GtkWindow *window)
gboolean
gtk_window_get_modal (window)
	GtkWindow * window

# TODO: GList not in typemap
## GList* gtk_window_list_toplevels (void)
#GList *
#gtk_window_list_toplevels ()

## void gtk_window_add_mnemonic (GtkWindow *window, guint keyval, GtkWidget *target)
void
gtk_window_add_mnemonic (window, keyval, target)
	GtkWindow * window
	guint       keyval
	GtkWidget * target

## void gtk_window_remove_mnemonic (GtkWindow *window, guint keyval, GtkWidget *target)
void
gtk_window_remove_mnemonic (window, keyval, target)
	GtkWindow * window
	guint       keyval
	GtkWidget * target

## gboolean gtk_window_mnemonic_activate (GtkWindow *window, guint keyval, GdkModifierType modifier)
gboolean
gtk_window_mnemonic_activate (window, keyval, modifier)
	GtkWindow       * window
	guint             keyval
	GdkModifierType   modifier

## void gtk_window_set_has_frame (GtkWindow *window, gboolean setting)
void
gtk_window_set_has_frame (window, setting)
	GtkWindow * window
	gboolean    setting

## void gtk_window_set_mnemonic_modifier (GtkWindow *window, GdkModifierType modifier)
void
gtk_window_set_mnemonic_modifier (window, modifier)
	GtkWindow       * window
	GdkModifierType   modifier

## GdkModifierType gtk_window_get_mnemonic_modifier (GtkWindow *window)
GdkModifierType
gtk_window_get_mnemonic_modifier (window)
	GtkWindow * window

## void gtk_window_present (GtkWindow *window)
void
gtk_window_present (window)
	GtkWindow * window

## void gtk_window_iconify (GtkWindow *window)
void
gtk_window_iconify (window)
	GtkWindow * window

## void gtk_window_deiconify (GtkWindow *window)
void
gtk_window_deiconify (window)
	GtkWindow * window

## void gtk_window_stick (GtkWindow *window)
void
gtk_window_stick (window)
	GtkWindow * window

## void gtk_window_unstick (GtkWindow *window)
void
gtk_window_unstick (window)
	GtkWindow * window

## void gtk_window_maximize (GtkWindow *window)
void
gtk_window_maximize (window)
	GtkWindow * window

## void gtk_window_unmaximize (GtkWindow *window)
void
gtk_window_unmaximize (window)
	GtkWindow * window

## void gtk_window_begin_resize_drag (GtkWindow *window, GdkWindowEdge edge, gint button, gint root_x, gint root_y, guint32 timestamp)
void
gtk_window_begin_resize_drag (window, edge, button, root_x, root_y, timestamp)
	GtkWindow     * window
	GdkWindowEdge   edge
	gint            button
	gint            root_x
	gint            root_y
	guint32         timestamp

## void gtk_window_begin_move_drag (GtkWindow *window, gint button, gint root_x, gint root_y, guint32 timestamp)
void
gtk_window_begin_move_drag (window, button, root_x, root_y, timestamp)
	GtkWindow * window
	gint        button
	gint        root_x
	gint        root_y
	guint32     timestamp

## void gtk_window_set_policy (GtkWindow *window, gint allow_shrink, gint allow_grow, gint auto_shrink)
void
gtk_window_set_policy (window, allow_shrink, allow_grow, auto_shrink)
	GtkWindow * window
	gint        allow_shrink
	gint        allow_grow
	gint        auto_shrink

## void gtk_window_get_default_size (GtkWindow *window, gint *width, gint *height)
void
gtk_window_get_default_size (GtkWindow * window, OUTLIST gint width, OUTLIST gint height)

## void gtk_window_resize (GtkWindow *window, gint width, gint height)
void
gtk_window_resize (window, width, height)
	GtkWindow * window
	gint        width
	gint        height

## void gtk_window_get_size (GtkWindow *window, gint *width, gint *height)
void
gtk_window_get_size (GtkWindow * window, OUTLIST gint width, OUTLIST gint height)

## void gtk_window_move (GtkWindow *window, gint x, gint y)
void
gtk_window_move (window, x, y)
	GtkWindow * window
	gint        x
	gint        y

## void gtk_window_get_position (GtkWindow *window, gint *root_x, gint *root_y)
void
gtk_window_get_position (GtkWindow * window, OUTLIST gint root_x, OUTLIST gint root_y)

## gboolean gtk_window_parse_geometry (GtkWindow *window, const gchar *geometry)
gboolean
gtk_window_parse_geometry (window, geometry)
	GtkWindow   * window
	const gchar * geometry

## GtkWindowGroup * gtk_window_group_new (void)
GtkWindowGroup *
gtk_window_group_new ()

## void gtk_window_group_add_window (GtkWindowGroup *window_group, GtkWindow *window)
void
gtk_window_group_add_window (window_group, window)
	GtkWindowGroup * window_group
	GtkWindow      * window

## void gtk_window_group_remove_window (GtkWindowGroup *window_group, GtkWindow *window)
void
gtk_window_group_remove_window (window_group, window)
	GtkWindowGroup * window_group
	GtkWindow      * window

## void gtk_window_remove_embedded_xid (GtkWindow *window, guint xid)
void
gtk_window_remove_embedded_xid (window, xid)
	GtkWindow * window
	guint       xid

## void gtk_window_add_embedded_xid (GtkWindow *window, guint xid)
void
gtk_window_add_embedded_xid (window, xid)
	GtkWindow * window
	guint       xid

## void _gtk_window_reposition (GtkWindow *window, gint x, gint y)
#void
#_gtk_window_reposition (window, x, y)
#	GtkWindow * window
#	gint        x
#	gint        y

## void _gtk_window_constrain_size (GtkWindow *window, gint width, gint height, gint *new_width, gint *new_height)
#void
#_gtk_window_constrain_size (window, width, height, new_width, new_height)
#	GtkWindow * window
#	gint        width
#	gint        height
#	gint      * new_width
#	gint      * new_height

## gboolean _gtk_window_activate_key (GtkWindow *window, GdkEventKey *event)
#gboolean
#_gtk_window_activate_key (window, event)
#	GtkWindow   * window
#	GdkEventKey * event

## void _gtk_window_keys_foreach (GtkWindow *window, GtkWindowKeysForeachFunc func, gpointer func_data)
#void
#_gtk_window_keys_foreach (window, func, func_data)
#	GtkWindow *window
#	GtkWindowKeysForeachFunc func
#	gpointer func_data


##void gtk_window_reshow_with_initial_size (GtkWindow *window)
void
gtk_window_reshow_with_initial_size (window)
	GtkWindow * window

# TODO: ?
##GType gtk_window_group_get_type (void) G_GNUC_CONST
#GType
#gtk_window_group_get_type ()

##void _gtk_window_internal_set_focus (GtkWindow *window, GtkWidget *focus)

##gboolean _gtk_window_query_nonaccels (GtkWindow *window, guint accel_key, GdkModifierType accel_mods)

#if GTK_CHECK_VERSION(2,2,0)

##void gtk_window_set_screen (GtkWindow *window, GdkScreen *screen)
void
gtk_window_set_screen (window, screen)
	GtkWindow * window
	GdkScreen * screen

##GdkScreen * gtk_window_get_screen (GtkWindow *window)
GdkScreen *
gtk_window_get_screen (window)
	GtkWindow * window

void
gtk_window_fullscreen (window)
	GtkWindow * window

void
gtk_window_unfullscreen (window)
	GtkWindow * window

void
gtk_window_set_skip_taskbar_hint (window, setting)
	GtkWindow * window
	gboolean    setting

void
gtk_window_set_skip_pager_hint (window, setting)
	GtkWindow * window
	gboolean    setting

gboolean
gtk_window_get_skip_taskbar_hint (window)
	GtkWindow * window

gboolean
gtk_window_get_skip_pager_hint (window)
	GtkWindow * window

void gtk_window_set_auto_startup_notification (setting)
	gboolean setting

#endif

 ## er... dunno about these.
 ##
 ##void
 ##gtk_decorated_window_init (window)
 ##	GtkWindow * window
 ##
 ##void
 ##gtk_decorated_window_calculate_frame_size (window)
 ##	GtkWindow * window
 ##
 ##void
 ##gtk_decorated_window_set_title (window, title)
 ##	GtkWindow   * window
 ##	const gchar * title
 ##
 ##void
 ##gtk_decorated_window_move_resize_window (window, x, y, width, height)
 ##	GtkWindow   * window
 ##	gint          x
 ##	gint          y
 ##	gint          width
 ##	gint          height
 ##
