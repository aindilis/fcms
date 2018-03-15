package ShinyCMS::Controller::FRDCSA::Artificial_Intelligence::ReasonBase;
use Moose;
use namespace::autoclean;

# use ReasonBase;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Artificial_Intelligence::ReasonBase - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut


# has 'MyReasonBase' =>
#   (
#    isa      => 'RB',
#    is       => 'rw',
#    default  => sub {
#      # RB::Eolas->new(FCMS => 1);
#    },
#   );


sub auto : Private {
  my ( $self, $c ) = @_;
  unless ( $c->user_exists ) {
    $c->stash->{ error_msg } = 'You must be logged in to use any functions.';
    $c->go( '/welcome' );
  }

  # $self->MyReasonBase->Load;

  $c->stash
    (
     codebase_type  => 'internal',
     codebase_name   => 'reasonbase',
     subsystem_name  => 'ReasonBase/Eolas',
     # text => join('',$self->MyReasonBase->Flush),
    );
}


sub index :Path :Args(0) {
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
