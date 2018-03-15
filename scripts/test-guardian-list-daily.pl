#!/usr/bin/perl -w

use UniLang::Util::TempAgent;
use PerlLib::SwissArmyKnife;

my $tempagent = UniLang::Util::TempAgent->new();

my $res1 = $tempagent->MyAgent->QueryAgent
     (
      Receiver => 'Guardian',
      Data => {
	       Command => 'list-daily',
	      },
     );

print Dumper($res1);
