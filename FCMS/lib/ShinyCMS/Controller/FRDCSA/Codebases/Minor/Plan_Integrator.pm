package ShinyCMS::Controller::FRDCSA::Codebases::Minor::Plan_Integrator;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Codebases::Minor::Plan_Integrator - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


sub auto : Private {
  my ( $self, $c ) = @_;
  unless ( $c->user_exists ) {
    $c->stash->{ error_msg } = 'You must be logged in to use any functions.';
    $c->go( '/welcome' );
  }

  $c->stash
    (
     codebase_type         => 'minor',
     codebase_name         => 'plan-integrator',
     subsystem_name        => 'Plan Integrator',
     subsystem_association => 'Plan Integrator',
    );
}

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    # $c->response->body('Matched ShinyCMS::Controller::FRDCSA::Codebases::Minor::Plan_Integrator in FRDCSA::Codebases::Minor::Plan_Integrator.');
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
