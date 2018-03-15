package ShinyCMS::Controller::FRDCSA::Codebases::Minor::Free_Life_Planner;

use Moose;
use MooseX::Types::Moose qw/ Str /;
use namespace::autoclean;

use BOSS::Config;
use PerlLib::SwissArmyKnife;
use Verber::Ext::PDDL::Domain;
use Verber::Ext::PDDL::Problem;
use Verber::Util::DateManip;

use DateTime;
use DateTime::Duration;

BEGIN { extends 'ShinyCMS::Controller'; }

has [qw/ Mapping iMapping /] =>
  (
   isa      => 'HashRef',
   is       => 'rw',
   default => sub {{}},
  );

has 'MyDateManip' =>
  (
   isa      => 'Verber::Util::DateManip',
   is       => 'rw',
   default  => sub {
     Verber::Util::DateManip->new();
   },
  );

has 'ActionNLGTemplates' =>
  (
   isa      => 'HashRef',
   is       => 'ro',
   default  => sub {
     return
       {
	'arm' => '$b $should $a the $c in the $d',
	'charge-fully' => '$d $should $a the $b using the $c in the $e',
	'clean-location' => '$b $should $a the $c',
	'dry-laundry-load' => '$b $should $a the loads $f, $g and $h in the $d in the $e',
	'eat' => '$b $should $a a(n) $c in the $d',
	'load' => '$b $should $a the $c into the $d in the $e',
	'lock-container' => '$b $should $a the $c in the $d',
	'lock-door' => '$b $should $a the door $c from inside the $d to the $e',
	'move' => '$b $should $a from the $c to the $d',
	'pick-up' => '$b $should $a the $c in the $d',
	'plug-in' => '$b $should $a the $c into the $d in the $e',
	'set-down' => '$b $should $a the $c at the $d',
	'shave' => '$c $should $a with the $b in the $d',
	'shower' => '$b $should $a using the $c in the $d in the $e',
	'sleep' => '$b $should $a on the $c in the $d',
	'unload' => '$b $should $a the $c from the $d in the $e',
	'unlock-container' => '$b $should $a the $c in the $d',
	'unlock-door' => '$b $should $a the door $c from inside the $d to the $e',
	'unplug' => '$b $should $a the $c from the $d in the $e',
	'use-object' => '$b $should $a the $c in the $d',
	'use-the-restroom' => '$b $should $a called $c',
	'wait' => '$b $should $a in the $c',

	'complete' => '$c $should $a the task: $b',
       };
   },
  );

sub auto : Private {
  my ( $self, $c ) = @_;
  unless ( $c->user_exists ) {
    $c->stash->{ error_msg } = 'You must be logged in to use any functions.';
    $c->go( '/welcome' );
  }

  $c->stash
    (
     codebase_type         => 'minor',
     codebase_name         => 'free-life-planner',
     subsystem_name        => 'Free Life Planner',
     subsystem_association => 'Plans',
     plan_time             => 'Current',
     plan_metric           => 'Best',
     plan_scope            => 'Weeklong',
     # plan_scope            => '20150429',
     objectives            => [['entry-fn','pse','2']],
     # plan_scope            => 'Org::FRDCSA::Verber::PSEx2::Do',
     # objectives            => [['entry-fn','pse','63']],
     plan_type             => 'Temporal',
     occupation            => 'Adventurer',
     seePDDL               => 0,
    );
}

sub index : PathPart( '' ) : Args( 0 ) {
  my ( $self, $c ) = @_;
  my $replan = 0;
  if ( $c->request->param('replan') ) {
    $replan = 1;
  }

  my $scopetofederated =
    {
     'verber://Weeklong' => 'Weekly2',
    };

  print Dumper({NowWhohey => $c->stash->{ now }});
  my %hash =
    (
     Now => $c->stash->{ now },
     Replan => $replan,
    );

  if (exists $c->stash->{plan_scope}) {
    my $scope = $c->stash->{plan_scope};
    my $resolved = 'verber://'.$scope;
    if (exists $scopetofederated->{$resolved}) {
      $hash{Cycle} = $scopetofederated->{$resolved};
    } else {
      # FIXME: verify that an SPSE2 context exists with this context name
      $hash{Context} = $scope;
    }
  } else {
    $hash{Cycle} = 'All';
  }

  $self->FindOrCreatePlan($c,%hash);

  if ( $c->request->param( 'affiliate' ) ) {
    $c->response->cookies->{ shinycms_affiliate } = 
      {
       value => $c->request->param( 'affiliate' ) };
  }
}

sub StoreMappingAndGetLowercase {
  my ($self,%args) = @_;
  my $input = $args{Input};
  my $type = $args{Type};
  # $self->Mapping->{$type}{$input} = lc($input);
  $self->iMapping->{$type}{lc($input)} = $input;
  lc($input);
}

sub RetrieveMappingOrGuess {
  my ($self,%args) = @_;
  my $output = $args{Output};
  my $type = $args{Type};
  if (exists $self->iMapping->{$type}{$output}) {
    # print Dumper({iMapping => [$output,$type,$self->iMapping->{$type}{$output}]});
    return $self->iMapping->{$type}{$output};
  } else {
    print "howdythere\n";
    $self->GuessMapping(Type => $args{Type},Output => $output);
  }
}

sub GuessMapping {
  my ($self,%args) = @_;
  my $res;
  if ($args{Type} eq 'CycL' or $args{Type} eq 'English') {
    my @chars = split //, $args{Output};
    $chars[0] = uc($chars[0]);
    $res = join('',@chars);
  }
  return $res;
}

sub Convert {
  my ($self,$c,%args) = @_;
  my $normalized;
  my $i = $args{Input};
  if ($args{InputType} eq 'PDDL') {
    $normalized = [split /[-_]/,$i];
  } elsif ($args{InputType} eq 'CycL') {
    $i =~ s/^\#\$//;
    # decamelcasehere
    $normalized = [map {$self->StoreMappingAndGetLowercase(Type => $args{InputType}, Input => $_)} split /[-_]/,$i];
  } elsif ($args{InputType} eq 'English') {
    $normalized = [map {$self->StoreMappingAndGetLowercase(Type => $args{InputType}, Input => $_)} split /\s+/,$i];
  }

  print Dumper({Normalized => $normalized});

  if ($args{OutputType} eq 'PDDL') {
    return $self->NormalizedToPDDL(Normalized => $normalized);
  } elsif ($args{OutputType} eq 'CycL') {
    return '#$'.join('',map {$self->RetrieveMappingOrGuess(Type => $args{OutputType}, Output => $_)} @$normalized);
  } elsif ($args{OutputType} eq 'English') {
    my $english = join(' ',map {$self->RetrieveMappingOrGuess(Type => $args{OutputType}, Output => $_)} @$normalized);
    if ($args{Hyperlinks}) {
      return '<a href="'.
	$c->uri_for('/ontology',$self->NormalizedToPDDL(Normalized => $normalized)).
	'">'.$english.'</a>';
    } else {
      return $english;
    }
  }
}

sub NormalizedToPDDL {
  my ($self,%args) = @_;
  my $normalized = $args{Normalized};
  join('-',@$normalized);
}


sub FindOrCreatePlan {
  my ($self,$c,%args) = @_;

  my ($startdate,$dur,$enddate,$cachefile,$cycle,$context);

  if ($c->stash->{plan_time} eq 'Current') {
    $startdate = $args{Now};
  } else {
    # FIXME: add more options
    $startdate = $args{Now};
  }

  if (exists $args{Cycle}) {
    $cycle = $args{Cycle};
    my $cycles =
      {
       Daily1 => {days => 1},
       Weekly1 => {weeks => 1},
       Weekly2 => {weeks => 1},
       Monthly1 => {months => 1},
       Years1_1 => {years => 1},
       Years10_1 => {years => 10},
       Years25_1 => {years => 25},
       Life1 => {years => 150},
      };
    $dur = DateTime::Duration->new(%{$cycles->{$cycle}});
    $cachefile = "/tmp/plpa-$cycle.dat";
  } elsif (exists $args{Context}) {
    $context = $args{Context};
    # FIXME: Verify this is in fact an existing SPSE2 domain

    # come up with an appropriate enddate, probably by looking at the
    # dates and times mentioned in the constraints in the domains, or
    # default to an existing one

    $dur = DateTime::Duration->new(years => 1);
    my $contextcleaned = $context;
    $contextcleaned =~ s/\W+/_/sg;
    $cachefile = "/tmp/plpa-$contextcleaned.dat";
  }
  $enddate = $startdate + $dur;

  my $data =
    {
     'Command' => 'plan',
     'Timing' =>
     {
      StartDate => $startdate,
      EndDate => $enddate,
      Units => '0000-00-01_00:00:00',
     },
     'Verber::Federated::Util::Date1' =>
     {
      'Flags' => {
		  Date => 1,
		  DayOfWeek => 1,
		  Today => 1,
		 },
     },
    };

  if (defined $cycle) {
    $data->{'Name'} = 'CYCLE_'.uc($cycle),
  } elsif (defined $context) {
    $data->{'Name'} = 'PSEx3';
    $data->{Context} = $context;
    $data->{Goals} = $c->stash->{objectives};
  }

  my $res1;
  if (! $args{Replan} and -f $cachefile) {
    $res1 = read_file_dedumper($cachefile);
  } else {
    $res1 = $c->model( 'FRDCSA' )->QueryAgent
      (
       Receiver => "Verber",
       Data => $data,
      );
    write_file_dumper(File => $cachefile,Data => $res1);
  }
  if (exists $res1->{Data}{World}) {
    $c->stash->{ world } = $res1->{Data}{World};
    if (exists $c->stash->{ world }{Plans}{1}{Times}) {
      my $times = $c->stash->{ world }{Plans}{1}{Times};
      my $ref = ref($times);
      if (defined $times and $ref eq 'HASH' and (scalar keys %$times > 0)) {
	my $res2 = $self->ProcessTimesIntoPlan($c, Times => $times);
	if ($res2->{Success}) {
	  $c->stash->{ plan } = $res2->{Plan};
	  $c->stash->{ conversions } = $res2->{Conversions};
	}
      }
    } else {
      # throw some kind of error

      # $c->stash->{ plan } =
      # 	[
      # 	 ['0.0003',['LOCK-CONTAINER','ANDREW-DOUGHERTY','LAPTOP-BACKPACK','DEN'],'0.1000'],
      # 	 ['0.1005',['MOVE','ANDREW-DOUGHERTY','DEN','UPSTAIRS-BATHROOM'],'0.1500'],
      # 	 ['0.2508',['CHARGE-FULLY','ELECTRIC-RAZOR-0','UPSTAIRS-BATHROOM-OUTLETS','ANDREW-DOUGHERTY','UPSTAIRS-BATHROOM'],'2.0000'],
      # 	 ['2.2510',['PICK-UP','ANDREW-DOUGHERTY','ELECTRIC-RAZOR-0','UPSTAIRS-BATHROOM'],'0.1000'],
      # 	 ['2.3512',['SHAVE','ELECTRIC-RAZOR-0','ANDREW-DOUGHERTY','UPSTAIRS-BATHROOM'],'0.2500'],
      # 	 ['2.6015',['SET-DOWN','ANDREW-DOUGHERTY','ELECTRIC-RAZOR-0','UPSTAIRS-BATHROOM'],'0.1000'],
      # 	 ['2.7018',['MOVE','ANDREW-DOUGHERTY','UPSTAIRS-BATHROOM','LIVING-ROOM'],'0.1500'],
      # 	 ['2.8520',['SLEEP','ANDREW-DOUGHERTY','COUCH','LIVING-ROOM'],'3.0000'],
      # 	 ['5.8523',['MOVE','ANDREW-DOUGHERTY','LIVING-ROOM','BEDROOM'],'0.1500'],
      # 	 ['6.0025',['ARM','ANDREW-DOUGHERTY','TOWEL-3','BEDROOM'],'0.0000'],
      # 	 ['6.0027',['MOVE','ANDREW-DOUGHERTY','BEDROOM','UPSTAIRS-BATHROOM'],'0.1500'],
      # 	 ['333.0',['SHOWER','ANDREW-DOUGHERTY','TOWEL-3','UPSTAIRS-SHOWER','UPSTAIRS-BATHROOM'],'1.0000'],
      # 	];
      # $c->stash->{ conversions } = {};
    }
    $self->LoadCapsule($c);
  }
}

sub ProcessTimesIntoPlan {
  my ($self,$c,%args) = @_;
  my $times = $args{Times};
  my @plan;
  my @written;
  my $conversions = {};
  foreach my $time (sort {$a cmp $b} keys %$times) {
    if (exists $times->{$time}{start}) {
      my $starts = $times->{$time}{start};
      foreach my $planstepid (sort {$a cmp $b} keys %$starts) {
  	my $action = $starts->{$planstepid}{Action};
	my @actionitems = $self->ParsePDDL($c,PDDL => $action);
	foreach my $actionitem (@actionitems) {
	  my $pddl = lc($actionitem);
	  if (! exists $conversions->{$pddl}) {
	    $conversions->{$pddl} =
	      {
	       PDDL => $pddl,
	       CycL => $self->Convert($c, Input => $pddl, InputType => 'PDDL',OutputType => 'CycL'),
	       English => $self->Convert($c, Input => $pddl, InputType => 'PDDL',OutputType => 'English'),
	      };
	  }
	}
	my $written = $self->GetWritten
	  (
	   $c,
	   ActionItems => \@actionitems,
	   Conversions => $conversions,
	  );
	push @plan,
	  [
	   $time,
	   \@actionitems,
	   $starts->{$planstepid}{Duration},
	   $written,
	   50,
	  ];
      }
    }
  }
  return {
	  Success => 1,
	  Plan => \@plan,
	  Conversions => $conversions,
	 };
}

sub GetWritten {
  my ($self,$catalyst,%args) = @_;
  my $conversions = $args{Conversions};
  my @actionitems = @{$args{ActionItems}};
  my $pred = lc($actionitems[0]);
  my ($a,$b,$c,$d,$e,$f,$g,$h,$i,$j) = map {' &nbsp; <a href="'.$catalyst->uri_for('/ontology',lc($_)).'">'.$conversions->{lc($_)}{English}.'</a> &nbsp; '} @actionitems;

  if (exists $self->ActionNLGTemplates->{$pred}) {
    my $template = $self->ActionNLGTemplates->{$pred};
    my $written;
    my $should = '<a class="obligation" href="'.$catalyst->uri_for('/ontology','should').'">should</a>';
    # 	a.obligation {
    # 	color:				#103840;
    # }

    eval '$written = "'.$template.'"';
    print Dumper
      ({
	Pred => $pred,
	Template => $template,
	Written => $written,
       });
    my $abbrev = $written;
    $abbrev =~ s/^.*?should<\/a>\s*//s;
    return [$written,$abbrev];
  } else {
    my @list = ($a,$b,$c,$d,$e,$f,$g,$h,$i,$j);
    while (! defined $list[-1]) {
      pop @list;
    }
    my $written = join(" ",@list);
    return [$written,$written];
  }
}

sub LoadCapsule {
  my ($self,$c,%args) = @_;
  if (exists $c->stash->{ world } and exists $c->stash->{ world }{MyCapsule}) {
    my $p = {};
    if (exists $c->stash->{ world }{MyCapsule}{ProblemFileFull}) {
      $p->{file} = $c->stash->{ world }{MyCapsule}{ProblemFileFull};
      if (-f $p->{file}) {
	$p->{contents} = read_file($p->{file});
	$p->{object} = Verber::Ext::PDDL::Problem->new(Contents => $p->{contents});
	$p->{object}->Parse;
      }
    }
    $c->stash->{ problem } = $p;
    my $d = {};
    if (exists $c->stash->{ world }{MyCapsule}{DomainFileFull}) {
      $d->{file} = $c->stash->{ world }{MyCapsule}{DomainFileFull};
      if (-f $d->{file}) {
	$d->{contents} = read_file($d->{file});
	$d->{object} = Verber::Ext::PDDL::Domain->new(Contents => $d->{contents});
	$d->{object}->Parse;
      }
    }
    $c->stash->{ domain } = $d;
  }
}

sub ParsePDDL {
  my ($self,$c,%args) = @_;
  my $pddl = $args{PDDL};
  $pddl =~ s/^\(//s;
  $pddl =~ s/\)$//s;
  return split /\s+/, $pddl;
}

1;
