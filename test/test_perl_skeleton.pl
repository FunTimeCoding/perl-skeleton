use Test::More tests => 4;
use FindBin;
use lib "$FindBin::Bin/../lib";
use perl_skeleton;

is(1, 1, "is() example");
ok(1 eq 1, "ok() example");
isnt(1, 2, "isnt() example");
is(main(), 0, "main() return value");
