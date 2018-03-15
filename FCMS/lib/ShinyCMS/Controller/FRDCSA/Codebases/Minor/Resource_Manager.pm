package ShinyCMS::Controller::FRDCSA::Codebases::Minor::Resource_Manager;
use Moose;
use namespace::autoclean;

use KBS2::Util;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Codebases::Minor::Resource_Manager - Catalyst Controller

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

sub GetHash {
  my ( $self, $c, %args ) = @_;
  $c->model( 'FRDCSA' )->GetHash(%args);
}

sub GetList {
  my ( $self, $c, %args ) = @_;
  $c->model( 'FRDCSA' )->GetList(%args);
}

sub DropAnnotations {
  my ( $self, $c, %args ) = @_;
  $c->model( 'FRDCSA' )->DropAnnotations(%args);
}


sub index : PathPart( '' ) : Args( 0 ) {
  my ( $self, $c ) = @_;
  my $shopping_list_2 =
    [
     'coffee pre-ground',
     'deep dish pizza',
     'peanut butter',
     'shepherds pie',
     'organic pizzas',
     'organic apples',
     'organic bananas',
     'oranges',
     'broccoli',
     'dip for broccoli',
     'angus burgers',
     'brioche burger buns',
     'roasted red pepper soup',
     'chicken soup (2)',
     'organic milk',
     'organic eggs',
     'organic boneless skinless chicken breast (2)',
     'Bran Buds',
     'Apple Sauce',
     'Prune Juice',
     'Organic Chicken cutlets',
     'Organic Tomatos',
     'Onion',
     'Mushrooms',
     'Organic Yogurt',
     'Organic Sweet Potato (big)',
     'Organic Baking Potatoes (Russet)',
     'Unsalted Butter',
     'Organic (+-unsalted) Butter',
     'Organic Cheese Parmesian Reggiona',
     'Organic Red Pepper and Tomato Soup',
     'Organic Split Pea (a couple)',
     'Organic Blueberries',
     'Organic Grass Fed Beef',
     'Kosher Salt (Morton)',
     'Black Pepper ready to grind',
     'Pumpkin Muffie',
     'Paper Towels',
     'Tissues',
    ];

  my $shopping_list_1 = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
	      ['_prolog_list',
	       Var('?Result'),
	       ['generatePageFor','resourceManager',Var('?Result')]
	      ]
	     ],
    );
  $c->stash
    (
     codebase_type  => 'minor',
     codebase_name   => 'resource-manager',
     subsystem_name  => 'Resource Manager',
     subsystem_association => 'Resources',
     shopping_list_1 => $shopping_list_1,
     shopping_list_2 => $shopping_list_2,
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
