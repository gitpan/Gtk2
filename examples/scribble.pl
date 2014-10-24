#!/usr/bin/perl -w

#
# GTK - The GIMP Toolkit
# Copyright (C) 1995-1997 Peter Mattis, Spencer Kimball and Josh MacDonald
#
# Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the full
# list)
# 
# This library is free software; you can redistribute it and/or modify it under
# the terms of the GNU Library General Public License as published by the Free
# Software Foundation; either version 2.1 of the License, or (at your option)
# any later version.
# 
# This library is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU Library General Public License for
# more details.
# 
# You should have received a copy of the GNU Library General Public License
# along with this library; if not, write to the Free Software Foundation, Inc.,
# 59 Temple Place - Suite 330, Boston, MA  02111-1307  USA.
#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/examples/scribble.pl,v 1.7 2003/09/22 00:04:23 rwmcfa1 Exp $
#

# this was originally gtk-2.2.0/examples/scribble-simple/scribble-simple.c
# ported to gtk2-perl by muppet

use strict;
use Gtk2;

use constant TRUE => 1;
use constant FALSE => 0;

# Backing pixmap for drawing area
#static GdkPixmap *pixmap = NULL;
my $pixmap = undef;

# Create a new backing pixmap of the appropriate size
sub configure_event {
  my $widget = shift; # GtkWidget         *widget
  my $event  = shift; # GdkEventConfigure *event

#  if (pixmap)
#    g_object_unref (pixmap);

  $pixmap = Gtk2::Gdk::Pixmap->new ($widget->window,
                                    $widget->allocation->width,
                                    $widget->allocation->height,
                                    -1);
  $pixmap->draw_rectangle ($widget->style->white_gc,
                           TRUE,
                           0, 0,
                           $widget->allocation->width,
                           $widget->allocation->height);

#  warn "*****************************************************\n";
#  use Devel::Peek;
#  my ($foo, $bar);
#  $foo = $widget->allocation;
#  $bar = \$$foo;
#  Dump ($widget->allocation);
##  die;

  return TRUE;
}

# Redraw the screen from the backing pixmap
sub expose_event {
  my $widget = shift; # GtkWidget      *widget
  my $event  = shift; # GdkEventExpose *event

  $widget->window->draw_drawable (
		     $widget->style->fg_gc($widget->state),
		     $pixmap,
		     $event->area->x, $event->area->y,
		     $event->area->x, $event->area->y,
		     $event->area->width, $event->area->height);

  return FALSE;
}

# Draw a rectangle on the screen
sub draw_brush {
  my $widget = shift; # GtkWidget *widget
  my $x = shift; # gdouble    x
  my $y = shift; # gdouble    y

  # this is not a real GdkRectangle structure; we don't actually need one.
  my @update_rect;
  $update_rect[0] = $x - 5;
  $update_rect[1] = $y - 5;
  $update_rect[2] = 10;
  $update_rect[3] = 10;
  $pixmap->draw_rectangle ($widget->style->black_gc,
                           TRUE, @update_rect);
  
  $widget->queue_draw_area (@update_rect);
}

sub button_press_event {
  my $widget = shift;	# GtkWidget      *widget
  my $event = shift;	# GdkEventButton *event

  if ($event->button == 1 && defined $pixmap) {
    draw_brush ($widget, $event->coords);
  }
  return TRUE;
}

sub motion_notify_event {
  my $widget = shift; # GtkWidget *widget
  my $event  = shift; # GdkEventMotion *event

  my ($x, $y, $state);

  if ($event->is_hint) {
    (undef, $x, $y, $state) = $event->window->get_pointer;
  } else {
    $x = $event->x;
    $y = $event->y;
    $state = $event->state;
  }

  #use Data::Dumper;
  #print Data::Dumper->Dump ([$x, $y, $state], [qw/x y state/]);

#  if (state & GDK_BUTTON1_MASK && pixmap != NULL)
  if (grep (/button1-mask/, @$state) && defined $pixmap) {
    draw_brush ($widget, $x, $y);
  }
  
  return TRUE;
}

{
  Gtk2->init;

  my $window = Gtk2::Window->new ('toplevel');
  $window->set_name ("Test Input");

  my $vbox = Gtk2::VBox->new (FALSE, 0);
  $window->add ($vbox);
  $vbox->show;

  $window->signal_connect ("destroy", sub { exit(0); });

  # Create the drawing area

  my $drawing_area = Gtk2::DrawingArea->new;
  $drawing_area->set_size_request (200, 200);
#  $drawing_area->size (200, 200);
  $vbox->pack_start ($drawing_area, TRUE, TRUE, 0);

  $drawing_area->show;

  # Signals used to handle backing pixmap

  $drawing_area->signal_connect (expose_event => \&expose_event, undef);
  $drawing_area->signal_connect (configure_event => \&configure_event, undef);

  # Event signals

  $drawing_area->signal_connect (motion_notify_event => \&motion_notify_event, undef);
  $drawing_area->signal_connect (button_press_event => \&button_press_event, undef);

  $drawing_area->set_events ([qw/GDK_EXPOSURE_MASK
			         GDK_LEAVE_NOTIFY_MASK
			         GDK_BUTTON_PRESS_MASK
			         GDK_POINTER_MOTION_MASK
			         GDK_POINTER_MOTION_HINT_MASK/]);

  # .. And a quit button
  my $button = Gtk2::Button->new ("Quit");
  $vbox->pack_start ($button, FALSE, FALSE, 0);

  $button->signal_connect_swapped (clicked => sub { $_[0]->destroy; }, $window);
  $button->show;

  $window->show;

  Gtk2->main;
}

