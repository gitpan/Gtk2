#!/usr/bin/perl -w
use strict;
use Gtk2::TestHelper tests => 13;

# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/Gtk2/t/GtkAccelGroup.t,v 1.10 2005/02/26 16:28:24 kaffeetisch Exp $

use Gtk2::Gdk::Keysyms;

my $group = Gtk2::AccelGroup -> new();
isa_ok($group, "Gtk2::AccelGroup");

my $window = Gtk2::Window -> new();
$window -> add_accel_group($group);

my $key = $Gtk2::Gdk::Keysyms{ KP_Enter };
my $mask = qw(shift-mask);

my $closure = sub {
  TODO: {
    local $TODO = "Currently fails due to a Test::More bug";
    is_deeply(\@_, [$group,
                    $window,
                    $key,
                    $mask]);
  }
};

$group -> connect($key, $mask, qw(visible), $closure);
$group -> connect_by_path("<gtk2-perl-tests>/Bla/Blub", $closure);

$group -> lock();
$group -> unlock();

like(Gtk2::AccelGroups -> activate($window, $key, $mask), qr/^(?:|1)$/);
is(Gtk2::AccelGroups -> from_object($window), $group);

is(Gtk2::Accelerator -> valid($key, $mask), 1);
TODO: {
  local $TODO = "Currently fails due to a Test::More bug";
  is_deeply([Gtk2::Accelerator -> parse("<Shift>KP_Enter")], [$key, $mask]);
}
is(Gtk2::Accelerator -> name($key, $mask), "<Shift>KP_Enter");

Gtk2::Accelerator -> set_default_mod_mask([qw(shift-mask control-mask mod1-mask mod2-mask lock-mask)]);
ok(Gtk2::Accelerator -> get_default_mod_mask() == [qw(shift-mask control-mask mod1-mask mod2-mask lock-mask)]);

is($group -> disconnect_key($key, $mask), 1);

SKIP: {
  skip 'disconnect_key from empty group, bug in gtk+', 1
    unless Gtk2->CHECK_VERSION (2, 4, 0);

  ok (not ($group->disconnect_key (42, qw/shift-mask/)),
      'second disconnect_key shift-mask should fail');
}

SKIP: {
  skip 'get_label is new in 2.6', 1
    unless Gtk2->CHECK_VERSION (2, 6, 0);

  is(Gtk2::Accelerator -> get_label($key, $mask), 'Shift+KP Enter');
}

is($group -> disconnect($closure), 1);
ok(not $group -> disconnect($closure));

__END__

Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS for the
full list).  See LICENSE for more information.
