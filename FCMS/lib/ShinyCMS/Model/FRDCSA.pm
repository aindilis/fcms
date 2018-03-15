package ShinyCMS::Model::FRDCSA;
use Moose;
use namespace::autoclean;

use KBS2::Util;
use KBS2::ImportExport;

use Data::Dumper;
use Error qw(:try);

# use Language::Prolog::Types qw(:ctors);

extends 'Catalyst::Model';

=head1 NAME

ShinyCMS::Model::FRDCSA - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.

=cut

has 'TempAgent' =>
  (
   isa      => 'UniLang::Util::TempAgent',
   is       => 'rw',
   default  => sub {
     UniLang::Util::TempAgent->new
	 (
	  RandName => "FCMS",
	 );
   },
  );

has 'MyImportExport' =>
  (
   is => 'rw',
   isa => 'KBS2::ImportExport',
   default => sub {
     KBS2::ImportExport->new();
   },
  );

sub Query {
  my ($self,$c,%args) = @_;
  my @items;
  my $res1 = $self->QueryAgent
    (
     Receiver => 'Agent1',
     Data => {
	      Eval => $args{Eval},
	     },
    );
  # print Dumper({Res1 => $res1});
  if (exists $res1->{Data}) {
    if (exists $res1->{Data}{Result}) {
      my @list;
      if (defined $res1->{Data}{Result}) {
	@list = @{$res1->{Data}{Result}};
      }
      return \@list;
    } else {
      # throw Error();
    }
  } else {
    # throw Error();
  }
}

sub QueryAgent {
  my ($self,%args) = @_;
  # FIXME: have it if debugging is on display these results using ClearDumper
  $self->TempAgent->MyAgent->QueryAgent
    (
     %args,
    );
}

sub Convert {
  my ($self,%args) = @_;
  my $res0 = $self->MyImportExport->Convert
    (
     %args,
    );
  if ($res0->{Success}) {
    return $res0->{Output};
  } else {
    # FIXME: Throw error
  }
}

sub ConvertToPrologQuotingIfNecessary {
  my ($self,%args) = @_;
  try {
    my $res0 = $self->MyImportExport->Convert
      (
       Input => $args{Item},
       InputType => 'Prolog',
       OutputType => 'Interlingua',
      );
    if ($res0->{Success}) {
      my $output = $res0->{Output};;
      my $dumper = Dumper($output);
      if ($dumper eq
	  Dumper([
		  'end_of_file'
		 ])) {
	throw Error();
      } elsif ($dumper eq
	       Dumper([
		       undef
		      ])) {
	throw Error();
      } else {
	return $output;
      }
    } else {
      throw Error();
    }
  } catch Error with {
    # return prolog_atom($args{Item});
    return DumperSingleQuote($args{Item});
    # return $args{Item};
  }
}

sub Prepare {
  my ($self,$result) = @_;
  my $prologResult = $self->Convert
    (
     Input => [$result],
     InputType => 'Interlingua',
     OutputType => 'Prolog',
    );
  $prologResult =~ s/\.?\n?$//sg;
  return $prologResult;
}

sub PrepareWithLinks {
  my ($self,$c,$item) = @_;
  my $linkedresult = $self->GetLinks($c, Item => $item);
  my $prologResult = $self->Convert
    (
     Input => [$linkedresult],
     InputType => 'Interlingua',
     OutputType => 'Prolog',
    );
  $prologResult =~ s/\.?\n?$//sg;
  return $prologResult;
}

sub GetLinks {
  my ($self,$c,%args) = @_;
  my $item = $args{Item};
  my $ref = ref($item);
  if ($ref eq 'ARRAY') {
    my @res;
    foreach my $subitem (@$item) {
      push @res, $self->GetLinks($c, Item => $subitem);
    }
    return \@res;
  } elsif (! TermIsVariable($item)) {
    return '<a href="'.$c->uri_for('/ontology',$item).'">'.$item.'</a>';
  } else {
    return $item;
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
