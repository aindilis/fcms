package ShinyCMS::Controller::FRDCSA::Planning_Systems::Task_Manager;
use Moose;
use namespace::autoclean;

use KBS2::Util;

use PerlLib::SwissArmyKnife;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Planning_Systems::Task_Manager - Catalyst Controller

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
     subsystem_name  => 'Task Manager',
     codebase_type  => 'minor',
     codebase_name  => 'task-manager',
     subsystem_association => 'Tasks',
    );
}


=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;
  my $m = $c->model( 'FRDCSA' )->QueryAgent
    (
     Receiver => 'Guardian',
     Data => {
	      Command => 'list-tasks',
	     },
    );
  if (exists $m->{Data}{Result}) {
    $c->stash
      (
       controller => 'FRDCSA::Planning_Systems::Task_Manager',
       guardian => $m->{Data}{Result},
      );
  }
}


sub new_task :Local :Args(0) {
  my ( $self, $c ) = @_;
  # convert the task description to a prolog term
  my $result = $c->model( 'FRDCSA' )->ConvertToPrologQuotingIfNecessary
    (
     Item => $c->request->params->{task},
    );
  my $res1 = $c->model( 'FRDCSA' )->QueryAgent
    (
     Receiver => 'Agent1',
     Data => {
	      Eval => [['_prolog_list',['_prolog_list',Var('?TaskID'),Var('?Result')],['newTask','Agent1','Yaswi1',$result,$c->request->params->{importance},Var('?TaskID'),Var('?Result')]]],
	     },
    );
  print Dumper({MyRes1Res1 => $res1});
  # return $self->DropPrologAnnotations(Interlingua => $res1->{Data}{Result})
  $c->stash
    (
     query_result => $res1,
    );
  $c->stash(template => 'frdcsa/planning_systems/task_manager/index.tt');
  $self->index($c);
}

sub edit :Local :CaptureArgs(1) {
  my ( $self, $c, $task ) = @_;
  # convert the task description to a prolog term
  $c->stash(task => $task);
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
