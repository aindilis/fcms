package ShinyCMS;

use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

use Catalyst qw/
		 ConfigLoader
		 Static::Simple

		 Authentication
		 Authorization::ACL
		 Authorization::Roles

		 Session
		 Session::Store::DBIC
		 Session::State::Cookie

		 StackTrace

	       /;

use CatalystX::RoleApplicator;

use Method::Signatures::Simple;

extends 'Catalyst';


our $VERSION = '0.9.1';
$VERSION = eval $VERSION;


# Configure the application.
#
# Note that settings in shinycms.conf take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
		    name => 'ShinyCMS',
		    # Load config file
		    'Plugin::ConfigLoader' => {
					       file   => 'config/shinycms.conf',
					       driver => {
							  'General' => { -InterPolateVars => 1 },
							 },
					      },
		    # Configure DB sessions
		    'Plugin::Session' => {
					  dbic_class => 'DB::Session',
					  expires    => 3600,
					  # Stick the flash in the stash
					  flash_to_stash => 1,
					 },
		    # Configure SimpleDB Authentication
		    'Plugin::Authentication' => {
						 default => {
							     class           => 'SimpleDB',
							     user_model      => 'DB::User',
							     password_type   => 'self_check',
							     use_userdata_from_session => 1,
							    },
						},
		    # Disable deprecated behaviour needed by old Catalyst applications
		    disable_component_resolution_regex_fallback => 1,
		   );

  # Set cookie domain to be wildcard (so it works on sub-domains too)
  method finalize_config {
    __PACKAGE__->config(
			session => { cookie_domain => '.'.$self->config->{ domain } }
		       );
    $self->next::method( @_ );
  };


sub prepare_headers {
  my $c = shift;

  # run the other bits first
  $c->maybe::next::method();

  # check for the X-Secure-Connection header
  $c->req->secure(1)
    if $c->req->header('X-Secure-Connection');

  return 1;
}

my $USE_TESTING_HTTPS_PORT = undef; # Should we use the testing port?

# make changes to config for the development environment
my $engine = $ENV{CATALYST_ENGINE} || '';
if ( $engine =~ m{ ^ HTTP (\:\:Restarter)? }x ) {

  # we should be running pound for the tests to work
  $USE_TESTING_HTTPS_PORT = 1;
}

=head2 redirect_to_secure

    $c->redirect_to_secure();

Redirect the current request to the secure url. On live this is just
replacing the 'http' with 'https'. On the catalyst test server it is also
changing the port to C<$http_port + 1> which is where pound is expected to
be running.

=cut

sub redirect_to_secure {
  my $c = shift;

  # get a copy of the url
  my $uri = $c->req->uri->clone;

  # change the protocol
  $uri->scheme('https');

  # change the port if needed
  if ($USE_TESTING_HTTPS_PORT) {
    $uri->port( $uri->port + 1 );
  }

  # debug output
  $c->log->debug(
		 sprintf(
			 "redirecting from %s to %s",
			 $c->req->uri->as_string, $uri->as_string
			)
		) if $c->debug;

  # redirect to this new url
  $c->res->redirect($uri);

  return;
}


# # Load browser detection trait (for detecting mobiles)
# __PACKAGE__->apply_request_class_roles(
# 				       'Catalyst::TraitFor::Request::BrowserDetect' 
# 				      );



# Start the application
__PACKAGE__->setup;



=head1 NAME

ShinyCMS

=head1 SYNOPSIS

    script/shinycms_server.pl

=head1 DESCRIPTION

ShinyCMS is an open source CMS built in Perl using the Catalyst framework.

http://shinycms.org

http://catalystframework.org


=head1 SEE ALSO

L<ShinyCMS::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Denny de la Haye <2018@denny.me>

=head1 LICENSE

This program is free software: you can redistribute it and/or modify it 
under the terms of the GNU Affero General Public License as published by 
the Free Software Foundation, either version 3 of the License, or (at your 
option) any later version.

You should have received a copy of the GNU Affero General Public License 
along with this program (see docs/AGPL-3.0.txt).  If not, see 
http://www.gnu.org/licenses/

=cut

1;

