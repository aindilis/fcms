package ShinyCMS::Controller::FRDCSA::Codebases::Internal::Audience;
use Moose;
use namespace::autoclean;

use KBS2::Util;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Codebases::Internal::Audience - Catalyst Controller

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
  my $results = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
  	      ['_prolog_list',
  	       Var('?Result'),
  	       ['generatePageFor','audience',$c->user->username,Var('?Result')]
  	      ],
  	     ],
    );
  $c->stash
    (
     codebase_type  => 'internal',
     codebase_name   => 'audience',
     subsystem_name  => 'Audience',
     subsystem_association => 'Communications',
     results => $results,
    );
}

sub contacts :Local {
  my ( $self, $c ) = @_;
  my $results = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
	      ['_prolog_list',
	       Var('?Results'),
	       [
		'generatePageFor',
		'contacts',
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

=encoding utf8

=head1 AUTHOR

Andrew Dougherty,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
