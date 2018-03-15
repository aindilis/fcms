#!/usr/bin/perl -w

use PerlLib::SwissArmyKnife;
use UniLang::Util::TempAgent;

my $tempagent = UniLang::Util::TempAgent->new
  (
   RandName => "FCMS",
  );

my $res1 = $tempagent->MyAgent->QueryAgent
  (
   Receiver => 'Guardian',
   Data => {
	    Command => 'new-task',
	    Task => 'task',
	    },
  );

print Dumper($res1);
