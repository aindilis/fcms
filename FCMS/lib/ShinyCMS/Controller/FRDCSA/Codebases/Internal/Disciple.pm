package ShinyCMS::Controller::FRDCSA::Codebases::Internal::Disciple;
use Moose;
use namespace::autoclean;
use KBS2::Util;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Codebases::Internal::Disciple - Catalyst Controller

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
     codebase_type         => 'internal',
     codebase_name         => 'disciple',
     subsystem_name        => 'Disciple',
     subsystem_association  => 'Checklists',
    );
}

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;
  my $results = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
	      ['_prolog_list',
	       Var('?Result'),
	       ['generatePageFor','disciple',$c->user->username,Var('?Result')]
	      ]
	     ],
    );
  $c->stash
    (
     results => $results,
    );
}

sub log_checklist_item :Local :Args(0) {
  my ( $self, $c ) = @_;
  # update the knowledge model
  $c->stash->{params_dump} = Dumper($c->request->params);
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
