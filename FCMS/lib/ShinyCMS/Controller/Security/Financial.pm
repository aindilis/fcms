package ShinyCMS::Controller::Security::Financial;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::Security::Financial - Catalyst Controller

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
  # $c->stash
  #   (
  #    codebase_type  => 'minor',
  #    codebase_name   => 'utility-maximization-system',
  #    subsystem_name  => 'Utility Maximization System',
  #   );
}

sub index :Local :Args( 0 ) {
  my ( $self, $c ) = @_;

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
