package ShinyCMS::Controller::FRDCSA::Codebases::Internal::Gourmet;
use Moose;
use namespace::autoclean;

use PerlLib::SwissArmyKnife;
use PGourmet;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Codebases::Internal::Gourmet - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


has 'MyPGourmet' =>
  (
   isa      => 'PGourmet',
   is       => 'rw',
   default  => sub {
     PGourmet->new(FCMS => 1);
   },
  );


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
     codebase_type  => 'internal',
     codebase_name   => 'gourmet',
     subsystem_name  => 'Gourmet Meal Planner',
    );
}

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;
  my $menutext = read_file('/home/andrewdo/Food-on-Hand-20170519.txt');
  print Dumper({MenuText => $menutext});
  $self->MyPGourmet->Load;
  $c->stash
    (
     codebase_type  => 'internal',
     menutext => $menutext,
     pgourmettext => join('',$self->MyPGourmet->Flush),
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
