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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkStock.xs,v 1.14.2.1 2003/12/04 00:21:16 rwmcfa1 Exp $
 */

#include "gtk2perl.h"

/*
struct GtkStockItem {

  gchar *stock_id;
  gchar *label;
  GdkModifierType modifier;
  guint keyval;
  gchar *translation_domain;
};
*/

HV * 
stock_item_to_hv (GtkStockItem * item)
{
	HV * hv = newHV();
	hv_store (hv, "stock_id", 8, newSVpv (item->stock_id, 0), 0);
	hv_store (hv, "label", 5, newSVpv (item->label, 0), 0);
	hv_store (hv, "modifier", 8, newSVGdkModifierType (item->modifier), 0);
	hv_store (hv, "keyval", 6, newSVuv (item->keyval), 0);
	if (item->translation_domain)
	hv_store (hv, "translation_domain", 18, newSVpv (item->translation_domain, 0), 0);
	return hv;
}

/*
 * returns a pointer to a temp stock item you can use until control returns 
 * to perl.
 */
GtkStockItem * 
SvGtkStockItem (SV * sv)
{
	HV * hv;
	SV ** svp;
	GtkStockItem * item;

	if (! (sv && SvOK (sv) && SvROK (sv) &&
	       SvTYPE (SvRV (sv)) == SVt_PVHV))
		croak ("malformed stock item; use a reference to a hash as a stock item");

	hv = (HV*) SvRV (sv);

	item = gperl_alloc_temp (sizeof (GtkStockItem));

	svp = hv_fetch (hv, "stock_id", 8, FALSE);
	if (svp) item->stock_id = SvGChar (*svp);
	
	svp = hv_fetch (hv, "label", 5, FALSE);
	if (svp) item->label = SvGChar (*svp);

	svp = hv_fetch (hv, "modifier", 8, FALSE);
	if (svp) item->modifier = SvGdkModifierType (*svp);

	svp = hv_fetch (hv, "keyval", 6, FALSE);
	if (svp) item->keyval = SvUV (*svp);

	svp = hv_fetch (hv, "translation_domain", 18, FALSE);
	if (svp) item->translation_domain = SvGChar (*svp);

	return item;
}


MODULE = Gtk2::Stock	PACKAGE = Gtk2::Stock	PREFIX = gtk_stock_

=for include build/stock_items.podi
=cut

###  void gtk_stock_add (const GtkStockItem *items, guint n_items) 
=for apidoc
=for arg ... of Gtk2::StockItem's to be added
=cut
void
gtk_stock_add (class, ...)
    PREINIT:
	int i;
    CODE:
	for (i = 1 ; i < items ; i++)
		gtk_stock_add (SvGtkStockItem (ST (i)), 1);

## you don't really ever get static memory from perl, so this is irrelevant.
###  void gtk_stock_add_static (const GtkStockItem *items, guint n_items) 

##  gboolean gtk_stock_lookup (const gchar *stock_id, GtkStockItem *item) 
SV *
gtk_stock_lookup (class, stock_id)
	const gchar *stock_id
    PREINIT:
	GtkStockItem item;
	HV * hv;
    CODE:
	if (! gtk_stock_lookup (stock_id, &item))
		XSRETURN_UNDEF;
	hv = stock_item_to_hv (&item);
	RETVAL = newRV_noinc ((SV*)hv);
    OUTPUT:
	RETVAL

##  GSList* gtk_stock_list_ids (void) 
=for apidoc
Returns a list of strings, the stock-ids.
=cut
void
gtk_stock_list_ids (class)
    PREINIT:
	GSList * ids, * i;
    PPCODE:
	ids = gtk_stock_list_ids ();
	for (i = ids ; i != NULL ; i = i->next) {
		XPUSHs (sv_2mortal (newSVpv ((char*)(i->data), 0)));
		g_free (i->data);
	}
	g_slist_free (ids);

## Boxed type support
###  GtkStockItem *gtk_stock_item_copy (const GtkStockItem *item) 
###  void gtk_stock_item_free (GtkStockItem *item) 

