package WebService::Nextbus::Agency::SFMUNI;
use 5.006;
use strict;
use warnings;
use integer;
use Storable;
use base qw(WebService::Nextbus::Agency);

our $VERSION = '0.10';

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;

	my $self = $class->SUPER::new;
	$self->nameCode('sf-muni');
	$self->routeRegExp('([fjklmns]|22)');
	$self->dirRegExp('(fishwarf|castro|downtown|balboa|zoo|caltrain|judah|castro|marina|3rdstreet|[ins])');

	my $fileDir = $INC{'WebService/Nextbus/Agency/SFMUNI.pm'};
	$fileDir =~ s/SFMUNI.pm$//;
	$self->routes(retrieve($fileDir . 'SFMUNI.store'));

	bless ($self, $class);
}

sub parseDir {
	my $self = shift;
	my ($str) = @_;  
	my $dirRegExp = $self->dirRegExp();   
	my ($dir) = ($str =~ /$dirRegExp/i);
 
	$str =~ s/$dir\s*//;

	if ($dir eq 'I') { $dir = 'downtown' }
	if ($dir eq 'N') { $dir = 'marina' }
	if ($dir eq 'S') { $dir = '3rdstreet' }

	return ($dir, $str);
}

1
__END__
=head1 NAME

WebService::Nextbus::Agency::SFMUNI - A helper subclass of WebService::Nextbus::Agency for the sf-muni agency


=head1 SYNOPSIS

	use WebService::Nextbus::Agency::SFMUNI;
	$muniAgency = new WebService::Nextbus::Agency::SFMUNI;
	@stopCodes = $muniAgency->str2stopCodes('N', 'judah', 'Duboce and Fillmore');

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

Peter H. Li<lt>phli@cpan.org<gt>


=head1 COPYRIGHT

Licensed by Creative Commons
http://creativecommons.org/licenses/by-nc-sa/2.0/

=head1 SEE ALSO

L<WebService::Nextbus::Agency>, L<perl>.

=cut
~
