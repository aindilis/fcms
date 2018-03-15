package ShinyCMS::Controller::FRDCSA::Codebases::Minor::Alexa_Integration;
use Moose;
use namespace::autoclean;

use KBS2::Util;

use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Codebases::Minor::Alexa_Integration - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub auto : Private {
  my ( $self, $c ) = @_;
  unless ( $c->user_exists ) {
    $c->stash->{ error_msg } = 'You must be logged in to use any functions.';
    $c->go( '/welcome' );
  }
  $c->stash
    (
     subsystem_name        => 'Alexa',
     codebase_type         => 'minor',
     codebase_name         => 'alexa-integration',
     subsystem_association => 'Alexa',
    );
}

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;
  $self->ListRecentInteractions($c);
}

sub ListRecentInteractions {
  my ( $self, $c ) = @_;
  my $results = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
  	      ['_prolog_list',
	       Var('?History'),
	       ['generatePageFor','alexaIntegration',Var('?History')],
  	      ]
  	     ],
    );
  print Dumper({AlexaResults => $results});
  $c->stash
    (
     results => $results,
    );
}


=encoding utf8

=head1 AUTHOR

Andrew Dougherty,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
