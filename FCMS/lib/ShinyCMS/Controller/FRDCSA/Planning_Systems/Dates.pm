package ShinyCMS::Controller::FRDCSA::Planning_Systems::Dates;
use Moose;
use namespace::autoclean;

use KBS2::Util;
use PerlLib::SwissArmyKnife;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Planning_Systems::Dates - Catalyst Controller

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
     codebase_name         => 'dates',
     subsystem_name        => 'Dates',
     subsystem_association => 'Dates',
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
	       ['generatePageFor','dates',$c->user->username,Var('?Result')]
	      ]
	     ],
    );
  # print Dumper({DatesResults => $results});
  $c->stash
    (
     results => $results,
    );
}

sub notes :Local {
  my ( $self, $c ) = @_;
  $c->response->redirect( $c->uri_for('/frdcsa','planning_systems','notes') );
}

sub new_event :Local {
  my ( $self, $c ) = @_;
  my $results = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
	      ['_prolog_list',
	       Var('Var'),
	       [
		'createNewEvent',
		['_prolog_list',
		 $c->request->params->{date},
		 $c->request->params->{specification},
		 $c->request->params->{participants},
		 $c->request->params->{agenda},
		],
		Var('Var'),
	       ],
	      ],
	     ],
    );
  $c->stash
    (
     new_event_creation_results => $results,
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
