package ShinyCMS::Controller::FRDCSA::Codebases::Minor::WSM;
use Moose;
use namespace::autoclean;

use KBS2::Util;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Codebases::Minor::WSM - Catalyst Controller

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
     codebase_type         => 'minor',
     codebase_name         => 'world-state-monitor',
     subsystem_name        => 'WSM',
     # subsystem_association => 'IEM Plans',
    );
}

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    # fluents_for_productivity_predicates(AllAssertedKnowledge)

    # my $results1 = $c->model( 'FRDCSA' )->Query
    #   (
    #    $c,
    #    Eval => [
    # 		['_prolog_list',
    # 		 Var('Results'),
    # 		 ['generatePageFor','worldStateMonitor1',$c->user->username,Var('Results')]
    # 		]
    # 	       ],
    #   );
    my $results2 = $c->model( 'FRDCSA' )->Query
      (
       $c,
       Eval => [
		['_prolog_list',
		 Var('Results'),
		 ['generatePageFor','worldStateMonitor2',$c->user->username,Var('Results')]
		]
	       ],
      );

    $c->stash
      (
       template => 'frdcsa/codebases/minor/wsm/index.tt',
       # results1 => $results1,
       results2 => $results2,
      );

    # $c->response->body('Matched ShinyCMS::Controller::FRDCSA::Codebases::Minor::WSM in FRDCSA::Codebases::Minor::WSM.');
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
