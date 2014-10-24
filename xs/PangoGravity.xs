/*
 * Copyright (c) 2007 by the gtk2-perl team (see the file AUTHORS)
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
 * $Id: PangoGravity.xs 1727 2007-02-25 14:47:57Z tsch $
 */

#include "gtk2perl.h"

MODULE = Gtk2::Pango::Gravity	PACKAGE = Gtk2::Pango::Gravity	PREFIX = pango_gravity_

=for apidoc __function__
=cut
gboolean
is_vertical (PangoGravity gravity)
    CODE:
	RETVAL = PANGO_GRAVITY_IS_VERTICAL (gravity);
    OUTPUT:
	RETVAL

=for apidoc __function__
=cut
double pango_gravity_to_rotation (PangoGravity gravity);

=for apidoc __function__
=cut
PangoGravity pango_gravity_get_for_matrix (const PangoMatrix *matrix);

=for apidoc __function__
=cut
PangoGravity pango_gravity_get_for_script (PangoScript script, PangoGravity base_gravity, PangoGravityHint hint);
