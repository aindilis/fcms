package ShinyCMS::Controller::FRDCSA::Codebases::Minor::Dialog_Interface;
use Moose;
use namespace::autoclean;

use KBS2::Util;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Codebases::Minor::Dialog_Interface - Catalyst Controller

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
     subsystem_name        => 'Dialog Interface',
     codebase_type         => 'minor',
     codebase_name         => 'dialog-interface',
     subsystem_association => 'Dialog Interface',
    );
}


=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;
  if ($c->request->params->{natural_language_query}) {
    my $naturallanguagequery = $c->request->params->{natural_language_query};
    my $results = $c->model( 'FRDCSA' )->Query
      (
       $c,
       Eval => [
		['_prolog_list',
		 ['_prolog_list',Var('Response')],
		 ['naturalLanguageQuery',$naturallanguagequery,Var('Response')],
		]
	       ],
      );
    my @tmp = @{$results->[1]};
    shift @tmp;
    $c->stash
      (
       natural_language_query_results => ['_prolog_list',['_prolog_list',$naturallanguagequery,@tmp]],
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
