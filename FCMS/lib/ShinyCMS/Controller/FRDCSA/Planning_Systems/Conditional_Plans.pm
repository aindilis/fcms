package ShinyCMS::Controller::FRDCSA::Planning_Systems::Conditional_Plans;
use Moose;
use namespace::autoclean;

use KBS2::ImportExport;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Planning_Systems::Conditional_Plans - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

has importexport =>
  (
   isa      => 'KBS2::ImportExport',
   is       => 'rw',
  );

around BUILDARGS => sub {
  my( $orig, $self, $app, @rest ) = @_;
  my $args = $self->$orig( $app, @rest );
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
     codebase_type         => 'minor',
     codebase_name         => 'conditional-plans',
     subsystem_name        => 'Conditional Plans',
     subsystem_association => 'Conditional Plans',
     # plan_time             => 'Current',
     # plan_metric           => 'Best',
     # plan_scope            => 'Weeklong',
     # plan_scope            => '20150429',
     # objectives            => [['entry-fn','pse','2']],
     # plan_scope            => 'Org::FRDCSA::Verber::PSEx2::Do',
     # objectives            => [['entry-fn','pse','63']],
     # plan_type             => 'Temporal',
     # occupation            => 'Adventurer',
     # seePDDL               => 0,
    );
}

sub NormalizeToFLUX {
  my ( $self, $c ) = @_;

}

sub FindOrCreatePlanUsingFLUX {
  my ( $self, $c ) = @_;
  my $results1 = $c->model( 'FLUX' )->Plan($c);
  # my $results2 = $self->importexport->Convert
  #   (
  #    Input => $results1,
  #    InputType => 'SWIPL',
  #    OutputType => 'Prolog',
  #   );
  $c->stash
    (
     results => $results1->{Prolog},
    );
}

sub FindOrCreatePlanUsingALPProlog {
  my ( $self, $c ) = @_;
  my $results1 = $c->model( 'ALPProlog' )->Plan($c);
  # my $results2 = $self->importexport->Convert
  #   (
  #    Input => $results1,
  #    InputType => 'SWIPL',
  #    OutputType => 'Prolog',
  #   );
  $c->stash
    (
     results => $results1->{Prolog},
    );
}

=head2 index

=cut

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;
  if (0) {
    # FIXME: when this runs it dies on inclusion of genlsDirectly
    $self->FindOrCreatePlanUsingFLUX($c);
  }
  if (0) {
    $self->FindOrCreatePlanUsingALPProlog($c);
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
