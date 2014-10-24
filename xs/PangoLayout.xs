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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/PangoLayout.xs,v 1.2 2003/05/22 14:23:24 muppetman Exp $
 */

#include "gtk2perl.h"

SV *
newSVPangoLogAttr (PangoLogAttr * logattr)
{
	HV * hv = newHV ();

	hv_store (hv, "is_line_break",        13, newSViv (logattr->is_line_break),        0);
	hv_store (hv, "is_mandatory_break",   18, newSViv (logattr->is_mandatory_break),   0);
	hv_store (hv, "is_char_break",        13, newSViv (logattr->is_char_break),        0);
	hv_store (hv, "is_white",              8, newSViv (logattr->is_white),             0);
	hv_store (hv, "is_cursor_position",   18, newSViv (logattr->is_cursor_position),   0);
	hv_store (hv, "is_word_start",        13, newSViv (logattr->is_word_start),        0);
	hv_store (hv, "is_word_end",          11, newSViv (logattr->is_word_end),          0);
	hv_store (hv, "is_sentence_boundary", 20, newSViv (logattr->is_sentence_boundary), 0);
	hv_store (hv, "is_sentence_start",    17, newSViv (logattr->is_sentence_start),    0);
	hv_store (hv, "is_sentence_end",      15, newSViv (logattr->is_sentence_end),      0);

	return newRV_noinc ((SV*) hv);
}

MODULE = Gtk2::Pango::Layout	PACKAGE = Gtk2::Pango::Layout	PREFIX = pango_layout_

##  PangoLayout *pango_layout_new (PangoContext *context) 
PangoLayout_noinc *
pango_layout_new (class, context)
	SV * class
	PangoContext * context
    C_ARGS:
	context

##  PangoLayout *pango_layout_copy (PangoLayout *src) 
PangoLayout_noinc *
pango_layout_copy (src)
	PangoLayout *src

##  PangoContext *pango_layout_get_context (PangoLayout *layout) 
PangoContext *
pango_layout_get_context (layout)
	PangoLayout *layout

##  void pango_layout_set_attributes (PangoLayout *layout, PangoAttrList *attrs) 
void
pango_layout_set_attributes (layout, attrs)
	PangoLayout *layout
	PangoAttrList *attrs

##  PangoAttrList *pango_layout_get_attributes (PangoLayout *layout) 
PangoAttrList *
pango_layout_get_attributes (layout)
	PangoLayout *layout

##  void pango_layout_set_text (PangoLayout *layout, const char *text, int length) 
void
pango_layout_set_text (layout, text)
	PangoLayout *layout
	const gchar *text
    C_ARGS:
	layout, text, -1

##  const char * pango_layout_get_text (PangoLayout *layout);
const gchar *
pango_layout_get_text (layout)
	PangoLayout * layout

##  void pango_layout_set_markup (PangoLayout *layout, const char *markup, int length) 
void
pango_layout_set_markup (layout, markup)
	PangoLayout *layout
	const gchar *markup
    C_ARGS:
	layout, markup, -1

###  void pango_layout_set_markup_with_accel (PangoLayout *layout, const char *markup, int length, gunichar accel_marker, gunichar *accel_char) 
#void
#pango_layout_set_markup_with_accel (layout, markup, length, accel_marker, accel_char)
#	PangoLayout *layout
#	const gchar *markup
#	int length
#	gunichar accel_marker
#	gunichar *accel_char
#    C_ARGS:
#	layout, markup, -1, accel_marker, accel_char

##  void pango_layout_set_font_description (PangoLayout *layout, const PangoFontDescription *desc) 
void
pango_layout_set_font_description (layout, desc)
	PangoLayout *layout
	PangoFontDescription_ornull *desc


##  int pango_layout_get_width (PangoLayout *layout) 
##  int pango_layout_get_indent (PangoLayout *layout) 
##  int pango_layout_get_spacing (PangoLayout *layout) 
##  gboolean pango_layout_get_justify (PangoLayout *layout) 
##  gboolean pango_layout_get_single_paragraph_mode (PangoLayout *layout) 
int
int_getters (layout)
	PangoLayout * layout
    ALIAS:
	Gtk2::Pango::Layout::get_width = 1
	Gtk2::Pango::Layout::get_indent = 2
	Gtk2::Pango::Layout::get_spacing = 3
	Gtk2::Pango::Layout::get_justify = 4
	Gtk2::Pango::Layout::get_single_paragraph_mode = 5
    CODE:
	switch (ix) {
		case 1: RETVAL = pango_layout_get_width (layout); break;
		case 2: RETVAL = pango_layout_get_indent (layout); break;
		case 3: RETVAL = pango_layout_get_spacing (layout); break;
		case 4: RETVAL = pango_layout_get_justify (layout); break;
		case 5: RETVAL = pango_layout_get_single_paragraph_mode (layout); break;
	}
   OUTPUT:
	RETVAL

##  void pango_layout_set_width (PangoLayout *layout, int width) 
##  void pango_layout_set_indent (PangoLayout *layout, int indent) 
##  void pango_layout_set_spacing (PangoLayout *layout, int spacing) 
##  void pango_layout_set_justify (PangoLayout *layout, gboolean justify) 
##  void pango_layout_set_single_paragraph_mode (PangoLayout *layout, gboolean setting) 
void
int_setters (layout, newval)
	PangoLayout * layout
	int newval
    ALIAS:
	Gtk2::Pango::Layout::set_width = 1
	Gtk2::Pango::Layout::set_indent = 2
	Gtk2::Pango::Layout::set_spacing = 3
	Gtk2::Pango::Layout::set_justify = 4
	Gtk2::Pango::Layout::set_single_paragraph_mode = 5
    CODE:
	switch (ix) {
		case 1: pango_layout_set_width (layout, newval); break;
		case 2: pango_layout_set_indent (layout, newval); break;
		case 3: pango_layout_set_spacing (layout, newval); break;
		case 4: pango_layout_set_justify (layout, newval); break;
		case 5: pango_layout_set_single_paragraph_mode (layout, newval); break;
	}


##  void pango_layout_set_wrap (PangoLayout *layout, PangoWrapMode wrap) 
void
pango_layout_set_wrap (layout, wrap)
	PangoLayout *layout
	PangoWrapMode wrap

##  PangoWrapMode pango_layout_get_wrap (PangoLayout *layout) 
PangoWrapMode
pango_layout_get_wrap (layout)
	PangoLayout *layout


##  void pango_layout_set_alignment (PangoLayout *layout, PangoAlignment alignment) 
void
pango_layout_set_alignment (layout, alignment)
	PangoLayout *layout
	PangoAlignment alignment

##  PangoAlignment pango_layout_get_alignment (PangoLayout *layout) 
PangoAlignment
pango_layout_get_alignment (layout)
	PangoLayout *layout

##  void pango_layout_set_tabs (PangoLayout *layout, PangoTabArray *tabs) 
void
pango_layout_set_tabs (layout, tabs)
	PangoLayout *layout
	PangoTabArray_ornull *tabs

##  PangoTabArray* pango_layout_get_tabs (PangoLayout *layout) 
PangoTabArray_own_ornull *
pango_layout_get_tabs (layout)
	PangoLayout *layout


##  void pango_layout_context_changed (PangoLayout *layout) 
void
pango_layout_context_changed (layout)
	PangoLayout *layout

##  void pango_layout_get_log_attrs (PangoLayout *layout, PangoLogAttr **attrs, gint *n_attrs) 
void
pango_layout_get_log_attrs (layout)
	PangoLayout * layout
    PREINIT:
	PangoLogAttr * attrs = NULL;
	gint n_attrs;
    PPCODE:
	pango_layout_get_log_attrs (layout, &attrs, &n_attrs);
	if (n_attrs) {
		int i;
		EXTEND (SP, n_attrs);
		for (i = 0 ; i < n_attrs; i++)
			PUSHs (sv_2mortal (newSVPangoLogAttr (attrs+i)));
		g_free (attrs);
	}

###  void pango_layout_index_to_pos (PangoLayout *layout, int index_, PangoRectangle *pos) 
#void pango_layout_index_to_pos (PangoLayout *layout, int index_, OUTLIST PangoRectangle *pos) 
#
###  void pango_layout_get_cursor_pos (PangoLayout *layout, int index_, PangoRectangle *strong_pos, PangoRectangle *weak_pos) 
#void pango_layout_get_cursor_pos (PangoLayout *layout, int index_, OUTLIST PangoRectangle *strong_pos, OUTLIST PangoRectangle *weak_pos) 

##  void pango_layout_move_cursor_visually (PangoLayout *layout, gboolean strong, int old_index, int old_trailing, int direction, int *new_index, int *new_trailing) 
void pango_layout_move_cursor_visually (PangoLayout *layout, gboolean strong, int old_index, int old_trailing, int direction, OUTLIST int new_index, OUTLIST int new_trailing) 

##  gboolean pango_layout_xy_to_index (PangoLayout *layout, int x, int y, int *index_, int *trailing) 
void
pango_layout_xy_to_index (layout, x, y)
	PangoLayout *layout
	int x
	int y
    PREINIT:
	int index_;
	int trailing;
    PPCODE:
	if (pango_layout_xy_to_index (layout, x, y, &index_, &trailing)) {
		EXTEND (SP, 2);
		PUSHs (sv_2mortal (newSViv (index_)));
		PUSHs (sv_2mortal (newSViv (trailing)));
	}

###  void pango_layout_get_extents (PangoLayout *layout, PangoRectangle *ink_rect, PangoRectangle *logical_rect) 
#void pango_layout_get_extents (PangoLayout *layout, OUTLIST PangoRectangle *ink_rect, OUTLIST PangoRectangle *logical_rect) 
#
###  void pango_layout_get_pixel_extents (PangoLayout *layout, PangoRectangle *ink_rect, PangoRectangle *logical_rect) 
#void pango_layout_get_pixel_extents (PangoLayout *layout, OUTLIST PangoRectangle *ink_rect, OUTLIST PangoRectangle *logical_rect) 

##  void pango_layout_get_size (PangoLayout *layout, int *width, int *height) 
void pango_layout_get_size (PangoLayout *layout, OUTLIST int width, OUTLIST int height) 

##  void pango_layout_get_pixel_size (PangoLayout *layout, int *width, int *height) 
void pango_layout_get_pixel_size (PangoLayout *layout, OUTLIST int width, OUTLIST int height) 

##  int pango_layout_get_line_count (PangoLayout *layout) 
int
pango_layout_get_line_count (layout)
	PangoLayout *layout

####  PangoLayoutLine *pango_layout_get_line (PangoLayout *layout, int line) 
##PangoLayoutLine_ornull *
##pango_layout_get_line (layout, line)
##	PangoLayout *layout
##	int line
##
####  GSList * pango_layout_get_lines (PangoLayout *layout) 
##void
##pango_layout_get_lines (layout)
##	PangoLayout *layout
##    PREINIT:
##	GSList * lines, * i;
##    PPCODE:
##	lines = pango_layout_get_lines (layout);
##	for (i = lines ; i != NULL ; i = i->next)
##		XPUSHs (sv_2mortal (newSVPangoLayoutLine (i->data)));
##	/* docs do not say that you are to free this, so i don't */
##
##MODULE = Gtk2::Pango::Layout	PACKAGE = Gtk2::Pango::LayoutLine	PREFIX = pango_layout_line_
##
####  void pango_layout_line_ref (PangoLayoutLine *line) 
####  void pango_layout_line_unref (PangoLayoutLine *line) 
##
####  gboolean pango_layout_line_x_to_index (PangoLayoutLine *line, int x_pos, int *index_, int *trailing) 
##void
##pango_layout_line_x_to_index (line, x_pos)
##	PangoLayoutLine *line
##	int x_pos
##    PREINIT:
##	int index_, trailing;
##    PPCODE:
##	if (pango_layout_line_x_to_index (line, x_pos, &index_, &trailing))
##		EXTEND (SP, 2);
##		PUSHs (sv_2mortal (newSViv (index_)));
##		PUSHs (sv_2mortal (newSViv (trailing)));
##	}
##
####  void pango_layout_line_index_to_x (PangoLayoutLine *line, int index_, gboolean trailing, int *x_pos) 
##void
##pango_layout_line_index_to_x (line, index_, trailing, x_pos)
##	PangoLayoutLine *line
##	int index_
##	gboolean trailing
##	int *x_pos
##
####  void pango_layout_line_get_x_ranges (PangoLayoutLine *line, int start_index, int end_index, int **ranges, int *n_ranges) 
##void
##pango_layout_line_get_x_ranges (line, start_index, end_index, ranges, n_ranges)
##	PangoLayoutLine *line
##	int start_index
##	int end_index
##	int **ranges
##	int *n_ranges
##
####  void pango_layout_line_get_extents (PangoLayoutLine *line, PangoRectangle *ink_rect, PangoRectangle *logical_rect) 
##void
##pango_layout_line_get_extents (line, ink_rect, logical_rect)
##	PangoLayoutLine *line
##	PangoRectangle *ink_rect
##	PangoRectangle *logical_rect
##
####  void pango_layout_line_get_pixel_extents (PangoLayoutLine *layout_line, PangoRectangle *ink_rect, PangoRectanfound and converted 62 (potential) functions
##gle *logical_rect) 
##void
##pango_layout_line_get_pixel_extents (layout_line, ink_rect, logical_rect)
##	PangoLayoutLine *layout_line
##	PangoRectangle *ink_rect
##	PangoRectangle *logical_rect
##
####  PangoLayoutIter *pango_layout_get_iter (PangoLayout *layout) 
##PangoLayoutIter *
##pango_layout_get_iter (layout)
##	PangoLayout *layout
##
##MODULE = Gtk2::Pango::Layout	PACKAGE = Gtk2::Pango::LayoutIter	PREFIX = pango_layout_iter_
##
####  void pango_layout_iter_free (PangoLayoutIter *iter) 
##
####  int pango_layout_iter_get_index (PangoLayoutIter *iter) 
##int
##pango_layout_iter_get_index (iter)
##	PangoLayoutIter *iter
##
####  PangoLayoutRun *pango_layout_iter_get_run (PangoLayoutIter *iter) 
##PangoLayoutRun *
##pango_layout_iter_get_run (iter)
##	PangoLayoutIter *iter
##
####  PangoLayoutLine *pango_layout_iter_get_line (PangoLayoutIter *iter) 
##PangoLayoutLine *
##pango_layout_iter_get_line (iter)
##	PangoLayoutIter *iter
##
####  gboolean pango_layout_iter_at_last_line (PangoLayoutIter *iter) 
##gboolean
##pango_layout_iter_at_last_line (iter)
##	PangoLayoutIter *iter
##
####  gboolean pango_layout_iter_next_char (PangoLayoutIter *iter) 
##gboolean
##pango_layout_iter_next_char (iter)
##	PangoLayoutIter *iter
##
####  gboolean pango_layout_iter_next_cluster (PangoLayoutIter *iter) 
##gboolean
##pango_layout_iter_next_cluster (iter)
##	PangoLayoutIter *iter
##
####  gboolean pango_layout_iter_next_run (PangoLayoutIter *iter) 
##gboolean
##pango_layout_iter_next_run (iter)
##	PangoLayoutIter *iter
##
####  gboolean pango_layout_iter_next_line (PangoLayoutIter *iter) 
##gboolean
##pango_layout_iter_next_line (iter)
##	PangoLayoutIter *iter
##
####  void pango_layout_iter_get_char_extents (PangoLayoutIter *iter, PangoRectangle *logical_rect) 
##void
##pango_layout_iter_get_char_extents (iter, logical_rect)
##	PangoLayoutIter *iter
##	PangoRectangle *logical_rect
##
####  void pango_layout_iter_get_cluster_extents (PangoLayoutIter *iter, PangoRectangle *ink_rect, PangoRectangle *logical_rect) 
##void
##pango_layout_iter_get_cluster_extents (iter, ink_rect, logical_rect)
##	PangoLayoutIter *iter
##	PangoRectangle *ink_rect
##	PangoRectangle *logical_rect
##
####  void pango_layout_iter_get_run_extents (PangoLayoutIter *iter, PangoRectangle *ink_rect, PangoRectangle *logical_rect) 
##void
##pango_layout_iter_get_run_extents (iter, ink_rect, logical_rect)
##	PangoLayoutIter *iter
##	PangoRectangle *ink_rect
##	PangoRectangle *logical_rect
##
####  void pango_layout_iter_get_line_extents (PangoLayoutIter *iter, PangoRectangle *ink_rect, PangoRectangle *logical_rect) 
##void
##pango_layout_iter_get_line_extents (iter, ink_rect, logical_rect)
##	PangoLayoutIter *iter
##	PangoRectangle *ink_rect
##	PangoRectangle *logical_rect
##
####  void pango_layout_iter_get_line_yrange (PangoLayoutIter *iter, int *y0_, int *y1_) 
##void
##pango_layout_iter_get_line_yrange (iter, y0_, y1_)
##	PangoLayoutIter *iter
##	int *y0_
##	int *y1_
##
####  void pango_layout_iter_get_layout_extents (PangoLayoutIter *iter, PangoRectangle *ink_rect, PangoRectangle *logical_rect) 
##void
##pango_layout_iter_get_layout_extents (iter, ink_rect, logical_rect)
##	PangoLayoutIter *iter
##	PangoRectangle *ink_rect
##	PangoRectangle *logical_rect
##
####  int pango_layout_iter_get_baseline (PangoLayoutIter *iter) 
##int
##pango_layout_iter_get_baseline (iter)
##	PangoLayoutIter *iter
#
