#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 61;

# $Id$

my $entry = Gtk2::Entry -> new();
isa_ok($entry, "Gtk2::Entry");
ginterfaces_ok($entry);

$entry -> set_text("Bla");
is($entry -> get_text(), "Bla");

$entry -> set_visibility(1);
is($entry -> get_visibility(), 1);

$entry -> set_invisible_char("!");
is($entry -> get_invisible_char(), "!");

$entry -> set_max_length(8);
is($entry -> get_max_length(), 8);

$entry -> set_activates_default(1);
is($entry -> get_activates_default(), 1);

$entry -> set_has_frame(1);
is($entry -> get_has_frame(), 1);

$entry -> set_width_chars(23);
is($entry -> get_width_chars(), 23);

isa_ok($entry -> get_layout(), "Gtk2::Pango::Layout");

my ($x, $y) = $entry -> get_layout_offsets();
like($x, qr/^-?\d+$/);
like($y, qr/^-?\d+$/);

SKIP: {
  skip("[sg]et_completion are new in 2.4", 2)
    unless Gtk2->CHECK_VERSION (2, 4, 0);

  my $completion = Gtk2::EntryCompletion -> new();

  $entry -> set_completion($completion);
  is($entry -> get_completion(), $completion);

  $entry -> set_completion(undef);
  is($entry -> get_completion(), undef);
}

SKIP: {
  skip("[sg]et_alignment are new in 2.4", 1)
    unless Gtk2->CHECK_VERSION (2, 4, 0);

  $entry -> set_alignment(0.23);
  is(int($entry -> get_alignment() * 100) / 100, 0.23);
}

SKIP: {
  skip("layout_index_to_text_index and text_index_to_layout_index are new in 2.6", 2)
    unless Gtk2->CHECK_VERSION (2, 6, 0);

  is($entry -> layout_index_to_text_index(1), 1);
  is($entry -> text_index_to_layout_index(1), 1);
}

SKIP: {
  skip("inner border stuff", 2)
    unless Gtk2->CHECK_VERSION (2, 10, 0);

  $entry -> set_inner_border(undef);
  is($entry -> get_inner_border(), undef);
  $entry -> set_inner_border({left=>1, right=>2, top=>3, bottom=>4});
  is_deeply($entry -> get_inner_border(), {left=>1, right=>2, top=>3, bottom=>4});
}

SKIP: {
  skip("cursor hadjustment stuff", 2)
    unless Gtk2->CHECK_VERSION (2, 12, 0);

  $entry -> set_cursor_hadjustment(undef);
  is($entry -> get_cursor_hadjustment(), undef);

  my $adj = Gtk2::Adjustment -> new(0.0, -1.0, 1.0, 0.1, 0.2, 0.5);
  $entry -> set_cursor_hadjustment($adj);
  is($entry -> get_cursor_hadjustment(), $adj);
}

SKIP: {
  skip 'new 2.14 stuff', 2
    unless Gtk2->CHECK_VERSION(2, 14, 0);

  my $entry = Gtk2::Entry -> new();
  $entry -> set_text("Bla");

  is ($entry -> get_text_length(), 3);

  $entry -> set_overwrite_mode(FALSE);
  is ($entry -> get_overwrite_mode(), FALSE);
}

SKIP: {
  skip '2.16 stuff', 38
    unless Gtk2->CHECK_VERSION(2, 16, 0);

  ## progress methods

  my $entry = Gtk2::Entry -> new();
  is($entry -> get_icon_at_pos(0, 0), -1);

  delta_ok($entry -> get_progress_fraction(), 0.0);
  delta_ok($entry -> get_progress_pulse_step(), 0.1);

  $entry -> progress_pulse(); # We can't see the changes :(

  $entry -> set_progress_fraction(0.3);
  delta_ok($entry -> get_progress_fraction(), 0.3);

  $entry -> set_progress_pulse_step(0.2);

  ## unset_invisible_char

  # Try the new password methods
  my $password = Gtk2::Entry -> new();
  $password -> set_visibility(FALSE);


  # Change the default character
  my $default = $password -> get_invisible_char();
  my $char = $default eq 'X' ? '?' : 'X';
  $password -> set_invisible_char($char);
  is($password -> get_invisible_char(), $char);

  # Restore the default character
  $password -> unset_invisible_char();
  is($password -> get_invisible_char(), $default);

  ## icon methods

  test_icon_methods('primary');
  test_icon_methods('secondary');
}


sub test_icon_methods {
  my ($icon_pos) = @_;

  my $entry = Gtk2::Entry -> new();

  is($entry -> get_icon_name($icon_pos), undef);
  is($entry -> get_icon_pixbuf($icon_pos), undef);
  is($entry -> get_icon_stock($icon_pos), undef);
  is($entry -> get_icon_storage_type($icon_pos), 'empty');

  $entry -> set_icon_sensitive($icon_pos, TRUE);
  is($entry -> get_icon_sensitive($icon_pos), TRUE);

  $entry -> set_icon_activatable($icon_pos, TRUE);
  is($entry -> get_icon_activatable($icon_pos), TRUE);



  # Is an 'icon name' the same as a 'stock icon'?
  is($entry -> get_icon_name($icon_pos), undef);
  $entry -> set_icon_from_icon_name($icon_pos, 'gtk-yes');
  is($entry -> get_icon_name($icon_pos), 'gtk-yes');
  ok($entry -> get_icon_pixbuf($icon_pos));

  # Reset through icon_name
  $entry -> set_icon_from_icon_name($icon_pos, undef);
  is($entry -> get_icon_pixbuf($icon_pos), undef);



  # Set and unset the icon through a stock image
  $entry -> set_icon_from_stock($icon_pos, 'gtk-yes');
  ok($entry -> get_icon_pixbuf($icon_pos));
  $entry -> set_icon_from_stock($icon_pos, undef);
  is($entry -> get_icon_pixbuf($icon_pos), undef);

  # Reset
  $entry -> set_icon_from_stock($icon_pos, undef);
  is($entry -> get_icon_name($icon_pos), undef);
  is($entry -> get_icon_pixbuf($icon_pos), undef);



  # Set and unset the icon through a pixbuf
  my $pixbuf = Gtk2::Gdk::Pixbuf->new('rgb', TRUE, 8, 16, 16);
  $entry -> set_icon_from_pixbuf($icon_pos, $pixbuf);
  is($entry -> get_icon_pixbuf($icon_pos), $pixbuf);
  $entry -> set_icon_from_pixbuf($icon_pos, undef);
  is($entry -> get_icon_pixbuf($icon_pos), undef);


  # This method can't be tested, at least we call them just in case they crash
  $entry -> set_icon_tooltip_markup($icon_pos, "<b>Pan</b><i>Go</i> tooltip");
  $entry -> set_icon_tooltip_markup($icon_pos, undef);

  $entry -> set_icon_tooltip_text($icon_pos, "Text tooltip");
  $entry -> set_icon_tooltip_text($icon_pos, undef);
}

__END__

Copyright (C) 2003-2006 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
