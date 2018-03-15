package ShinyCMS::Controller::FRDCSA::Codebases::Minor::Interactor;

use Moose;
use MooseX::Types::Moose qw/ Str /;
use namespace::autoclean;

use KBS2::ImportExport;
use KBS2::Util qw(Var ListVariablesInFormula);
use Task2::Util; # does this need to be included?
use PerlLib::SwissArmyKnife;
use UniLang::Util::TempAgent;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Codebases::Minor::Interactor - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

has tempagent =>
  (
   isa      => 'UniLang::Util::TempAgent',
   is       => 'rw',
  );

has importexport =>
  (
   isa      => 'KBS2::ImportExport',
   is       => 'rw',
  );

around BUILDARGS => sub {
  my( $orig, $self, $app, @rest ) = @_;
  my $args = $self->$orig( $app, @rest );
  $args->{ tempagent  } = UniLang::Util::TempAgent->new;
  $args->{ importexport  } = KBS2::ImportExport->new();

  return $args;
};


sub auto : Private {
  my ( $self, $c ) = @_;
  unless ( $c->user_exists ) {
    $c->stash->{ error_msg } = 'You must be logged in to use any functions.';
    $c->go( '/welcome' );
  }
  $c->stash
    (
     subsystem_name        => 'Interactor',
     codebase_type         => 'minor',
     codebase_name         => 'formalog',
     subsystem_association => 'Interactor',
    );
}

=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;
  if ($c->request->params->{formalog_query}) {
    # convert the formalog_query to a prolog query

    # ['newTask','Agent1','Yaswi1',,,Var('?TaskID'),Var('?Result')]
    # ['_prolog_list',Var('?TaskID'),Var('?Result')]

    my $query = $c->model( 'FRDCSA' )->ConvertToPrologQuotingIfNecessary
      (
       Item => $c->request->params->{formalog_query},
      );
    my $varlist = ListVariablesInFormula(Formula => $query);
    unshift @$varlist, '_prolog_list';
    my $results = $c->model( 'FRDCSA' )->Query
      (
       $c,
       Eval => [
		['_prolog_list',
		 $varlist,
		 $query->[0]
		]
	       ],
      );
    $c->stash
      (
       formalog_query_results => $results,
      );
  } elsif ($c->request->params->{constant_apropos}) {
    my $results = $c->model( 'FRDCSA' )->Query
      (
       $c,
       Eval => [
		['_prolog_list',
		 Var('Var'),
		 [
		  'constant_apropos',
		  $c->request->params->{constant_apropos},
		  Var('Var'),
		 ],
		]
	       ],
      );
    $c->stash
      (
       constant_apropos_results => $results,
      );
  }
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
