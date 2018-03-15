package ShinyCMS::Controller::FRDCSA::Planning_Systems::Notes;

use PerlLib::SwissArmyKnife;

use Moose;
use namespace::autoclean;

has 'Colors' => (
		 is => 'ro',
		 isa => 'HashRef',
		 default => sub {
		   return
		     {
		      '(\(\s*)(completed)(\s+)' => 'blue',
		      '(\(\s*)(in progress)(\s+)' => 'green',
		      '(\(\s*)(postponed)(\s+)' => 'yellow',
		      '(\(\s*)(deleted)(\s+)' => 'red',
		      '(\(\s*)(noted elsewhere)(\s+)' => 'yellow',
		      '(\(\s*)(solution)(\s+)' => 'blue',
		      '(\(\s*)(when)(\s+)' => 'red',
		     }
		   },
		);


BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Planning_Systems::Notes - Catalyst Controller

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
     codebase_name         => 'notes',
     subsystem_name        => 'Notes',
     subsystem_association => 'Notes',
    );
}

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;
  my $file = 'root/frdcsa/planning_systems/notes/latest.do';
  my $text = "";
  if (-f $file) {
    $text = read_file($file);
  }
  $c->stash
    (
     notes => $text,
    );
}

sub Markup {
  my ($self, $text) = @_;

  my $colors = $self->Colors;

  foreach my $regex (keys %$colors) {
    $text =~ s/$regex/$1<font color="$colors->{$regex}">$2<\/font>$3/sg;
  }
  return $text;
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
