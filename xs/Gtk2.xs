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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/Gtk2.xs,v 1.10 2003/08/18 16:22:19 muppetman Exp $
 */

#include "gtk2perl.h"

static gboolean
gtk2perl_init_add_callback_invoke (GPerlCallback * callback)
{
	GValue return_value = {0,};
	gboolean retval;
	g_value_init (&return_value, callback->return_type);
	gperl_callback_invoke (callback, &return_value);
	retval = g_value_get_boolean (&return_value);
	g_value_unset (&return_value);

	/* TODO: it seems that this will only be called once.
	 * if that is not the case then this next line is very bad */
	gperl_callback_destroy(callback);
	
	return retval;
}

static guint
gtk2perl_quit_add_callback_invoke (GPerlCallback * callback)
{
	GValue return_value = {0,};
	guint retval;
	g_value_init (&return_value, callback->return_type);
	gperl_callback_invoke (callback, &return_value);
	retval = g_value_get_uint (&return_value);
	g_value_unset (&return_value);
	return retval;
}

MODULE = Gtk2		PACKAGE = Gtk2		PREFIX = gtk_

BOOT:
	{
	/* include some files autogenerated by Makefile.PL. */
	/* register Gtk/Gdk/Atk/Pango classes as perl packages.
	 * be sure to include this autogenerated set first, so that the
	 * hand-written boot code functions called by the next include
	 * can override the registrations if necessary. */
#include "register.xsh"
	/* call the boot code for all the various other modules */
#include "boot.xsh"
	}

 ##GTKMAIN_C_VAR const guint gtk_binary_age;
 ##GTKMAIN_C_VAR const guint gtk_interface_age;

void
gtk_get_version_info (class)
	SV * class
    PPCODE:
	EXTEND(SP,3);
	PUSHs(sv_2mortal(newSViv(gtk_major_version)));
	PUSHs(sv_2mortal(newSViv(gtk_minor_version)));
	PUSHs(sv_2mortal(newSViv(gtk_micro_version)));

gchar * 
gtk_check_version (class, required_major, required_minor, required_micro)
	SV    * class
	guint   required_major
	guint   required_minor
	guint   required_micro
    C_ARGS:
	required_major, required_minor, required_micro

gboolean
gtk_init (class)
	SV * class
    ALIAS:
	Gtk2::init = 1
	Gtk2::init_check = 2
    PREINIT:
	AV * ARGV;
	SV * ARGV0;
	int argc, len, i;
	char ** argv, ** shadow;
    CODE:
	/*
	 * heavily borrowed from gtk-perl.
	 *
	 * given the way perl handles the refcounts on SVs and the strings
	 * to which they point, i'm not certain that the g_strdup'ing of
	 * the string values is entirely necessary; however, this compiles
	 * and runs and doesn't appear either to leak or segfault, so i'll
	 * leave it.
	 */
	argv = NULL;
	ARGV = get_av ("ARGV", FALSE);
	ARGV0 = get_sv ("0", FALSE);

	/* construct the argv argument... we'll have to prepend @ARGV with $0
	 * to make it look real. */
	len = av_len (ARGV) + 1;
	argc = len + 1;
	shadow = g_new0 (char*, len + 1);
	argv = g_new0 (char*, argc);
	argv[0] = SvPV_nolen (ARGV0);
	/*warn ("argc = %d\n", argc);*/
	/*warn ("argv[0] = %s\n", argv[0]);*/
	for (i = 0 ; i < len ; i++) {
		SV * sv = av_shift (ARGV);
		shadow[i] = argv[i+1] = g_strdup (SvPV_nolen (sv));
		/*warn ("argv[%d] = %s\n", i+1, argv[i+1]);*/
	}
	/* note that we've emptied @ARGV. */
	/* use it... */
	if (ix == 2) {
		RETVAL = gtk_init_check (&argc, &argv);
	} else {
		gtk_init (&argc, &argv);
		/* if this fails, it does not return. */
		RETVAL = TRUE;
	}

	/* refill @ARGV with whatever gtk_init didn't steal. */
	for (i = 1 ; i < argc ; i++) {
		av_push (ARGV, newSVpv (argv[i], 0));
		/*warn ("pushing back %s\n", argv[i]);*/
	}
	g_free (argv);
	g_strfreev (shadow);
    OUTPUT:
	RETVAL

 ##void           gtk_disable_setlocale    (void);
void gtk_disable_setlocale (SV * class)
    C_ARGS:
	/*void*/

 ##gchar *        gtk_set_locale           (void);
const gchar * gtk_set_locale (SV * class)
    C_ARGS:
	/*void*/

 ##PangoLanguage *gtk_get_default_language (void);

gint
gtk_events_pending (class)
	SV * class
    C_ARGS:

 ##
 ##/* The following is the event func GTK+ registers with GDK
 ## * we expose it mainly to allow filtering of events between
 ## * GDK and GTK+.
 ## */
 ##void 	   gtk_main_do_event	   (GdkEvent           *event);

void
gtk_main (class)
	SV * class
    C_ARGS:
	/*void*/

guint
gtk_main_level (class)
	SV * class
    C_ARGS:
	/*void*/

void
gtk_main_quit (class)
	SV * class
    C_ARGS:
	/*void*/

gboolean
gtk_main_iteration (class)
	SV * class
    C_ARGS:
	/*void*/

 ### gtk-perl implemented these as widget methods, but they are not widget
 ### methods.  they deal with the global grab setting.  this is bound to 
 ### be a FAQ.

 ## Gtk2->grab_add (widget)
void
gtk_grab_add (class, widget)
	SV * class
	GtkWidget * widget
    C_ARGS:
	widget

GtkWidget_ornull *
gtk_grab_get_current (class)
	SV * class
    C_ARGS:
	/*void*/

 ## Gtk2->grab_remove (widget)
void
gtk_grab_remove	(class, widget)
	SV * class
	GtkWidget * widget
    C_ARGS:
	widget

void 
gtk_init_add (class, function, data=NULL)
	SV          * class
	SV          * function
	SV          * data
    PREINIT:
	GPerlCallback * real_callback;
    CODE:
	real_callback = gperl_callback_new(function, data, 
				0, NULL, G_TYPE_BOOLEAN);
	gtk_init_add((GtkFunction)gtk2perl_init_add_callback_invoke,
		     real_callback);

## guint gtk_quit_add
## guint gtk_quit_add_full
guint
gtk_quit_add (class, main_level, function, data=NULL)
	SV    * class
	guint   main_level
	SV    * function
	SV    * data
    PREINIT:
    	GPerlCallback * real_callback;
    CODE:
	real_callback = gperl_callback_new(function, data, 
				0, NULL, G_TYPE_UINT);
	RETVAL = gtk_quit_add_full(main_level, 
			  (GtkFunction)gtk2perl_quit_add_callback_invoke, 
			  NULL, real_callback, 
			  (GtkDestroyNotify)gperl_callback_destroy);
    OUTPUT:
	RETVAL

void	   
gtk_quit_remove (class, quit_handler_id)
	SV    * class
	guint   quit_handler_id
    C_ARGS:
    	quit_handler_id

## void gtk_quit_add_destroy (guint main_level, GtkObject *object);
void gtk_quit_add_destroy (SV * class, guint main_level, GtkObject *object)
    C_ARGS:
	main_level, object

 ##void	   gtk_quit_remove_by_data (gpointer	       data);

# these (timeout, idle, and input) are all deprecated in favor of the 
# corresponding glib functions.
 ##guint   gtk_timeout_add	   (guint32	       interval,
 ##				    GtkFunction	       function,
 ##				    gpointer	       data);
 ##guint   gtk_timeout_add_full	   (guint32	       interval,
 ##				    GtkFunction	       function,
 ##				    GtkCallbackMarshal marshal,
 ##				    gpointer	       data,
 ##				    GtkDestroyNotify   destroy);
 ##void	   gtk_timeout_remove	   (guint	       timeout_handler_id);
 ##
 ##guint   gtk_idle_add		   (GtkFunction	       function,
 ##				    gpointer	       data);
 ##guint   gtk_idle_add_priority   (gint	       priority,
 ##     			    GtkFunction	       function,
 ##				    gpointer	       data);
 ##guint   gtk_idle_add_full	   (gint	       priority,
 ##				    GtkFunction	       function,
 ##				    GtkCallbackMarshal marshal,
 ##				    gpointer	       data,
 ##				    GtkDestroyNotify   destroy);
 ##void	   gtk_idle_remove	   (guint	       idle_handler_id);
 ##void	   gtk_idle_remove_by_data (gpointer	       data);
 ##guint   gtk_input_add_full	   (gint	       source,
 ##				    GdkInputCondition  condition,
 ##				    GdkInputFunction   function,
 ##				    GtkCallbackMarshal marshal,
 ##				    gpointer	       data,
 ##				    GtkDestroyNotify   destroy);
 ##void	   gtk_input_remove	   (guint	       input_handler_id);

# FIXME there's no way to keep this from leaking the callback.
 ##guint   gtk_key_snooper_install (GtkKeySnoopFunc snooper,
 ##				    gpointer	    func_data);
# FIXME pointless without key snooper install
 ##void	   gtk_key_snooper_remove  (guint	    snooper_handler_id);

 ##GdkEvent*       gtk_get_current_event       (void);
GdkEvent_own_ornull*
gtk_get_current_event (SV * class)
    C_ARGS:
	/*void*/

 ##guint32         gtk_get_current_event_time  (void);
guint32 gtk_get_current_event_time (SV * class);
    C_ARGS:
	/*void*/

 ##gboolean        gtk_get_current_event_state (GdkModifierType *state);
GdkModifierType gtk_get_current_event_state (SV * class)
    CODE:
	if (!gtk_get_current_event_state (&RETVAL))
		XSRETURN_UNDEF;
    OUTPUT:
	RETVAL

 ##GtkWidget* gtk_get_event_widget	   (GdkEvent	   *event);
GtkWidget_ornull *
gtk_get_event_widget (SV * class, GdkEvent_ornull * event)
    C_ARGS:
	event

 ## the docs say you shouldn't need this outside implementing gtk itself.
 ##void gtk_propagate_event (GtkWidget * widget, GdkEvent * event);
