/*
 * Copyright (c) 2003 by the gtk2-perl team (see the file AUTHORS)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/Gtk2.xs,v 1.20.2.2 2004/01/15 03:51:50 muppetman Exp $
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

	/* according to the gtk source, init callbacks are forgotten
	 * immediately after use; thus, we need to destroy the callback
	 * object to avoid a leak. */
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

static gint
gtk2perl_key_snoop_func (GtkWidget *grab_widget,
                         GdkEventKey *event,
                         gpointer func_data)
{
	gint ret;
	GValue retval = {0,};
	g_value_init (&retval, G_TYPE_INT);
	gperl_callback_invoke ((GPerlCallback*)func_data, &retval,
	                       grab_widget, event);
	ret = g_value_get_int (&retval);
	g_value_unset (&retval);
	return ret;
}

/*
 * we must track the key snoopers ourselves so we can destroy
 * the callback objects properly.
 */
static GHashTable * key_snoopers = NULL;

static guint
install_key_snooper (SV * func, SV * data)
{
	guint id; 
	GPerlCallback * callback;
	GType param_types[] = { GTK_TYPE_WIDGET, GDK_TYPE_EVENT };
	if (!key_snoopers)
		key_snoopers =
			g_hash_table_new_full (g_direct_hash,
			                       g_direct_equal,
			                       NULL,
			                       (GDestroyNotify)
			                           gperl_callback_destroy);
	callback = gperl_callback_new (func, data, 2, param_types, G_TYPE_INT);
	id = gtk_key_snooper_install (gtk2perl_key_snoop_func, callback);
	g_hash_table_insert (key_snoopers, GUINT_TO_POINTER (id), callback);
	return id;
}

static void
remove_key_snooper (guint id)
{
	g_return_if_fail (key_snoopers != NULL);
	gtk_key_snooper_remove (id);
	g_hash_table_remove (key_snoopers, GUINT_TO_POINTER (id));
}

MODULE = Gtk2		PACKAGE = Gtk2		PREFIX = gtk_

=for object Gtk2::main

=cut

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
	/* route Gtk+ log messages through perl's warn() and croak() */
	gperl_handle_logs_for ("Gtk");
	gperl_handle_logs_for ("Gdk");
	gperl_handle_logs_for ("GdkPixbuf");
	gperl_handle_logs_for ("Pango");
	}

 ##GTKMAIN_C_VAR const guint gtk_binary_age;
 ##GTKMAIN_C_VAR const guint gtk_interface_age;

=for apidoc
=for signature (major_version, minor_version, micro_version) = Gtk2->version_info
=cut
void
gtk_get_version_info (class)
    PPCODE:
	EXTEND(SP,3);
	PUSHs(sv_2mortal(newSViv(gtk_major_version)));
	PUSHs(sv_2mortal(newSViv(gtk_minor_version)));
	PUSHs(sv_2mortal(newSViv(gtk_micro_version)));

gchar * 
gtk_check_version (class, required_major, required_minor, required_micro)
	guint   required_major
	guint   required_minor
	guint   required_micro
    C_ARGS:
	required_major, required_minor, required_micro

=for apidoc Gtk2::init_check
This is the non-fatal version of C<< Gtk2->init >>; instead of calling C<exit>
if Gtk+ initialization fails, C<< Gtk2->init_check >> returns false.  This
allows your application to fall back on some other means of communication with
the user - for example a curses or command-line interface.
=cut

=for apidoc
Initialize Gtk+.  This must be called before any other Gtk2 functions in a 
GUI application; the Gtk2 module's import method allows you to pass C<-init>
in the C<use> statement to do this automatically.  This function also scans
I<@ARGV> for any options it knows, and will remove them automagically.

Note: this function will terminate your program if it is unable to initialize
the gui for any reason.  If you want your program to fall back to some other
interface, you want to use C<< Gtk2->init_check >> instead.
=cut
gboolean
gtk_init (class)
    ALIAS:
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
void gtk_disable_setlocale (class)
    C_ARGS:
	/*void*/

 ##gchar *        gtk_set_locale           (void);
const gchar * gtk_set_locale (class)
    C_ARGS:
	/*void*/

 ##PangoLanguage *gtk_get_default_language (void);

gint
gtk_events_pending (class)
    C_ARGS:
	/*void*/

 ##
 ##/* The following is the event func GTK+ registers with GDK
 ## * we expose it mainly to allow filtering of events between
 ## * GDK and GTK+.
 ## */
 ##void 	   gtk_main_do_event	   (GdkEvent           *event);

void
gtk_main (class)
    C_ARGS:
	/*void*/

guint
gtk_main_level (class)
    C_ARGS:
	/*void*/

void
gtk_main_quit (class)
    C_ARGS:
	/*void*/

gboolean
gtk_main_iteration (class)
    C_ARGS:
	/*void*/

 ### gtk-perl implemented these as widget methods, but they are not widget
 ### methods.  they deal with the global grab setting.  this is bound to 
 ### be a FAQ.

 ## Gtk2->grab_add (widget)
void
gtk_grab_add (class, widget)
	GtkWidget * widget
    C_ARGS:
	widget

GtkWidget_ornull *
gtk_grab_get_current (class)
    C_ARGS:
	/*void*/

 ## Gtk2->grab_remove (widget)
void
gtk_grab_remove	(class, widget)
	GtkWidget * widget
    C_ARGS:
	widget

void 
gtk_init_add (class, function, data=NULL)
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
	guint   quit_handler_id
    C_ARGS:
    	quit_handler_id

## void gtk_quit_add_destroy (guint main_level, GtkObject *object);
void gtk_quit_add_destroy (class, guint main_level, GtkObject *object)
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

 ##guint gtk_key_snooper_install (GtkKeySnoopFunc snooper, gpointer func_data);
=for apidoc
=for arg snooper (subroutine) function to call on every event, must return a boolean
Install a key "snooper" function, which will get called on all key events
before those events are delivered normally.  These snoopers can be used to
implement custom key event handling.  I<snooper> will receive the widget to
which the event will be delivered and the event, and also I<func_data> (if
provided).  If I<snooper> returns true, the event propagation will stop
(just like normal event handlers).

C<key_snooper_install> returns an id that may be used with
C<key_snooper_remove>.
=cut
guint gtk_key_snooper_install (class, SV * snooper, SV * func_data=NULL)
    CODE:
	RETVAL = install_key_snooper (snooper, func_data);
    OUTPUT:
	RETVAL

 ##void	gtk_key_snooper_remove (guint snooper_handler_id);
void gtk_key_snooper_remove (class, guint snooper_handler_id)
    CODE:
	remove_key_snooper (snooper_handler_id);

 ##GdkEvent*       gtk_get_current_event       (void);
GdkEvent_own_ornull*
gtk_get_current_event (class)
    C_ARGS:
	/*void*/

 ##guint32         gtk_get_current_event_time  (void);
guint32 gtk_get_current_event_time (class);
    C_ARGS:
	/*void*/

 ##gboolean        gtk_get_current_event_state (GdkModifierType *state);
GdkModifierType gtk_get_current_event_state (class)
    CODE:
	if (!gtk_get_current_event_state (&RETVAL))
		XSRETURN_UNDEF;
    OUTPUT:
	RETVAL

 ##GtkWidget* gtk_get_event_widget	   (GdkEvent	   *event);
GtkWidget_ornull *
gtk_get_event_widget (class, GdkEvent_ornull * event)
    C_ARGS:
	event

 ## the docs say you shouldn't need this outside implementing gtk itself.
 ##void gtk_propagate_event (GtkWidget * widget, GdkEvent * event);

# this stuff is only here to generate pod pages for abstract and functionless
# object, that is the objects exist only as parents and have no functions of
# their own

=for object Gtk2::Separator
=cut

=for object Gtk2::Scrollbar
=cut
