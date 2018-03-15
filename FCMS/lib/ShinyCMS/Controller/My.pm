package ShinyCMS::Controller::My;
use Moose;
use namespace::autoclean;

use PerlLib::SwissArmyKnife;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::My - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


has [qw/ predicates /] =>
  (
   isa      => 'HashRef',
   is       => 'rw',
   default  => sub {{}},
  );


=head2 index

=cut

sub auto : Private {
  my ( $self, $c ) = @_;
  unless ( $c->user_exists ) {
    $c->stash->{ error_msg } = 'You must be logged in to use any functions.';
    $c->go( '/login' );
  }
  $c->stash
    (
     subsystem_name        => 'My ',
    );
}

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;
  $c->response->body('Matched ShinyCMS::Controller::My in My.');
}


sub timeline :Local {
  my ( $self, $c ) = @_;

}

sub self :Local {
  my ( $self, $c ) = @_;
  unless (scalar keys %{$self->predicates}) {
    my $predicates = {};
    my $contents = read_file('/var/lib/myfrdcsa/codebases/minor/action-planner/library/non-free/chosen-properties.txt');
    foreach my $line (split /\n/, $contents) {
      #122	(has-child ?person ?child)	A PERSON MAY HAVE A CHILD.
      if ($line =~ /^(\d+)\s+\((.+?)\)(\s+(.+?))?$/) {
	my ($count,$pretty,$interlingua,$nl) = ($1,$2,[split /\s+/, $2],$4);
	my $predicate = shift @$interlingua;
	my $obj =
	  {
	   Interlingua => $interlingua,
	   Count => $count,
	  };
	if (! exists $predicates->{$predicate}) {
	  $predicates->{$predicate} = [$obj];
	} else {
	  push @{$predicates->{$predicate}}, $obj;
	}
      } else {
	print $line."\n";
	return 0;
      }
    }
    $self->predicates($predicates);
  }
  my @array = sort {$self->predicates->{$b}[0]{Count} <=> $self->predicates->{$a}[0]{Count}}
    keys %{$self->predicates};
  my @new;
  foreach my $pred (splice @array,0,50) {
    push @new, {
		Predicate => $pred,
		Values => $self->predicates->{$pred},
	       };
  }
  $c->stash
    (
     ordered => \@new,
    );
}

sub create : Local : Chained('self') : CaptureArgs(0) {
  my ( $self, $c ) = @_;
    
}

sub add :Local {
  my ( $self, $c ) = @_;
  $c->stash->{template} = 'my/add.tt';
  if (exists $c->request->params->{ 'search' }) {
    my $search = $c->request->params->{ 'search' };
    if ($search =~ /^[a-zA-Z0-9_-]+$/) {
      my $res1 = $c->model( 'FRDCSA' )->QueryAgent
	(
	 Receiver => 'Org-FRDCSA-System-Cyc',
	 Data => {
		  _DoNotLog => 1,
		  SubLQuery => "(constant-apropos \"$search\")",
		  OutputType => 'Interlingua',
		 },
	);
      $c->stash->{my_results} = $res1->{Data}{Result}[0];
    }
  }
}

sub set_my_type {
  my ($self, $c, %args) = @_;
  $c->stash
    (
     my_type => $args{Type},
     subsystem_name        => 'My '.$args{Type},
    );
}

sub things_i_am_carrying :Local {
  my ( $self, $c ) = @_;
  # restrict simply to those things currently being carried
  $self->set_my_type($c,Type => 'Things I Am Carrying');
  $self->add($c);
}

sub possessions :Local {
  my ( $self, $c ) = @_;
  # restrict simply to those things currently owned
  $self->set_my_type($c,Type => 'Possessions');
  $self->add($c);
}

sub environment :Local {
  my ( $self, $c ) = @_;
  # restrict simply to those things currently not owned
  $self->set_my_type($c,Type => 'Environment');
  $self->add($c);
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
