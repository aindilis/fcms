package ShinyCMS::Controller::FRDCSA::Codebases::Minor::Inventory_Manager;
use Moose;
use namespace::autoclean;

use Inventory::Util::Barcode::Lookup;

use KBS2::Util;
use KBS2::ImportExport;

use PerlLib::SwissArmyKnife;

BEGIN { extends 'Catalyst::Controller'; }

has Lookup =>
  (
   isa      => 'Inventory::Util::Barcode::Lookup',
   is       => 'rw',
   default => sub {
     return Inventory::Util::Barcode::Lookup->new();
   },
  );

has ImportExport =>
  (
   isa      => 'KBS2::ImportExport',
   is       => 'rw',
   default => sub {
     return KBS2::ImportExport->new();
   },
  );

has Debug => (isa => 'Int', is => 'rw', default => 0);

=head1 NAME

ShinyCMS::Controller::FRDCSA::Codebases::Minor::Inventory_Manager - Catalyst Controller

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
     codebase_type  => 'minor',
     codebase_name   => 'inventory-manager',
     subsystem_name  => 'Inventory Manager',
     subsystem_association => 'Inventory',
    );
}

sub index : PathPart( '' ) : Args( 0 ) {
  my ( $self, $c ) = @_;
  my $results = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
	      ['_prolog_list',
	       Var('?Result'),
	       ['listInventory',Var('?Result')]
	      ]
	     ],
    );
  $c->stash
    (
     results => $results,
    );
}

sub pantry :Local {
  my ( $self, $c ) = @_;
  my $results = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
  	      ['_prolog_list',
  	       Var('?Result'),
  	       ['listInventory',Var('?Result')]
  	      ]
  	     ],
    );
  $c->stash
    (
     results => $results,
    );
}

sub barcode :Local :CaptureArgs( 1 ) {
  my ( $self, $c, $barcode ) = @_;
  my $res1 = $self->Lookup->LookupBarcode(Barcode => $barcode);
  if ($res1->{Success}) {
    $c->stash
      (
       barcode_info => $res1->{Results},
      );
  }
}


sub add_pantry :Local :CaptureArgs( 1 ) {
  my ( $self, $c, $barcode ) = @_;
  my $res1 = $self->Lookup->LookupBarcode(Barcode => $barcode);
  if ($res1->{Success}) {
    # FIXME: implement addBarcodeToPantry, probably use atTime.
    # probably rename that to atDateTime

    if (1) {
      my $prologres = $self->GetPrologForPerlData($c, DataStructure => $res1->{Results});
      my $results = $c->model( 'FRDCSA' )->Query
	(
	 $c,
	 Eval => [
		  ['_prolog_list',
		   Var('?Result'),
		   ['addBarcodeToPantry',$prologres,Var('?Result')]
		  ]
		 ],
	);
      $c->stash
	(
	 results => $results,
	 barcode_info => $res1->{Results},
	);
    } else {
      $c->stash
	(
	 barcode_info => $res1->{Results},
	);
    }
  } else {
    $c->stash
      (
       error_info => $res1,
      );
  }
}

sub GetPrologForPerlData {
  my ($self,$c,%args) = @_;

  my $res1 = PerlDataStructureToStringEmacs
    (
     DataStructure => $args{DataStructure},
    );
  print Dumper({Res1 => $res1}) if $self->Debug;

  my $res2 = $self->ImportExport->Convert
    (
     Input => $res1,
     InputType => 'Emacs String',
     OutputType => 'Prolog',
    );
  print Dumper({Res2 => $res2}) if $self->Debug;

  if ($res2->{Success}) {
    my $res3 = $self->ImportExport->Convert
      (
       Input => $res2->{Output},
       InputType => 'Prolog',
       OutputType => 'Interlingua',
      );
    print Dumper({Res3 => $res3}) if $self->Debug;
    if ($res3->{Success}) {
      return $res3->{Output}->[0];
    }
  }
  return [];
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
