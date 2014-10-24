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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/gtk2perl.h,v 1.13 2003/08/18 16:22:46 muppetman Exp $
 */

#ifndef _GTK2PERL_H_
#define _GTK2PERL_H_

#include <gperl.h>
#include <gtk/gtk.h>
#include "gtk2perl-autogen.h"

#ifdef GDK_WINDOWING_WIN32 /* no plug/socket on win32 despite patches exist for years. */
# undef GTK_TYPE_PLUG
# undef GTK_TYPE_SOCKET
#endif

/**
 * gtk2perl_new_gtkobject:
 * @object: object to wrap.
 * 
 * convenient wrapper around gperl_new_object() which always passes %TRUE
 * for gperl_new_object()'s "own" parameter.  for #GtkObjects, that parameter
 * merely results in gtk_object_sink() being called; if the object was not
 * floating, this does nothing.  thus, everything just works out.
 *
 * returns: scalar wrapper for @object.
 *
 * in xs/GtkObject.xs 
 */
SV * gtk2perl_new_gtkobject (GtkObject * object);


/*
custom handling for GdkBitmaps, since there are no typemacros for them.
*/
/* GObject derivative GdkBitmap */
#define SvGdkBitmap(sv)       ((GdkBitmap*)gperl_get_object_check (sv, GDK_TYPE_DRAWABLE))
typedef GdkBitmap GdkBitmap_ornull;
#define SvGdkBitmap_ornull(sv)        (((sv) == &PL_sv_undef) ? NULL : SvGdkBitmap(sv))
typedef GdkBitmap GdkBitmap_noinc;
/* these are real functions, rather than macros, because there's some extra
 * work involved in making sure it's blessed into Gtk2::Gdk::Bitmap when no
 * GType exists for GdkBitmap. */
SV * newSVGdkBitmap (GdkBitmap * bitmap);
SV * newSVGdkBitmap_noinc (GdkBitmap * bitmap);


/*
 * override the autogen stuff for GdkModifierType, so we can make sure
 * that GDK_MODIFIER_MASK doesn't get in there and mess things up.
 * (it has multiple bits set and therefore matches everything!)
 */
#undef newSVGdkModifierType
SV * newSVGdkModifierType (GdkModifierType mods);

/*
 * GdkAtom, an opaque pointer
 */
SV * newSVGdkAtom (GdkAtom atom);
GdkAtom SvGdkAtom (SV * sv);

SV * newSVGtkTargetEntry (GtkTargetEntry * target_entry);
/* do not store GtkTargetEntry objects returned from this function -- 
 * they are only good for the block of code in which they are created */
GtkTargetEntry * SvGtkTargetEntry (SV * sv);
void gtk2perl_read_gtk_target_entry (SV * sv, GtkTargetEntry * entry);


/* 
 * get a list of GTypes from the xsub argument stack
 * used to collect column types for creating and initializing GtkTreeStores
 * and GtkListStores.
 */
#define GTK2PERL_STACK_ITEMS_TO_GTYPE_ARRAY(arrayvar, first, last)	\
	(arrayvar) = g_array_new (FALSE, FALSE, sizeof (GType));	\
	g_array_set_size ((arrayvar), (last) - (first) + 1);		\
	{								\
	int i;								\
	for (i = (first) ; i <= (last) ; i++) {				\
		char * package = SvPV_nolen (ST (i));			\
		/* look up GType by package name. */			\
		GType t = gperl_type_from_package (package);		\
		if (t == 0) {						\
			g_array_free ((arrayvar), TRUE);		\
			croak ("package %s is not registered with GPerl", \
			       package);				\
			g_assert ("not reached");			\
		}							\
		g_array_index ((arrayvar), GType, i-(first)) = t;	\
	}								\
	}

#endif /* _GTK2PERL_H_ */
