package WebService::Nextbus::Agency;
use 5.006;
use strict;
use warnings;
     
our $VERSION = '0.02';

sub new {
	my $proto = shift;
	my $class = ref($proto) || $proto;

	my $self = {
		_nameCode		=> undef,
		_routeRegExp	=> undef,
		_dirRegExp		=> undef,
		_routes		=> {},
	};
	bless ($self, $class);
}

sub nameCode {
	my $self = shift;
	if (@_) { $self->{_nameCode} = shift }
	return $self->{_nameCode};
}

sub routeRegExp {
	my $self = shift;
	if (@_) { $self->{_routeRegExp} = shift }
	return $self->{_routeRegExp};
}

sub dirRegExp {
	my $self = shift;
	if (@_) { $self->{_dirRegExp} = shift }
	return $self->{_dirRegExp};
}

sub routes {
	my $self = shift;
	if (@_) { %{$self->{_routes}} = %{$_[0]} }
	return \%{$self->{_routes}};
}

sub dirs {
	my $self = shift;
	my ($route, $newDirs) = @_;
	if ($newDirs) { %{$self->routes()->{$route}} = %$newDirs }
	return \%{$self->routes()->{$route}};
}

sub stops {
	my $self = shift;
	my ($route, $dir, $newStops) = @_;
	if ($newStops) { %{$self->dirs($route)->{$dir}} = %$newStops }
	return \%{$self->dirs($route)->{$dir}};
}

sub stopCode {
	my $self = shift;
	my ($route, $dir, $stopName, $newCode) = @_;
	if ($newCode) { $self->stops($route, $dir)->{$stopName} = $newCode }
	return $self->stops($route, $dir)->{$stopName};
}

sub allStopNames {
	my $self = shift;
	my ($route, $dir) = @_;
	return keys(%{$self->stops($route, $dir)});
}

sub allStopCodes {
	my $self = shift;
	my ($route, $dir) = @_;
	return values(%{$self->stops($route, $dir)});
}

sub parseRoute {
	my $self = shift;
	my ($str) = @_;
      my $routeRegExp = $self->routeRegExp();
      my ($route) = ($str =~ /$routeRegExp/i);

	$str =~ s/$route\s*//;
	return (ucfirst($route), $str);
}
      
sub parseDir {
      my $self = shift;                        
      my ($str) = @_;                   
      my $dirRegExp = $self->dirRegExp();
      my ($dir) = ($str =~ /$dirRegExp/i);

	$str =~ s/$dir\s*//;
      return (ucfirst($dir), $str);
}

sub str2stopCodes {
	my $self = shift;
	my ($route, $dir, $stopStr) = @_;

	my @stopCodes = $self->allStopCodes($route, $dir);
	if ((my @retCodes = grep(/$stopStr/i, @stopCodes)) == 1) {
		return @retCodes;
	}

	my @stopNames = $self->allStopNames($route, $dir);
	foreach my $word (split(/\s+/, $stopStr)) {
		if (my @temp = grep(/$word/i, @stopNames)) {
			@stopNames = @temp;
		}
	}

	my @retCodes;
	foreach my $stopName (@stopNames) {
		my $retCode = $self->stopCode($route, $dir, $stopName);
		push(@retCodes, $retCode);
	}
	return @retCodes;
}

sub routesAsString {
	my $self = shift;

	foreach my $routeKey (keys(%{$self->routes()})) {
		print "$routeKey =>\n";
		my $routeVal = $self->routes()->{$routeKey};
		foreach my $dirKey (keys(%$routeVal)) {
			print "	$dirKey =>\n";
			my $dirVal = $routeVal->{$dirKey};
			foreach my $stopKey (keys(%$dirVal)) {
				print "		$stopKey => ";
				my $stopVal = $dirVal->{$stopKey};
				print $stopVal . "\n";
			}
		}
	}
}

1
__END__

=head1 NAME

WebService::Nextbus::Agency - Superclass for data structures designed for Nextbus website (www.nextbus.com)


=head1 SYNOPSIS

  use WebService::Nextbus::Agency::SFMUNI;
  $muniAgency = new WebService::Nextbus::Agency::SFMUNI;
  @stopCodes = $muniAgency->str2stopCodes('N', 'O', 'Duboce and Fillmore');

C<$stopCodes> can now be used as valid GET arguments on the nextbus webpage.


=head1 DESCRIPTION

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

None.

=head1 AUTHOR

Peter H. Li<lt>pli9+CODE@spam-guard.itsa.ucsf.edu<gt>


=head1 COPYRIGHT

Licensed by Creative Commons
http://creativecommons.org/licenses/by-nc-sa/1.0/

=head1 SEE ALSO

L<WebService::Nextbus::Agency::SFMUNI>, L<perl>.

=cut
~
