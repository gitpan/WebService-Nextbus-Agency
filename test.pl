use Test::More;
use strict;
use warnings;

BEGIN { plan tests => 3 };
BEGIN { use_ok('WebService::Nextbus::Agency') };

my $agency = new WebService::Nextbus::Agency;
isa_ok($agency, 'WebService::Nextbus::Agency', 'new agency');

can_ok($agency, qw(nameCode routeRegExp dirRegExp routes dirs stops stopCode allStopNames allStopCodes parseRoute parseDir str2stopCodes routesAsString));
