package WebService::Nextbus::Agency::SFMUNI;
use 5.006;
use strict;
use warnings;
use base qw(WebService::Nextbus::Agency);

our $VERSION = '0.02';

my (%_iJStops, %_oJStops, %_iKStops, %_oKStops, %_iLStops, %_oLStops, %_iMStops, %_oMStops, %_iNStops, %_oNStops, %_iSStops, %_oSStops, %_n22Stops, %_s22Stops);

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;

	my $self = $class->SUPER::new;
	$self->nameCode('sf-muni');
	$self->routeRegExp('([jklmns]|22)');
	$self->dirRegExp('(north|south|[ions])');

	$self->stops('J',  'I', 	\%_iJStops);
	$self->stops('J',  'O', 	\%_oJStops);
	$self->stops('K',  'I', 	\%_iKStops);
	$self->stops('K',  'O', 	\%_oKStops);
	$self->stops('L',  'I', 	\%_iLStops);
	$self->stops('L',  'O', 	\%_oLStops);
	$self->stops('M',  'I', 	\%_iMStops);
	$self->stops('M',  'O', 	\%_oMStops);
	$self->stops('N',  'I', 	\%_iNStops);
	$self->stops('N',  'O', 	\%_oNStops);
	$self->stops('S',  'I', 	\%_iSStops);
	$self->stops('S',  'O', 	\%_oSStops);
	$self->stops('22', 'North', 	\%_n22Stops);
	$self->stops('22', 'South', 	\%_s22Stops);

	bless ($self, $class);
}

sub parseDir {
      my $self = shift;
      my ($str) = @_;  
      my $dirRegExp = $self->dirRegExp();   
      my ($dir) = ($str =~ /$dirRegExp/i);
 
      $str =~ s/$dir\s*//;

      $dir = ucfirst($dir);
	if ($dir eq 'N') { $dir = 'North' }
	if ($dir eq 'S') { $dir = 'South' }

	return ($dir, $str);
}

%_iJStops = (
	'San Jose Ave Geneva Ave' => 'S_J_GNVA',
	'San Jose Ave Ocean Ave' => 'SJO',
	'San Jose Ave Santa Ynez Ave' => 'S_J_SYNZ',
	'San Jose Ave Santa Rosa Ave' => 'SJSR',
	'Glen Park Station' => 'GLPKSTA_',
	'San Jose Ave Randolph St' => 'S_J_RAND',
	'30th St Dolores St' => '30Dol',
	'Church St 30th St' => '30STCHUR',
	'Church St 29th St' => 'CHUR29ST',
	'Church St 27th St' => 'C27',
	'Church St Clipper St' => 'CClp',
	'Church St 24th St' => 'C24',
	'Church St 22nd St' => 'CHUR22ST',
	'Right Of Way 21st St' => 'ROW_21ST',
	'Right Of Way Liberty St' => 'ROW_LBRT',
	'Right Of Way 20th St' => 'ROW_20ST',
	'Right Of Way 18th St' => 'ROW_18ST',
	'Church St 16th St' => 'C16',
	'Church St Market St' => 'CMar',
	'Church St Duboce Ave' => 'CDub',
	'Tunnel Entry Point near Church & Duboce' => 'D_4_LVG_',
	'Van Ness Station' => 'VN',
	'Civic Center Station' => 'CvC',
	'Powell Station' => 'Pow',
	'Montgomery Station' => 'Mntg',
	'Embarcadero Station' => 'EMB',
);

%_oJStops = (
	'Embarcadero Station' => 'EMB',
	'Montgomery Station' => 'Mntg',
	'Powell Station' => 'Pow',
	'Civic Center Station' => 'CvC',
	'Van Ness Station' => 'VN',
	'Church St 14th St' => 'C14',
	'Church St 16th St' => 'C16',
	'Church St 18th St' => 'C18',
	'Right Of Way 20th St' => 'ROW_20ST',
	'Right Of Way Liberty St' => 'ROW_LBRT',
	'Right Of Way 21st St' => 'ROW_21ST',
	'Right Of Way 22nd St' => 'ROW_22ST',
	'Church St 24th St' => 'C24',
	'Church St Clipper St' => 'CClp',
	'Church St 27th St' => 'C27',
	'Church St Day St' => 'CDay',
	'30th St Dolores St' => '30Dol',
	'San Jose Ave Randolph St' => 'S_J_RAND',
	'Glen Park Station' => 'GLPKSTA_',
	'San Jose Ave Santa Rosa Ave' => 'SJSR',
	'San Jose Ave Santa Ynez Ave' => 'S_J_SYNZ',
	'San Jose Ave Ocean Ave' => 'SJO',
	'San Jose Ave Geneva Ave' => 'S_J_GNVA',
);

%_iKStops = (
	'Ocean Ave - CCSF Pedestrian Bridge' => 'OP',
	'Ocean Ave Lee St' => 'OL',
	'Ocean Ave Miramar Ave' => 'OM',
	'Ocean Ave Dorado Ter' => 'OCENDRDO',
	'Ocean Ave Fairfield Way' => 'OCENFFLD',
	'Ocean Ave Westgate Dr' => 'OWG',
	'Ocean Ave Aptos Ave' => 'OA',
	'Ocean Ave San Leandro Way' => 'OSL',
	'Junipero Serra Blvd Ocean Ave' => 'JSO',
	'West Portal Ave Sloat Blvd - St Francis Circle' => 'SF',
	'West Portal Ave 14th Ave' => 'WP14',
	'West Portal Ave Ulloa St' => 'W_P_ULOA',
	'West Portal Station' => 'MTROW_P_',
	'West Portal Station' => 'WP',
	'Forest Hill Station' => 'FH',
	'Castro Station' => 'Cstr',
	'Church St Station' => 'Chr',
	'Van Ness Station' => 'VN',
	'Civic Center Station' => 'CvC',
	'Powell Station' => 'Pow',
	'Montgomery Station' => 'Mntg',
	'Embarcadero Station' => 'EMB',
);

%_oKStops = (
	'Embarcadero Station' => 'EMB',
	'Montgomery Station' => 'Mntg',
	'Powell Station' => 'Pow',
	'Civic Center Station' => 'CvC',
	'Van Ness Station' => 'VN',
	'Church St Station' => 'Chr',
	'Castro Station' => 'Cstr',
	'Forest Hill Station' => 'FH',
	'West Portal Station' => 'WP',
	'West Portal Ave 14th Ave' => 'WP14',
	'West Portal Ave Sloat Blvd - St Francis Circle' => 'SF',
	'Junipero Serra Blvd Ocean Ave' => 'JSO',
	'Ocean Ave San Leandro Way' => 'OSL',
	'Ocean Ave Aptos Ave' => 'OA',
	'Ocean Ave Cerritos Ave' => 'OCENCERT',
	'Ocean Ave Victoria St' => 'OV',
	'Ocean Ave Jules Ave' => 'OJ',
	'Ocean Ave Miramar Ave' => 'OM',
	'Ocean Ave Lee St' => 'OL',
	'Ocean Ave - CCSF Pedestrian Bridge' => 'OP',
	'Ocean Ave San Jose St' => 'OCENS_J_',
	'Geneva Terminal' => 'BP',
);

%_iLStops = (
	'Wawona St 46th Ave' => 'W46',
	'46th Ave Vicente St' => '46V',
	'46th Ave Ulloa St' => '46U',
	'46th Ave Taraval St' => '46T',
	'Taraval St 46th Ave' => 'T46',
	'Taraval St 44th Ave' => 'T44',
	'Taraval St 42nd Ave' => 'T42',
	'Taraval St 40th Ave' => 'T40',
	'Taraval St Sunset Blvd' => 'T36',
	'Taraval St 35th Ave' => 'T35',
	'Taraval St 32nd Ave' => 'T32',
	'Taraval St 30th Ave' => 'T30',
	'Taraval St 28th Ave' => 'T28',
	'Taraval St 26th Ave' => 'T26',
	'Taraval St 24th Ave' => 'T24',
	'Taraval St 22nd Ave' => 'T22',
	'Taraval St 19th Ave' => 'T19',
	'Taraval St 17th Ave' => 'T17',
	'15th Ave Taraval St' => '15T',
	'15th Ave Ulloa St' => '15U',
	'Ulloa St Forest Side Ave' => 'UF',
	'West Portal Station' => 'WP',
	'Forest Hill Station' => 'FH',
	'Castro Station' => 'Cstr',
	'Church St Station' => 'Chr',
	'Van Ness Station' => 'VN',
	'Civic Center Station' => 'CvC',
	'Powell Station' => 'Pow',
	'Montgomery Station' => 'Mntg',
	'Embarcadero Station' => 'EMB',
);

%_oLStops = (
	'Embarcadero Station' => 'EMB',
	'Montgomery Station' => 'Mntg',
	'Powell Station' => 'Pow',
	'Civic Center Station' => 'CvC',
	'Van Ness Station' => 'VN',
	'Church St Station' => 'Chr',
	'Castro Station' => 'Cstr',
	'Forest Hill Station' => 'FH',
	'West Portal Station' => 'WP',
	'Ulloa St Forest Side Ave' => 'UF',
	'15th Ave Ulloa St' => '15U',
	'15th Ave Taraval St' => '15T',
	'Taraval St 17th Ave' => 'T17',
	'Taraval St 19th Ave' => 'T19',
	'Taraval St 22nd Ave' => 'T22',
	'Taraval St 23rd Ave' => 'T23',
	'Taraval St 26th Ave' => 'T26',
	'Taraval St 28th Ave' => 'T28',
	'Taraval St 30th Ave' => 'T30',
	'Taraval St 32nd Ave' => 'T32',
	'Taraval St 35th Ave' => 'T35',
	'Taraval St Sunset Blvd' => 'T36',
	'Taraval St 40th Ave' => 'T40',
	'Taraval St 42nd Ave' => 'T42',
	'Taraval St 44th Ave' => 'T44',
	'Taraval St 46th Ave' => 'T46',
	'46th Ave Ulloa St' => '46U',
	'46th Ave Vicente St' => '46V',
	'Wawona St 46th Ave' => 'W46',
);

%_iMStops = (
	'San Jose Ave Mt Vernon Ave' => 'S_J_MTVN',
	'San Jose Ave Lakeview Ave' => 'SJL',
	'San Jose Ave Farallones St' => 'S_J_FARA',
	'Broad St Plymouth Ave' => 'BPl',
	'Broad St Capitol Ave' => 'BC',
	'Broad St Orizaba Ave' => 'BO',
	'Randolph St Bright St' => 'RB',
	'Randolph St Arch St' => 'RA',
	'19th Ave Randolph St' => '19AVRAND',
	'19th Ave Junipero Serra Blvd' => '19J',
	'19th Ave Holloway Ave' => '19H',
	'19th Ave Winston Dr' => '19W',
	'Right Of Way Eucalyptus Dr' => 'ROW_EUCA',
	'Right Of Way Ocean Ave' => 'LO',
	'Right Of Way Sloat Blvd' => 'ROW_SLOA',
	'West Portal Ave Sloat Blvd - St Francis Circle' => 'SF',
	'West Portal Ave 14th Ave' => 'WP14',
	'West Portal Ave Ulloa St' => 'W_P_ULOA',
	'West Portal Station' => 'WP',
	'Forest Hill Station' => 'FH',
	'Castro Station' => 'Cstr',
	'Church St Station' => 'Chr',
	'Van Ness Station' => 'VN',
	'Civic Center Station' => 'CvC',
	'Powell Station' => 'Pow',
	'Montgomery Station' => 'Mntg',
	'Embarcadero Station' => 'EMB',
);

%_oMStops = (
	'Embarcadero Station' => 'EMB',
	'Montgomery Station' => 'Mntg',
	'Powell Station' => 'Pow',
	'Civic Center Station' => 'CvC',
	'Van Ness Station' => 'VN',
	'Church St Station' => 'Chr',
	'Castro Station' => 'Cstr',
	'Forest Hill Station' => 'FH',
	'West Portal Station' => 'WP',
	'West Portal Ave 14th Ave' => 'WP14',
	'West Portal Ave Sloat Blvd - St Francis Circle' => 'SF',
	'Right Of Way Sloat Blvd' => 'ROW_SLOA',
	'Right Of Way Ocean Ave' => 'LO',
	'Right Of Way Eucalyptus Dr' => 'ROW_EUCA',
	'19th Ave Winston Dr' => '19W',
	'19th Ave Holloway Ave' => '19H',
	'19th Ave Junipero Serra Blvd' => '19J',
	'19th Ave N Randolph St' => '19AVNRAN',
	'19th Ave Randolph St' => '19AVRAND',
	'Randolph St Byxbee St' => 'RANDBXBE',
	'Randolph St Arch St' => 'RA',
	'Randolph St Bright St' => 'RB',
	'Orizaba Ave Broad St' => 'ORIZBROD',
	'Broad St Capitol Ave' => 'BC',
	'Broad St Plymouth Ave' => 'BPl',
	'San Jose Ave Farallones St' => 'S_J_FARA',
	'San Jose Ave Lakeview Ave' => 'SJL',
	'San Jose Ave Mt Vernon Ave' => 'S_J_MTVN',
	'San Jose Ave Niagra Ave' => 'SJN',
);

%_iNStops = (
	'Judah St La Playa St' => 'JL',
	'Judah St 48th Ave' => 'J48',
	'Judah St 46th Ave' => 'J46',
	'Judah St 43rd Ave' => 'J43',
	'Judah St 40th Ave' => 'J40',
	'Judah St Sunset Blvd' => 'JSun',
	'Judah St 34th Ave' => 'J34',
	'Judah St 31st Ave' => 'J31',
	'Judah St 28th Ave' => 'J28',
	'Judah St 25th Ave' => 'J25',
	'Judah St 22nd Ave' => 'J22',
	'Judah St 19th Ave' => 'J19',
	'Judah St 15th Ave' => 'J15',
	'Judah St Funston Ave' => 'JF',
	'Judah St 12th Ave' => 'J12',
	'Judah St 9th Ave' => 'J9',
	'9th Ave Irving St' => '09AVIRVG',
	'Irving St 7th Ave' => 'I7',
	'Irving St 4th Ave' => 'I4',
	'Irving St Arguello Blvd UCSF' => 'IA',
	'Carl St Hillway Ave' => 'CaH',
	'Carl St Willard St' => 'CaW',
	'Carl St Stanyan St' => 'CaS',
	'Carl St Cole St' => 'CaC',
	'Duboce Ave Noe St Sunset Tunnel East Portal Park' => 'DN',
	'Duboce Ave Church St Fillmore' => 'DF',
	'Van Ness Station' => 'VN',
	'Civic Center Station' => 'CvC',
	'Powell Station' => 'Pow',
	'Montgomery Station' => 'Mntg',
	'Embarcadero Station' => 'EMB',
	'Embarcadero Folsom St' => 'FSt',
	'Embarcadero Brannan St' => 'BSt',
	'King St 2nd St' => '2K',
	'King St 4th St' => 'CTr',
);

%_oNStops = (
	'King St 4th St' => 'CTr',
	'King St 2nd St' => '2K',
	'Embarcadero Brannan St' => 'BSt',
	'Embarcadero Folsom St' => 'FSt',
	'Embarcadero Station' => 'EMB',
	'Montgomery Station' => 'Mntg',
	'Powell Station' => 'Pow',
	'Civic Center Station' => 'CvC',
	'Van Ness Station' => 'VN',
	'Duboce Ave Church St Fillmore' => 'DF',
	'Duboce Ave Noe St Sunset Tunnel east Portal Park' => 'DN',
	'Carl St Cole St' => 'CaC',
	'Carl St Stanyan St' => 'CaS',
	'Carl St Willard St' => 'CaW',
	'Carl St Hillway Ave' => 'CaH',
	'Irving St 2nd Ave UCSF' => 'IRVG02AV',
	'Irving St 4th Ave' => 'I4',
	'Irving St 7th Ave' => 'I7',
	'Irving St 9th Ave' => 'I9',
	'Judah St 9th Ave' => 'J9',
	'Judah St 12th Ave' => 'J12',
	'Judah St Funston Ave' => 'JF',
	'Judah St 16th Ave' => 'J16',
	'Judah St 19th Ave' => 'J19',
	'Judah St 23rd Ave' => 'J23',
	'Judah St 25th Ave' => 'J25',
	'Judah St 28th Ave' => 'J28',
	'Judah St 31st Ave' => 'J31',
	'Judah St 34th Ave' => 'J34',
	'Judah St Sunset Blvd' => 'JSun',
	'Judah St 40th Ave' => 'J40',
	'Judah St 43rd Ave' => 'J43',
	'Judah St 46th Ave' => 'J46',
	'Judah St 48th Ave' => 'J48',
	'Judah St La Playa St' => 'JL',
);

%_iSStops = (
	'Castro Station' => 'Cstr',
	'Church St Station' => 'Chr',
	'Van Ness Station' => 'VN',
	'Civic Center Station' => 'CvC',
	'Powell Station' => 'Pow',
	'Montgomery Station' => 'Mntg',
	'Embarcadero Station' => 'EMB',
);

%_oSStops = (
	'Embarcadero Station' => 'EMB',
	'Montgomery Station' => 'Mntg',
	'Powell Station' => 'Pow',
	'Civic Center Station' => 'CvC',
	'Van Ness Station' => 'VN',
	'Church St Station' => 'Chr',
);

%_s22Stops = (
	'Fillmore St Beach St' => 'FILLBECH',
	'Fillmore St Chestnut St' => 'FlChe',
	'Fillmore St Lombard St' => 'FlLom',
	'Union St Fillmore St' => 'UNINFILL',
	'Steiner St Union St' => 'STEIUNIN',
	'Steiner St Green St' => 'STEIGREN',
	'Steiner St Vallejo St' => 'STEIVALL',
	'Broadway Steiner St' => 'BDWYSTEI',
	'Fillmore St Broadway' => 'FILLBDWY',
	'Fillmore St Jackson St' => 'FlJac',
	'Fillmore St Sacramento St' => 'FlSac',
	'Fillmore St Pine St' => 'FILLPINE',
	'Fillmore St Sutter St' => 'FlSut',
	'Fillmore St Geary Blvd' => 'FlGea',
	'Fillmore St O\'Farrell St' => 'FlOfa',
	'Fillmore St Eddy St' => 'FILLEDDY',
	'Fillmore St Turk St' => 'FlTur',
	'Fillmore St McAllister St' => 'FlMcl',
	'Fillmore St Grove St' => 'FILLGROV',
	'Fillmore St Hayes St' => 'FlHay',
	'Fillmore St Oak St' => 'FlOak',
	'Fillmore St Haight St' => 'FlHgt',
	'Hermann St Fillmore St' => 'HERMFILL',
	'Church St Duboce Ave' => 'CDub',
	'Church St Market St' => 'CMar',
	'Church St 16th St' => 'C16',
	'16th St Dolores St' => '16Dol',
	'16th St Guerrero St' => '16STGUER',
	'16th St Valencia St' => '16Val',
	'16th St Mission St' => '16Mis',
	'16th St Shotwell St' => '16Sho',
	'16th St Harrison St' => '16Har',
	'16th St Bryant St' => '16Bry',
	'16th St Potrero Ave' => '16Pot',
	'16th St Kansas St' => '16STKANS',
	'Kansas St 17th St' => 'KANS17ST',
	'17th St De Haro St' => '17STDHRO',
	'17th St Wisconsin St' => '17STWISC',
	'Connecticut St 17th St' => 'CONN17ST',
	'Connecticut St 18th St' => 'CONN18ST',
	'18th St Texas St' => '18STTEXS',
	'18th St Pennsylvania Ave' => '18STPENN',
	'18th St Minnesota St' => '18STMINN',
	'18th St 3rd St' => '18ST03ST',
	'20th St 3rd St' => '20ST03ST',
);

%_n22Stops = (
	'20th St 3rd St' => '20ST03ST',
	'18th St Pennsylvania Ave' => '18STPENN',
	'18th St Texas St' => '18STTEXS',
	'Connecticut St 17th St' => 'CONN17ST',
	'17th St Wisconsin St' => '17STWISC',
	'17th St De Haro St' => '17STDHRO',
	'16th St Potrero Ave' => '16Pot',
	'16th St Bryant St' => '16Bry',
	'16th St Harrison St' => '16Har',
	'16th St Shotwell St' => '16Sho',
	'16th St Mission St' => '16Mis',
	'16th St Valencia St' => '16Val',
	'16th St Guerrero St' => '16STGUER',
	'16th St Dolores St' => '16Dol',
	'Church St Market St' => 'CMar',
	'Church St Duboce Ave' => 'CDub',
	'Hermann St Fillmore St' => 'HERMFILL',
	'Fillmore St Haight St' => 'FlHgt',
	'Fillmore St Oak St' => 'FlOak',
	'Fillmore St Hayes St' => 'FlHay',
	'Fillmore St Grove St' => 'FILLGROV',
	'Fillmore St McAllister St' => 'FlMcl',
	'Fillmore St Golden Gate Ave' => 'FlGol',
	'Fillmore St Eddy St' => 'FILLEDDY',
	'Fillmore St O\'Farrell St' => 'FlOfa',
	'Fillmore St Geary Blvd' => 'FlGea',
	'Fillmore St Sutter St' => 'FlSut',
	'Fillmore St Pine St' => 'FILLPINE',
	'Fillmore St Sacramento St' => 'FlSac',
	'Fillmore St Jackson St' => 'FlJac',
	'Fillmore St Broadway' => 'FILLBDWY',
	'Broadway Steiner St' => 'BDWYSTEI',
	'Steiner St Vallejo St' => 'STEIVALL',
	'Steiner St Green St' => 'STEIGREN',
	'Steiner St Union St' => 'STEIUNIN',
	'Fillmore St Lombard St' => 'FlLom',
	'Fillmore St Chestnut St' => 'FlChe',
	'Fillmore St Bay St' => 'FILLBAY_',
	'Fillmore St North Point St' => 'FILLN_PT',
	'Fillmore St Beach St' => 'FILLBECH',
);

1

__END__
=head1 NAME

WebService::Nextbus::Agency::SFMUNI - A helper subclass of WebService::Nextbus::Agency for the sf-muni agency


=head1 SYNOPSIS

	use WebService::Nextbus::Agency::SFMUNI;
	$muniAgency = new WebService::Nextbus::Agency::SFMUNI;
	@stopCodes = $muniAgency->str2stopCodes('N', 'O', 'Duboce and Fillmore');

C<$stopCodes> can now be used as valid GET arguments on the nextbus webpage.


=head1 DESCRIPTION

Objects of the SFMUNI class are WebService::Nextbus::Agency inheritors and 
already know much of the data about sf-muni, e.g. available routes, stops, etc..

WebService::Nextbus::Agency is conceived as a class of object used by 
WebService::Nextbus to store and intelligently recall the information that 
WebService::Nextbus will download from the Nextbus website.  It class can also 
be used by initializing inheriting helper classes that will automatically load 
up the data relevant for the given agency.

However, the WebService::Nextbus package is not released yet, so the 
functionality of WebService::Nextbus::Agency is currently limited to the second 
method.  Further, the only helper inheriting class I've written thus far is the 
class for the San Francisco MUNI agency (sf-muni).  This subclass is available 
as L<WebService::Nextbus::Agency::SFMUNI>.

The L</SYNOPSIS> indicates how the object can be used to retrieve the GET
argument that the website requires for returning GPS information for a 
particular stop on a particular route of the sf-muni agency.  Once the proper
GET code has been retrieved, a web useragent can use the argument to build
a URL for the desired information.  This is another function that will 
eventually be provided by WebService::Nextbus by making WebService::Nextbus an 
LWP::UserAgent.


=head2 EXPORT

None by default.


=head1 ERROR CHECKING
Watch out!  No error checking yet...

=head1 REQUIRES

L<WebService::Nextbus::Agency>

=head1 AUTHOR

Peter H. Li<lt>pli9+CODE@spam-guard.itsa.ucsf.edu<gt>


=head1 COPYRIGHT

Licensed by Creative Commons
http://creativecommons.org/licenses/by-nc-sa/1.0/

=head1 SEE ALSO

L<WebService::Nextbus::Agency>, L<perl>.

=cut
~
