use Test::More;
use strict;
use warnings;

BEGIN { plan tests => 7 };
BEGIN { use_ok('WebService::Nextbus::Agency::SFMUNI') };

my $muniAgency = new WebService::Nextbus::Agency::SFMUNI;
isa_ok($muniAgency, 'WebService::Nextbus::Agency::SFMUNI', 'new muniAgency');
isa_ok($muniAgency, 'WebService::Nextbus::Agency', 'new muniAgency');

can_ok($muniAgency, qw(nameCode routeRegExp dirRegExp routes dirs stops stopCode allStopNames allStopCodes parseRoute parseDir str2stopCodes routesAsString));

is($muniAgency->nameCode(), 'sf-muni', 'set basic variable correctly');
is($muniAgency->stopCode('N', 'O', 'Duboce Ave Church St Fillmore'), 'DF', 'DF checks out in routes tree');
is(join('', $muniAgency->str2stopCodes('N', 'O', 'Duboce and Fillmore')), 'DF', 'can find stopCode DF (Duboce and Fillmore) using str2stopCodes');
