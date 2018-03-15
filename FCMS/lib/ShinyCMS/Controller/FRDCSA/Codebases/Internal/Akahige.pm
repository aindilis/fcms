package ShinyCMS::Controller::FRDCSA::Codebases::Internal::Akahige;
use Moose;
use namespace::autoclean;

use KBS2::Util;

use PerlLib::SwissArmyKnife;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

ShinyCMS::Controller::FRDCSA::Codebases::Internal::Akahige - Catalyst Controller

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
     codebase_type         => 'internal',
     codebase_name         => 'akahige',
     subsystem_name        => 'Akahige',
     subsystem_description => 'Spend Manager',
    );
}

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;
  my $results = '';
  # my $results = $c->model( 'FRDCSA' )->Query
  #   (
  #    $c,
  #    Eval => [
  # 	      ['_prolog_list',
  # 	       Var('?Result'),
  # 	       ['generatePageFor','akahige',$c->user->username,Var('?Result')]
  # 	      ]
  # 	     ],
  #   );

  my $results2 = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
  	      ['_prolog_list',
  	       Var('?Printout'),
  	       ['currentMedicationsListPrintout','andrewDougherty',Var('?Printout')]
  	      ]
  	     ],
    );
  $c->stash
    (
     results => $results,
     currentMedicationsListPrintout => $results2,
     user => $c->user->username,
    );
}

sub chart :Local {
  my ( $self, $c ) = @_;
  # my $res1 = $c->model( 'FRDCSA' )->QueryAgent
  # (
  #  Receiver => 'Guardian',
  #  Data => {
  # 	      Command => 'what-to-tell-agent',
  # 	     },
  # );
}

sub imladris :Local {
  my ( $self, $c ) = @_;
}

sub files :Local {
  my ( $self, $c ) = @_;
  my $patient = $c->request->param( 'patient' ) || "Andrew-Dougherty";;
  my $files = [split /\n/, `find /var/lib/myfrdcsa/codebases/internal/akahige/data/people/$patient /var/lib/myfrdcsa/private/systems/akahige/data-git/people/$patient | sort`];
  $c->stash
    (
     files => $files,
    );
}

sub search :Local {
  my ( $self, $c ) = @_;
  my $patient = $c->request->param( 'patient' ) || "Andrew-Dougherty";;
  my $files = [split /\n/, `find /var/lib/myfrdcsa/codebases/internal/akahige/data/people/$patient /var/lib/myfrdcsa/private/systems/akahige/data-git/pe
ople/$patient | sort`];

  # obtain the search term, and then list all matching files, with snippets of the match
  my $res1 = $self->GrepFiles
    (
     $c,
     Search => $c->request->param( 'search' ),
     Files => $files,
    );
  $c->stash
    (
     files => $res1,
    );
}

sub GrepFiles {
  my ($self,$c,%args) = @_;
  my $patient = $c->request->param( 'patient' ) || "Andrew-Dougherty";;
  my $files =$args{Files};
  my $search = $args{Search};
  my $fh = IO::File->new();
  my $akahigetmpfile = "/tmp/akahige-files.txt";
  if ($fh->open(">$akahigetmpfile")) {
    print $fh join("\n", @$files)."\n";
    $fh->close;
  }
  my $command = 'cat '.shell_quote($akahigetmpfile).' | grep -iE '.shell_quote($search);
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
