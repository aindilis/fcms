package ShinyCMS::Model::FLUX;

use Moose;
use namespace::autoclean;

use System::FLUX;

extends 'Catalyst::Model';


has 'FLUX' =>
  (
   isa      => 'System::FLUX',
   is       => 'rw',
   default  => sub {
     System::FLUX->new
	 (
	 );
   },
  );

sub Plan {
  my ($self,$c,%args) = @_;
  $self->FLUX->LoadFluxFiles
    (
     FluxFile => $args{FluxFile} || '/var/lib/myfrdcsa/codebases/minor/free-fluxplayer/attempts/1/6_nursebot_canonical.pl',
     FluxDomain => $args{FluxDomain} || '/var/lib/myfrdcsa/codebases/minor/free-fluxplayer/attempts/1/6_nursebot_domain.pl',
     FluxProblem => $args{FluxProblem} || '/var/lib/myfrdcsa/codebases/minor/free-fluxplayer/attempts/1/6_nursebot_problem.pl',
    );
  return $self->FLUX->Plan();
}

# ['/var/lib/myfrdcsa/codebases/minor/free-fluxplayer/attempts/1/6_nursebot_domain.pl'].
# ['/var/lib/myfrdcsa/codebases/minor/free-fluxplayer/attempts/1/6_nursebot_problem.pl'].
# main.

=head1 NAME

ShinyCMS::Model::FLUX - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.


=encoding utf8

=head1 AUTHOR

Andrew Dougherty,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
