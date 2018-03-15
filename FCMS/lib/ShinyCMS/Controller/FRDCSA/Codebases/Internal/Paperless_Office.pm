package ShinyCMS::Controller::FRDCSA::Codebases::Internal::Paperless_Office;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Codebases::Internal::Paperless_Office - Catalyst Controller

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
}


sub index :Path :Args(0) {
  my ( $self, $c ) = @_;
  my $results = [];

  # my $results = $c->model( 'FRDCSA' )->Query
  #   (
  #    $c,
  #    Eval => [
  # 	      ['_prolog_list',
  # 	       ['taskAssignedByTo',Var('?TaskID'),Var('?Description'),Var('?AssignedByAgent'),'meredithMcGhan'],
  # 	       ['taskAssignedByTo',Var('?TaskID'),Var('?Description'),Var('?AssignedByAgent'),'meredithMcGhan']
  # 	      ],
  # 	     ],
  #   );

  $c->stash
    (
     codebase_type  => 'internal',
     codebase_name   => 'paperless-office',
     subsystem_name  => 'Paperless Office',
     subsystem_association => 'Electronic Filing System',
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
