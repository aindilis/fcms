package ShinyCMS::Controller::Ontology;
use Moose;
use namespace::autoclean;

use KBS2::Util;
use PerlLib::SwissArmyKnife;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::Ontology

=head1 DESCRIPTION

Controller for ShinyCMS news section.

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
     # codebase_type         => 'minor',
     # codebase_name         => 'ontology',
     subsystem_name        => 'Ontology',
     subsystem_association => 'Ontology',
    );
}

=head2 index

=cut

sub index :Path :Args(1) {
  my ( $self, $c, $entity ) = @_;
  my $results = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
  	      ['_prolog_list',
  	       Var('?Var'),
  	       ['allTermAssertions',$entity,Var('?Var')],
  	      ]
  	     ],
    );
  print ClearDumper({FU => $results});
  $c->stash
    (
     results => $results,
    );
}

__PACKAGE__->meta->make_immutable;

1;
