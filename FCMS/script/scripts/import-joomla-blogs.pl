#!/usr/bin/perl -w

use PerlLib::MySQL;
use PerlLib::SwissArmyKnife;

my $mysqlsource = PerlLib::MySQL->new(DBName => 'frdcsa_cms');
my $statement = 'select * from jos_content';
my $res1 = $mysqlsource->Do
  (
   Statement => $statement,
   AOH => 1,
  );
# print Dumper($res1);

# mysql> describe jos_content;
# +------------------+------------------+------+-----+---------------------+----------------+
# | Field            | Type             | Null | Key | Default             | Extra          |
# +------------------+------------------+------+-----+---------------------+----------------+
# | id               | int(11) unsigned | NO   | PRI | NULL                | auto_increment |
# | title            | varchar(255)     | NO   |     |                     |                |
# | alias            | varchar(255)     | NO   |     |                     |                |
# | title_alias      | varchar(255)     | NO   |     |                     |                |
# | introtext        | mediumtext       | NO   |     | NULL                |                |
# | fulltext         | mediumtext       | NO   |     | NULL                |                |
# | state            | tinyint(3)       | NO   | MUL | 0                   |                |
# | sectionid        | int(11) unsigned | NO   | MUL | 0                   |                |
# | mask             | int(11) unsigned | NO   |     | 0                   |                |
# | catid            | int(11) unsigned | NO   | MUL | 0                   |                |
# | created          | datetime         | NO   |     | 0000-00-00 00:00:00 |                |
# | created_by       | int(11) unsigned | NO   | MUL | 0                   |                |
# | created_by_alias | varchar(255)     | NO   |     |                     |                |
# | modified         | datetime         | NO   |     | 0000-00-00 00:00:00 |                |
# | modified_by      | int(11) unsigned | NO   |     | 0                   |                |
# | checked_out      | int(11) unsigned | NO   | MUL | 0                   |                |
# | checked_out_time | datetime         | NO   |     | 0000-00-00 00:00:00 |                |
# | publish_up       | datetime         | NO   |     | 0000-00-00 00:00:00 |                |
# | publish_down     | datetime         | NO   |     | 0000-00-00 00:00:00 |                |
# | images           | text             | NO   |     | NULL                |                |
# | urls             | text             | NO   |     | NULL                |                |
# | attribs          | text             | NO   |     | NULL                |                |
# | version          | int(11) unsigned | NO   |     | 1                   |                |
# | parentid         | int(11) unsigned | NO   |     | 0                   |                |
# | ordering         | int(11)          | NO   |     | 0                   |                |
# | metakey          | text             | NO   |     | NULL                |                |
# | metadesc         | text             | NO   |     | NULL                |                |
# | access           | int(11) unsigned | NO   | MUL | 0                   |                |
# | hits             | int(11) unsigned | NO   |     | 0                   |                |
# | metadata         | text             | NO   |     | NULL                |                |
# +------------------+------------------+------+-----+---------------------+----------------+
# 30 rows in set (0.00 sec)

my $mapping = {
	       title => 'title',
	       url_title => '',
	       body => 'introtext',
	       author => ['created_by','created_by_alias'],
	       blog => undef,
	       hidden => undef,
	       posted => undef,
	       discussion => undef,
	      };


# mysql> describe blog_post;
# +------------+--------------+------+-----+-------------------+----------------+
# | Field      | Type         | Null | Key | Default           | Extra          |
# +------------+--------------+------+-----+-------------------+----------------+
# | id         | int(11)      | NO   | PRI | NULL              | auto_increment |
# | title      | varchar(120) | NO   |     | NULL              |                |
# | url_title  | varchar(120) | NO   |     | NULL              |                |
# | body       | text         | NO   |     | NULL              |                |
# | author     | int(11)      | YES  | MUL | NULL              |                |
# | blog       | int(11)      | NO   | MUL | NULL              |                |
# | hidden     | tinyint(4)   | NO   |     | 0                 |                |
# | posted     | timestamp    | NO   |     | CURRENT_TIMESTAMP |                |
# | discussion | int(11)      | YES  | MUL | NULL              |                |
# +------------+--------------+------+-----+-------------------+----------------+
# 9 rows in set (0.00 sec)

my $mysqltarget = PerlLib::MySQL->new(DBName => 'shinycms_frdcsa');
$mysqltarget->TableInformation($mysqltarget->GetDatabaseInformation());
$mysqltarget->Do(Statement => 'SET FOREIGN_KEY_CHECKS=0;');

my @res2;
foreach my $row (reverse @$res1) {
  my $hash = {};
  foreach my $key (keys %$mapping) {
    my @keys;
    my $ref = ref($mapping->{$key});
    if ($ref eq 'ARRAY') {
      push @keys, @{$mapping->{$key}};
    } elsif ($ref eq '') {
      push @keys, $mapping->{$key};
    }
    my @intermediateresult;
    foreach my $key (@keys) {
      if (defined($key)) {
	push @intermediateresult, $row->{$key};
      } else {
	push @intermediateresult, undef;
      }
    }
    if (scalar @intermediateresult) {
      $hash->{$key} = join("\n", map {defined $_ ? $_ : ""}  @intermediateresult);
    } else {
      $hash->{$key} = undef;
    }
  }

  $mysqltarget->Insert
    (
     Table => 'blog',
     KeyField => 'ID',
     Values => {
		title => $hash->{title},
	       },
    );

  $hash->{blog} = int($mysqltarget->InsertID);
  my $tmp = $hash->{title};
  $tmp =~ s/\W/_/sg;
  $hash->{url_title} = $tmp;

  $mysqltarget->Insert
    (
     Table => 'blog_post',
     Values => $hash,
    );
}

# update blog_post set posted='2015-11-11 12:00:00';

# update cms_page_element set content='Whose problems are you solving today?' where id=4;

# update shared_content set content = 'Whose problems are you solving today?' where id=1;

# update cms_page_element set content='Introducing the FRDCSA' where id=1;

# update cms_page_element set content='frdcsa-visual-aid.jpg' where id=11;

# update cms_page_element set content='frdcsa-visual-aid.jpg' where id=3;
# update cms_page_element set content='frdcsa-visual-aid.jpg' where id=7;
# update cms_page_element set content='frdcsa-visual-aid.jpg' where id=11;

# update cms_page_element set content=

# '<p>FRDCSA tries to resolve all issues interfering with the welfare of
# living beings using a straightforward mathematical trick that helps to
# build a series of increasingly powerful and incidentally complex
# artificial intelligence (A.I.) systems, implemented as Free/Libre
# Software, and available for use and modification by anyone with the
# means to access or receive it.  It can be copied without any
# restrictions onto standard computers.  Whereas a human might need many
# years or even a lifetime of practice to become skilled in various arts
# and sciences which maintain and improve life, a computer can be
# manufactured for cheaper unit costs, and expert software (once
# actually developed) can be installed at almost no cost.</p>'

# where id=2;
