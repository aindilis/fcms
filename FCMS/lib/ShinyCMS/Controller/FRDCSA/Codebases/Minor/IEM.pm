package ShinyCMS::Controller::FRDCSA::Codebases::Minor::IEM;
use Moose;
use namespace::autoclean;

use KBS2::Util;

use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Codebases::Minor::IEM - Catalyst Controller

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
     codebase_name         => 'iem',
     subsystem_name        => 'IEM',
     subsystem_association => 'IEM Plans',

     plan_time             => 'Current',
     plan_metric           => 'Best',
     plan_scope            => 'Weeklong',
     # plan_scope            => '20150429',
     objectives            => [['entry-fn','pse','2']],
     # plan_scope            => 'Org::FRDCSA::Verber::PSEx2::Do',
     # objectives            => [['entry-fn','pse','63']],
     plan_type             => 'Temporal',
     occupation            => 'Adventurer',
     seePDDL               => 0,
     verbose               => 0,
    );
}


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    $self->UpdatePlan($c);
    $self->LoadPlan($c);
}

sub UpdatePlan {
  my ( $self, $c ) = @_;
  my $currentplanstepnumber = 0;
  print Dumper({MyNowParams => $c->request->params});
  if (exists $c->request->params->{'plan_step_number'}) {
    $currentplanstepnumber = $c->request->params->{'plan_step_number'} + 1;
  }
  # $c->model( 'FRDCSA' )->Query
  #   (
  #    $c,
  #    Eval => [
  # 	      ['_prolog_list',
  # 	       Var('?Response'),
  # 	       [
  # 		'setSingleValued',
  # 		[
  # 		 'planStepNumber',
  # 		 'plan1',
  # 		 $currentplanstepnumber,
  # 		],
  # 		Var('?Result'),
  # 	       ],
  # 	      ],
  # 	     ],
  #   );
  $c->stash
    (
     current_plan_step_number => $currentplanstepnumber,
    );
}

sub LoadPlan {
  my ( $self, $c ) = @_;
  my $results = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
	      ['_prolog_list',
	       Var('?Result'),
	       ['generatePageFor','iem',$c->user->username,Var('?Result')],
	      ],
	     ],
    );
  print Dumper({IEMResults => $results});
  $c->stash
    (
     plan => $results,
     params => $c->request->params,
    );
}

sub new_objective :Local :Args(0) {
  my ( $self, $c ) = @_;
  my $newobjectivetext = $c->request->params->{'new_objective'};
  # try to parse it
  my $results = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
	      ['_prolog_list',
	       Var('?Result'),
	       ['addNewObjective',$newobjectivetext,Var('?Result')],
	      ],
	     ],
    );
  print Dumper({IEMAddNewObjectiveResults => $results});
  $c->stash
    (
     add_new_objective_results => $results,
    );
  $c->response->redirect( $c->uri_for('/frdcsa','codebases','minor','iem') );
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
