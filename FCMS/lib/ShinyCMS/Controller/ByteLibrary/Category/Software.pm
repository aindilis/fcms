package ShinyCMS::Controller::ByteLibrary::Category::Software;
use Moose;
use namespace::autoclean;

use KBS2::Util;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::ByteLibrary::Category::Software - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash
      (
       results => $c->model( 'FRDCSA' )->Query($c, Eval => [['_prolog_list',Var('?Result'),['generatePageFor',['byteLibrary','software'],Var('?Result')]]]),
      );
}



=encoding utf8

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
