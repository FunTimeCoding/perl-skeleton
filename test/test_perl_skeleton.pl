use strict;
use warnings;
use Test::More tests => 4;
use lib 'module';
use perl_skeleton::perl_skeleton;

is(1, 1, "is() example");
ok(1 eq 1, "ok() example");
isnt(1, 2, "isnt() example");
is(perl_skeleton::perl_skeleton::main(), 0, "main() return value");
