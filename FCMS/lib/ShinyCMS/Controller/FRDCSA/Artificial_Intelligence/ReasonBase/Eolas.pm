package ShinyCMS::Controller::FRDCSA::Artificial_Intelligence::ReasonBase::Eolas;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Artificial_Intelligence::ReasonBase::Eolas - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub auto : Private {
  my ( $self, $c ) = @_;
  check_permissions(C => $c);
  unless ( $c->user_exists ) {
    $c->stash->{ error_msg } = 'You must be logged in to use any functions.';
    $c->go( '/welcome' );
  }
  $c->stash
    (
     subsystem_name        => 'Ontology',
     # codebase_type         => 'minor',
     # codebase_name         => 'ontology',
     subsystem_association => 'Ontology',
    );
}

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched ShinyCMS::Controller::FRDCSA::Artificial_Intelligence::ReasonBase::Eolas in FRDCSA::Artificial_Intelligence::ReasonBase::Eolas.');
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
