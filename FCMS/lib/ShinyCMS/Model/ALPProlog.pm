package ShinyCMS::Model::ALPProlog;

use Moose;
use namespace::autoclean;

use System::ALPProlog;

extends 'Catalyst::Model';


has 'ALPProlog' =>
  (
   isa      => 'System::ALPProlog',
   is       => 'rw',
   default  => sub {
     System::ALPProlog->new
	 (
	 );
   },
  );



sub Plan {
  my ($self,$c,%args) = @_;
  $self->ALPProlog->LoadALPPrologFiles
    (
     ALPPrologFile => $args{ALPPrologFile} || '/var/lib/myfrdcsa/codebases/minor/free-fluxplayer/attempts-alp/2/wumpus_strategy.ecl',
     # ALPPrologDomain => $args{ALPPrologDomain} || '/var/lib/myfrdcsa/codebases/minor/free-fluxplayer/attempts-alp/2/',
     # ALPPrologProblem => $args{ALPPrologProblem} || '/var/lib/myfrdcsa/codebases/minor/free-fluxplayer/attempts-alp/2/',
    );
  return $self->ALPProlog->Plan();
}

=head1 NAME

ShinyCMS::Model::ALPProlog - Catalyst Model

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
