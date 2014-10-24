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
 * $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/xs/GtkRadioButton.xs,v 1.10 2003/09/22 00:04:25 rwmcfa1 Exp $
 */

#include "gtk2perl.h"

MODULE = Gtk2::RadioButton	PACKAGE = Gtk2::RadioButton	PREFIX = gtk_radio_button_


GtkWidget *
gtk_radio_button_new (class, member_or_listref=NULL, label=NULL)
	SV          * class
	SV          * member_or_listref
	const gchar * label
    ALIAS:
	Gtk2::RadioButton::new_with_mnemonic = 1
	Gtk2::RadioButton::new_with_label = 2
    PREINIT:
	GSList         * group = NULL;
	GtkRadioButton * member = NULL;
    CODE:
	UNUSED(class);
	if( member_or_listref && member_or_listref != &PL_sv_undef
	    && SvROK (member_or_listref)
	    && SvRV (member_or_listref) != &PL_sv_undef )
	{
		if( SvTYPE(SvRV(member_or_listref)) == SVt_PVAV )
		{
			AV * av = (AV*)SvRV(member_or_listref);
			SV ** svp = av_fetch(av, 0, 0);
			if( svp && SvOK(*svp) )
				member = SvGtkRadioButton(*svp);
		}
		else
			member = SvGtkRadioButton_ornull(member_or_listref);
		if( member )
			group = member->group;
	}

	if (label) {
		if (ix == 2)
			RETVAL = gtk_radio_button_new_with_label (group, label);
		else
			RETVAL = gtk_radio_button_new_with_mnemonic (group, label);
	} else
		RETVAL = gtk_radio_button_new (group);
    OUTPUT:
	RETVAL


GtkWidget *
gtk_radio_button_new_from_widget (class, group, label=NULL)
	SV                    * class
	GtkRadioButton_ornull * group
	const gchar           * label
    ALIAS:
	Gtk2::RadioButton::new_with_mnemonic_from_widget = 1
	Gtk2::RadioButton::new_with_label_from_widget = 2
    CODE:
	UNUSED(class);
	if (label) {
		if (ix == 2)
			RETVAL = gtk_radio_button_new_with_label_from_widget (group, label);
		else
			RETVAL = gtk_radio_button_new_with_mnemonic_from_widget (group, label);
	} else
		RETVAL = gtk_radio_button_new_from_widget (group);
    OUTPUT:
	RETVAL

void
gtk_radio_button_set_group (radio_button, member_or_listref)
	GtkRadioButton * radio_button
	SV             * member_or_listref
    PREINIT:
	GSList         * group = NULL;
	GtkRadioButton * member = NULL;
    CODE:
	if( member_or_listref && member_or_listref != &PL_sv_undef )
	{
		if( SvTYPE(SvRV(member_or_listref)) == SVt_PVAV )
		{
			AV * av = (AV*)SvRV(member_or_listref);
			SV ** svp = av_fetch(av, 0, 0);
			if( SvOK(*svp) )
			{
				member = SvGtkRadioButton(*svp);
			}
		}
		else
			member = SvGtkRadioButton_ornull(member_or_listref);
		if( member )
			group = member->group;
	}
	gtk_radio_button_set_group(radio_button, group);

# GSList * gtk_radio_button_get_group (GtkRadioButton *radio_button)
void
gtk_radio_button_get_group (radio_button)
	GtkRadioButton * radio_button
    PREINIT:
	GSList * group;
	GSList * i;
	AV     * av;
    PPCODE:
	group = radio_button->group;
	av = newAV();
	for( i = group; i ; i = i->next )
	{
		av_push(av, newSVGtkRadioButton(GTK_RADIO_BUTTON(i->data)));
	}
	XPUSHs(newRV_noinc((SV*)av));

