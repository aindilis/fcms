package ShinyCMS::Controller::FRDCSA::Codebases::Minor::Utility_Maximization_System;
use Moose;
use namespace::autoclean;

use KBS2::Util;
use PerlLib::SwissArmyKnife;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Codebases::Minor::Utility_Maximization_System - Catalyst Controller

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
     codebase_name         => 'utility-maximization-system',
     subsystem_name        => 'Utility Max System',
     subsystem_description => 'Spend Manager',
    );
}

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  # (= (balance andrewDougherty) 45)

  # (= (balance comcastBusiness) 0.00)

  my $accounts =
    [
     {
      Constant => 'payPalAccount',
      Name => 'Pay Pal',
      Amount => '$3.75',
     },
    ];
  $c->stash
    (
     Accounts => $accounts,
    );
}

sub bill_payment :Local {
    my ( $self, $c ) = @_;
    my $results = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
	      ['_prolog_list',
	       Var('?Results'),
	       [
		'generatePageFor',
		'bill_payment',
		$c->user->username,
		Var('?Results'),
	       ],
	      ],
	     ],
    );
  print Dumper({Results => $results});
  $c->stash
    (
     results => $results,
    );
}

sub account :Local :CaptureArgs(1) {
  my ( $self, $c, $account ) = @_;
  my $transactions = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
	      ['_prolog_list',
	       Var('Results'),
	       [
		'generatePageFor',
		['financialDecisionSupportSystem','oldSecond'],
		Var('Results'),
	       ],
	      ],
	     ],
    );
  $c->stash
    (
     transactions => $transactions,
    );
}

sub update :Local :CaptureArgs(1) {
  my ( $self, $c, $account ) = @_;
  # go ahead and run the system for pulling down the
  my $update = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
	      ['_prolog_list',
	       Var('Results'),
	       [
		'updateAccountInformation',
		$c->user->username,
		$account,
		Var('Results'),
	       ],
	      ],
	     ],
    );
  $c->stash
    (
     update => $update,
    );
}

sub update_all :Local {
  my ( $self, $c ) = @_;
  # go ahead and run the system for pulling down the
  my $updateall = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
	      ['_prolog_list',
	       Var('Results'),
	       [
		'updateAllAccountInformation',
		$c->user->username,
		Var('Results'),
	       ],
	      ],
	     ],
    );
  $c->stash
    (
     update_all => $updateall,
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
