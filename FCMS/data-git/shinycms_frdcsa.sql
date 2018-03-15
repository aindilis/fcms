-- MySQL dump 10.13  Distrib 5.5.42, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: shinycms_frdcsa
-- ------------------------------------------------------
-- Server version	5.5.44-0+deb8u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `access`
--

DROP TABLE IF EXISTS `access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `access` varchar(50) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access`
--

LOCK TABLES `access` WRITE;
/*!40000 ALTER TABLE `access` DISABLE KEYS */;
INSERT INTO `access` VALUES (1,'Member','2015-11-11 19:01:55');
/*!40000 ALTER TABLE `access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoresponder`
--

DROP TABLE IF EXISTS `autoresponder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoresponder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `url_name` varchar(100) NOT NULL,
  `description` text,
  `mailing_list` int(11) DEFAULT NULL,
  `has_captcha` tinyint(4) DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoresponder`
--

LOCK TABLES `autoresponder` WRITE;
/*!40000 ALTER TABLE `autoresponder` DISABLE KEYS */;
INSERT INTO `autoresponder` VALUES (1,'Example autoresponder','example',NULL,NULL,0,'2015-11-11 19:02:09');
/*!40000 ALTER TABLE `autoresponder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoresponder_email`
--

DROP TABLE IF EXISTS `autoresponder_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoresponder_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `autoresponder` int(11) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `template` int(11) NOT NULL,
  `delay` int(11) NOT NULL,
  `plaintext` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `autoresponder_email_idx_autoresponder` (`autoresponder`),
  KEY `autoresponder_email_idx_template` (`template`),
  CONSTRAINT `autoresponder_email_fk_autoresponder` FOREIGN KEY (`autoresponder`) REFERENCES `autoresponder` (`id`),
  CONSTRAINT `autoresponder_email_fk_template` FOREIGN KEY (`template`) REFERENCES `newsletter_template` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoresponder_email`
--

LOCK TABLES `autoresponder_email` WRITE;
/*!40000 ALTER TABLE `autoresponder_email` DISABLE KEYS */;
INSERT INTO `autoresponder_email` VALUES (1,1,'This is an autoresponse email',1,0,'This is the plain text body of the autoresponse email.\n','2015-11-11 19:02:09');
/*!40000 ALTER TABLE `autoresponder_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoresponder_email_element`
--

DROP TABLE IF EXISTS `autoresponder_email_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoresponder_email_element` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'Short Text',
  `content` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `autoresponder_email_element_idx_email` (`email`),
  CONSTRAINT `autoresponder_email_element_fk_email` FOREIGN KEY (`email`) REFERENCES `autoresponder_email` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoresponder_email_element`
--

LOCK TABLES `autoresponder_email_element` WRITE;
/*!40000 ALTER TABLE `autoresponder_email_element` DISABLE KEYS */;
INSERT INTO `autoresponder_email_element` VALUES (1,1,'body','HTML','<p>\n	This is the HTML body of the autoresponse email.\n</p>\n','2015-11-11 19:02:09');
/*!40000 ALTER TABLE `autoresponder_email_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `basket`
--

DROP TABLE IF EXISTS `basket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `basket` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session` char(72) DEFAULT NULL,
  `user` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `basket_idx_session` (`session`),
  KEY `basket_idx_user` (`user`),
  CONSTRAINT `basket_fk_session` FOREIGN KEY (`session`) REFERENCES `session` (`id`),
  CONSTRAINT `basket_fk_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basket`
--

LOCK TABLES `basket` WRITE;
/*!40000 ALTER TABLE `basket` DISABLE KEYS */;
/*!40000 ALTER TABLE `basket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `basket_item`
--

DROP TABLE IF EXISTS `basket_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `basket_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basket` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '1',
  `unit_price` decimal(9,2) NOT NULL DEFAULT '0.00',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `basket_item_idx_basket` (`basket`),
  KEY `basket_item_idx_item` (`item`),
  CONSTRAINT `basket_item_fk_basket` FOREIGN KEY (`basket`) REFERENCES `basket` (`id`),
  CONSTRAINT `basket_item_fk_item` FOREIGN KEY (`item`) REFERENCES `shop_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basket_item`
--

LOCK TABLES `basket_item` WRITE;
/*!40000 ALTER TABLE `basket_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `basket_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `basket_item_attribute`
--

DROP TABLE IF EXISTS `basket_item_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `basket_item_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `basket_item_attribute_idx_item` (`item`),
  CONSTRAINT `basket_item_attribute_fk_item` FOREIGN KEY (`item`) REFERENCES `basket_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basket_item_attribute`
--

LOCK TABLES `basket_item_attribute` WRITE;
/*!40000 ALTER TABLE `basket_item_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `basket_item_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog`
--

LOCK TABLES `blog` WRITE;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
INSERT INTO `blog` VALUES (1,'Progress for 2012','2015-11-12 02:26:59'),(2,'2011 Progress (or lack thereof)','2015-11-12 02:26:59'),(3,'2010 Progress','2015-11-12 02:26:59'),(4,'New Capabilities: Sun Oct 11, 8:37 PM','2015-11-12 02:26:59'),(5,'Google Summer of Code Ideas','2015-11-12 02:26:59'),(6,'Recent developments','2015-11-12 02:26:59'),(7,'Good Things Come to Those Who Wait','2015-11-12 02:26:59'),(8,'Relative Consistency Proofs','2015-11-12 02:26:59'),(9,'Raiders of the FTP Sites','2015-11-12 02:26:59'),(10,'One Possible Problem with Seed-AI','2015-11-12 02:26:59'),(11,'FRDCSA Mission','2015-11-12 02:26:59'),(12,'The Death of Freedom','2015-11-12 02:26:59'),(13,'Overview of Today\'s Work','2015-11-12 02:26:59'),(14,'A Solution to Weak Weak Artificial Intelligence','2015-11-12 02:26:59'),(15,'Motivation for Our Programme of Software Conglomeration','2015-11-12 02:26:59'),(16,'Generic Considerations Associated with the Formation of Software Systems','2015-11-12 02:26:59'),(17,'\"Untangling the Truth\" Analysis','2015-11-12 02:26:59'),(18,'Increased FRDCSA Involvement','2015-11-12 02:26:59'),(19,'The FRDCSA Community','2015-11-12 02:26:59'),(20,'Oct 23 2008 Update','2015-11-12 02:26:59'),(21,'Some Common Misconceptions Refuted','2015-11-12 02:26:59'),(22,'FRDCSA requirements','2015-11-12 02:26:59'),(23,'Technical Motivation','2015-11-12 02:26:59'),(24,'FRDCSA Facts','2015-11-12 02:26:59'),(25,'Support and Documentation','2015-11-12 02:26:59'),(26,'FRDCSA Overview','2015-11-12 02:26:59'),(27,'FRDCSA Features','2015-11-12 02:26:59'),(28,'AI Overview','2015-11-12 02:26:59'),(29,'Artificial Intelligence','2015-11-12 02:26:59'),(30,'FRDCSA License','2015-11-12 02:26:59'),(31,'Arguments in Support of AI Research','2015-11-12 02:26:59');
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_post`
--

DROP TABLE IF EXISTS `blog_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(120) NOT NULL,
  `url_title` varchar(120) NOT NULL,
  `body` text NOT NULL,
  `author` int(11) DEFAULT NULL,
  `blog` int(11) NOT NULL,
  `hidden` tinyint(4) NOT NULL DEFAULT '0',
  `posted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `discussion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_post_idx_author` (`author`),
  KEY `blog_post_idx_blog` (`blog`),
  KEY `blog_post_idx_discussion` (`discussion`),
  CONSTRAINT `blog_post_fk_author` FOREIGN KEY (`author`) REFERENCES `user` (`id`),
  CONSTRAINT `blog_post_fk_blog` FOREIGN KEY (`blog`) REFERENCES `blog` (`id`),
  CONSTRAINT `blog_post_fk_discussion` FOREIGN KEY (`discussion`) REFERENCES `discussion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_post`
--

LOCK TABLES `blog_post` WRITE;
/*!40000 ALTER TABLE `blog_post` DISABLE KEYS */;
INSERT INTO `blog_post` VALUES (1,'Progress for 2012','Progress_for_2012','<p>First, because the links on the far left are not working, please see the repositories of software at <a href=\"http://frdcsa.org/frdcsa\">http://frdcsa.org/frdcsa</a></p><p>Also, in order to see previous articles in the system, just do a search for \'the\' in the left column. </p><p>The www.frdcsa.org site is fundamentally broken and will be replaced with a new dynamic site based on <a href=\"http://www.catalystframework.org/\">Perl Catalyst</a>, in which web services will be available to users to demo the capabilities of the FRDCSA.  2012 has been a year of solid employment, and I am now in position to have some financial resources for accomplishing some of the objectives of the project.  I am saving up the requisite funds to pay for a period of development wherein the FRDCSA itself is <a href=\"http://news.perlfoundation.org/2010/08/2010q3-grant-proposal-frdcsa-i.html\">finally released</a>.  I have also been able to obtain server equipment and many areas of the project are now feeling a new breath of freedom.  However, with employment, there hasn\'t been any time to develop the software itself, however, I am learning many techniques such as <a href=\"http://moose.perl.org/\">Moose</a> and Catalyst which will come in handy for the revised FRDCSA / FRDCSA 2.0.</p><p>Work has focused in a few areas.  The <a href=\"http://frdcsa.org/~andrewdo/WebWiki/FreeLifePlanningCoachSoftware.html\">Free Life Planning System</a> has come along, and I\'ve learned all about the <a href=\"http://frdcsa.org/~andrewdo/essential-reading/data/ai-research/\">field of practical reasoning and rational agency</a>.  To this end the <a href=\"http://frdcsa.org/~andrewdo/WebWiki/UtilityMaximizationSystem.html\">Utility Maximization System</a> is also being developed, in order to help improve the allocation of funds within the project and for those struggling to make ends meet.  Many of the user level programs like <a href=\"http://freecode.com/projects/paperless-office\">Paperless Office</a> are working well.  There is work on integrating <a href=\"http://www.cse.unsw.edu.au/~mit/Papers/AAAI10a.pdf\">GDL-II</a> with the Free Life Planner, and synthesizing a forward chaining expert system within the Datalog constructs.  The rules for the life planner are <a href=\"http://www.defeasible.org/ruleml2011ijcai/files/OConnor.pdf\">being mined</a> by <a href=\"http://frdcsa.org/~andrewdo/writings/workhorse.odp\">natural language processing systems</a>, and are tailored to extract rules based on logic form.  NLU is an area of development.  We now have a <a href=\"http://173.165.36.104\">private cloud</a> and are creating new virtual machines for various free software projects.  This is the basis of the <a href=\"http://frdcsa.org/~andrewdo/writings/flourish-2009.odp\">POSI groupware system</a>, in which the POSI system is being reinvisioned in terms of <a href=\"http://cgi.cse.unsw.edu.au/~mit/Papers/ECAI12.pdf\">Multi-Agent Epistemic Logic</a> and other <a href=\"http://staff.science.uva.nl/~stokhof/gdl.pdf\">Dynamic/Action logics</a>.  There is a good paper in a previous <a href=\"http://www.aaai.org/Magazine/magazine.php\">Artificial Intelligence Magazine</a>, called <a href=\"http://www.questia.com/library/1G1-305660756/logics-for-multiagent-systems\">Logics for Multiagent Systems</a>, which is very useful in covering alot of the areas I am focused on.  We are transitioning our old servers to VMs using <a href=\"http://www.scribd.com/doc/63924141/XCP-VM-Installation\">P2V</a>.  A <a href=\"http://www.elleconnect.com/underconstruction/\">new project</a> is starting with some of the developers of the <a href=\"https://play.google.com/store/apps/details?id=com.elle.bleaf&hl=en\">bLeaf Ethical Consumer system</a>.  Work on using the <a href=\"http://flossmole.org/\">FLOSSMole</a> datamarts is progressing, and integrating with the existing <a href=\"http://frdcsa.org/frdcsa/minor/system-recommender/index.html\">system-recommender</a> code for accelerating the location of software that is suitable to various project purposes.  GUIs have been written for various systems, and we may be transitioning to running <a href=\"http://plackperl.org/\">Plack</a> servers with Catalyst for the applications themselves.  A new system for managing file metadata that is invariant to movement of files and extends the <a href=\"http://projects.gnome.org/tracker/\">Gnome Nepomuk tracker system</a> is under development, and is being used with the <a href=\"http://frdcsa.org/frdcsa/minor/index.html\">Academician system</a> to represent <a href=\"http://frdcsa.org/~andrewdo/writings/academician.txt\">knowledge the user has learned in reading papers</a>.  The academician system is rapidly being developed to handle more keystroke to stored knowledge Emacs key bindings - a prelude to the <a href=\"http://frdcsa.org/frdcsa/internal/kmax/index.html\">KMax</a> <a href=\"http://frdcsa.org/~andrewdo/writings/workhorse.odp\">system</a>.  <a href=\"http://frdcsa.org/frdcsa/internal/clear/\">Clear</a> is being fixed up and a default reasoning system for queuing papers is under development.  The list could go on and on.  In truth, develoment has been very slow because I am spending all of my time and energies on my great new job, but the overall system is improving rapidly, and I do, on weekends and breaks, have a little time to develop these systems.  So the powers of the FRDCSA are growing, and it\'s infrastructure is improving vastly, including networking and RAID arrays and so forth.  Things are on the up and up.</p><p>Having said that, it has been difficult to find collaborators.  Fortunately, with POSI being restarted, and with biweekly scrums being scheduled with a free software equivalent of Webex, things are going to improve in the collaboration department.  If you have any interest in working with me, please send me an email with the subject FRDCSA.</p><p>I am also hiring out the development of some of the FRDCSA Android infrastructure, to more capable hands.</p><p>So, good news.  Hope all is well with you and yours. </p>',62,1,0,'2015-11-11 18:00:00',0),(2,'2011 Progress (or lack thereof)','2011_Progress__or_lack_thereof_','2011 started out very well but has become a disaster.  The primary work on the project is performed on the justin.frdcsa.org server which has 4 TB of project data.  The project is divided up in many ways, including a git archive of all of the code, and a computer-specific data section that houses the application data. It was customary to store large files there so that they didn\'t bog down the git repo.<br /><br />Unfortunately, while making extensive use of the data drive for a program for natural language paraphrase generation, the hard drive developed IRQ errors.  This was a serious problem because currently there is no backup infrastructure, which may appear to be a colossal lapse in judgment, but rather is attributable to a lack of project funding.  Going forward it is now the aim of the project to obtain a new server with a raid configuration (as well as an offsite backup server) in order to proof the system against possible future data loss.  Also, one goal of our fundraising is to have data recovery be performed on the drive that failed.<br /><br />Why should this matter?  The reason this matters is that the FRDCSA is engaged in long term work to improve the state of open source software as it relates to improving the human condition. Whereas many AI projects are military in nature, this project differs in that the goal of the project is to provide tools that benefit individuals (and not military organizations), especially those in poverty and those with disabilities.  The proliferation of cheap computers and smart phones, in conjunction with the capabilities of free software, enables essential services to be rendered, including a medical diagnostic system, a meal planning system, and a personal life planning and organization assistant. The aim is to augment the social safety net and to enhance the lives of people with tools for improving organization. Unfortunately in a for profit cultural environment most of these tools have not yet been created as free software.  All of these tools benefit from the capabilities of software that is gathered and stored by the FRDCSA.  An original objective of the project is to package previously unpackaged yet applicable software for Debian GNU+Linux.<br /><br />On a more positive note, much technical progress has been made this year.  Work has focused on the end-to-end life planning system, with the construction of additional parts of the Free Life Planning system. <br /><br /><a href=\"http://frdcsa.org/~andrewdo/WebWiki/FreeLifePlanningCoachSoftware.html\">http://frdcsa.org/~andrewdo/WebWiki/FreeLifePlanningCoachSoftware.html</a><br /><br />We already have a system that helps the user set goals and compute and execute plans to achieve them (SPSE2/IEM).  By contrast, action planner is concerned with weighing the importance of these goals in various situations, to enable automated replanning in cases where all the objectives cannot be met or in cases where unexpected and unmodelled failures occur.<br /><br />Much work had been done on improving the Interactive Execution Monitor, which walks users through plans.  Unfortunately most of that seems lost as it was not yet committed to the git repository. <br /><br />And lately I have taken to working more on the natural language understanding components of the system, and in particular the Emacs environment for asserting knowledge from text.  It would be very nice to acquire some of the recent efforts at ontology population from text.  Fortunately, most of the methods from the Capability::TextAnalysis module have been made functional again, however, NLU research progresses more along the lines of NL-Soar in that we are looking to create a deliberating process that knows the timing and time complexity of various tasks and uses that information to guide the search for answers.  But it is clearly a work in progress.<br /><br />More information about the failure can be found as quoted in this Facebook post:<br /><br />The hard drive is definitely hosed, will submit it to recovery operations once I get the funds (perhaps through grant procurement). There was no backup to the secondary drive. The reason the data was not stored in git was it was personal data for applications. Total lost was 600 GB. The main FRDCSA systems are of course still intact but their data sections will have been lost. It should have been rsynced to a remote drive. I am redesigning the data storage systems, would appreciate any knowledge of data storage like NAS or RAID, any advice to get the operation moving in the right direction especially as regards disaster recovery and recovery from hacking. The hard drive was a Seagate 1.5 TB drive that was known to brick frequently, got it on discount without that information. I was writing a natural language paraphrase generation program using the TERp data and was using MLDBM tied hashes with 800MB of data, and the program ran for 4 or 5 hours. Guess that was too much. It was main data storage, contained many virtual machines and did many other data intensive processes. Hoping the platter has not flaked so that there would be a chance of a full or at least partial backup. Drive makes clicking noises and read errors, discontinuing use. The drive itself contained sole backup of my laptop after that filesystem failed. All in all a sad day. However, sometimes I find losses like this refreshing in that you can build a new direction free from the errors of the past. Many design decisions are now undone but I can do it better this time around. Sort of like simulated annealing.<br /> ',62,2,0,'2015-11-11 18:00:00',0),(3,'2010 Progress','2010_Progress','<p>It has been so long that I have submitted an update that I kept passing the opportunity by because I forgot how to do it.  The good news is the project is coming along really well.  Many systems that were only wishes are now facts.  Yet life seems to be passing me by, there is still not the unity of structure I would like behind the project.  The good news is that in all this time the state of the free software world has moved immeasurably forward.  Each new day brings new surprises.  I will now proceed to give an overview of the state of the system.</p><p>I do not yet have the todo list systems working properly.  The mechanisms for reporting which tasks have been accomplished are therefore more or less lacking.  For this reason, I cannot give a precise list of the accomplishments.  Moreover, there is currently no estimation of the value of a particular task, although some code exists which computes it in a suboptimal way.  So I cannot readily prioritize the announcements of which tasks have been completed.  So, I will simply talk stream of consciousness.</p><p>Thanks to the Zlatan\'s influence, much work has progressed on the usability of the project to a wider audience.  Therefore, several GUIs have been developed.  The advantage here is that the infrastructure for rapidly developing GUIs is moving forward, and that certain processes that are ultimately easier to perform with GUIs can be or have been programmed.</p><p> The two most significant GUIs thus developed are SPSE2 and Paperless Office.  SPSE2 is the shared priority system editor.  It is useful for establishing and editing a big picture model of the project.  Unfortunately, for it to be truly useful, there still remain serious obstacles.  But it already functions and can even export temporal plans based on the facts.  It uses FreeKBS2 as the backend and runs reasonably fast and is highly efficacious, just not perfectly so.  Paperless Office as well has been implemented, enabling the full cessation of Windows use as Paperport is no longer required.  While being a very substantial program, it also requires a lot of improvements to become the system it is meant to be.</p><p> Releasing the project, which has been its central bane, is coming along.  We had one grant for the release rejected, but with the help of some allies we are developing a grant writing campaign manager that should see some funds make it to supporting the release.  As well, a video game under development has now been made to use the FRDCSA, tying its release to the project and hopefully accelerating it.  Lastly, the Virtual Machine release has been accomplished and we now have build instructions for the project.  This means that with a little work we can build the frdcsa-common package.  It also means that, for those who apply and are approved to receive a pre-release version of the Panoply GNU+Linux, as it is called, can start using the system and get to know some of its aspects.  It is also hoped that those who use it will be able to eventually contribute to its release, by means of a distributed GUI system for \"declassifying\" or rather deidentifying personal information from the codebases.</p><p> Currently the system is available in two forms and a third will soon be made available.  The virtual machine appliance may be shipped via a storage device like a hard drive or USB stick, it may be downloaded (caution 20GB), and soon a multi-DVD release will be made.  As the git repos are continuously filled and new software of use to others becomes available, the VM images will be upgraded and released.</p><p> But to pretend that this was all the news would be to reduce the tremendous progress all across the project to a few special areas that have taken only a fraction of the development time.  There are just too many fascinating subjects to explore and it does not seem appropriate to mention one in favor of another, so I will simply conclude with an appeal to apply for the pre-release version and to become active in what may someday become the FRDCSA community.  Oh, POSI is being woken from the ashes.  It\'s website had to be moved because the original domain name lapsed, so it is temporarily being placed at http://posi.frdcsa.org .  As POSI was conceived outside the range of the FRDCSA and is not a project (although it uses the FRDCSA tools), it is not an appropriate location and will be fixed when the resources are available.</p><p> To all who have helped, your contributions have meant more than you probably know. </p>',62,3,0,'2015-11-11 18:00:00',0),(4,'New Capabilities: Sun Oct 11, 8:37 PM','New_Capabilities__Sun_Oct_11__8_37_PM','Added preliminary \"Coreference Resolution\" to Formalize using BART.<br /><br />A program to locate a doctor, by recursively tracking phone number recommendations.<br /><br />Text difficulty system for determining reading level.<br /><br />Added Capability::CoreferenceResolution to PerlLib.<br /><br />Created a whole list of desired Capability::&lt;capability&gt; to PerlLib from radar-web-search logs.<br /><br />Added APE for interacting with the Attempto Controlled English Parser Engine.<br /><br />Added a slew of functions to KMax.<br /><br />Developed a quicker tokenize_treebank by just translating the sed file into Perl.<br /><br />PhraseFrequency started for various languages.',62,4,0,'2015-11-11 18:00:00',0),(5,'Google Summer of Code Ideas','Google_Summer_of_Code_Ideas','<p><strong>Our organization did not make it into GSOC for this year.  However, if you would like, apply to work with me anyway on this project.  There will be no stipend however.</strong> </p><p>Mentor:  Andrew J. Dougherty<br /> A.I. Researcher<br /> FRDCSA Project<br /> 630.300.5565<br /> andrewdo@frdcsa.org<br /> http://frdcsa.org/~andrewdo</p><p>  The <a href=\"http://frdcsa.org\">FRDCSA</a>/<a href=\"http://posithon.org\">POSI</a> are looking for students to help pioneer some interesting technologies regarding free and open source software.</p><p>  The FRDCSA is involved with numerous cutting edge research and developing topics.  There are too many to list, in fact the project has a todo system with over 10,000 items.</p><p>  POSI is a new free software collaboration experiment, which involves fine grained modeling of people\'s goals, interests and abilities in order to develop a plan to maximize the satisfaction of everyone\'s goals subject to the constraints of interest and ability. </p><p>  If you have any questions, join #posi @ freenode, and tell \"aindilis\" something.</p><p>  Keep in mind that our main development stack is Debian/Perl/Emacs - skill with these will increase the chance of your selection.</p><p>  While all the propositions below are reasonably hard, with appropriate mentorship they will be possible for a student with programming skills.  As our organization (and indeed even our GSOC project proposals) strives to educate, it is part of our ethos to help the student and others like her become skilful with the development and implementation of free software systems. We are looking to develop various systems:</p><ul> <li><strong>Difficulty: Easy</strong><ul> <li>Intelligent Tutoring Systems (SystemX) - write natural language processing software that maps out subject areas, pedagogical materials, and dynamically composes lessons and tests that fit within a temporal plan for overall subject coverage.  Develop domains for teaching programming, system administration, etc.<p>  If this is written (in fact a lot has been written, but still some work remains), we will be able to offer to the community software that helps users rapidly ramp up on certain technology areas.  Note that this will work with the <a href=\"http://frdcsa.onshore.net/frdcsa/internal/clear\">CLEAR system</a>.  This will be useful for training for companies and projects and will result in better skills.  We are already using <a href=\"http://frdcsa.onshore.net/frdcsa/internal/clear\">CLEAR</a> and it\'s associated tools (like its Firefox extension) to great success.  </p></li><li>GNU+Linux/Android Speech Recognition - for Android - get a basic small vocabulary grammar based speech recognition system (like CMUSphinx) working for the Android phone (using the simulator).  Or, help with the acquisition of speech data for training free software Large Vocabulary Continuous Speech Recognition systems.<p>  Developing voice recognition will enable the Verber Personal Planner to walk the users through doing various tasks, such as cooking (in the case of Gourmet), or any other task, by integration and RPC with their phone.  </p></li><li>POSI Core Systems - Write software (semweb stuff) for the modeling of users Goals/Interests and Abilities for POSI systems such as it\'s IRC bots and web interfaces.  Then help to organize contributors by accumulating data about their interests and shared goals (through free  <a href=\"http://pascallin.ecs.soton.ac.uk/Challenges/RTE/\">textual entailment recognition</a> systems) and developing algorithms to schedule collaborative work on these tasks.<p>If the POSI Core Systems function, it will be easier for the project to identify the research intentions of its community and establish successful projects. </p></li></ul> </li>  <li><strong>Difficulty: Medium</strong><ul> <li><a href=\"http://frdcsa.onshore.net/frdcsa/internal/radar\">RADAR</a>/<a href=\"http://frdcsa.onshore.net/frdcsa/internal/packager\">Packager</a> - extend the existing RADAR/Packager tool to provide better automation of automatic Debian package creation from online software sources.  Package hundreds of free software packages and place in the online repository.<p>If RADAR/Packager are making more packages, it will ensure both the portability of the FRDCSA project, as well as massive reuse of the software that we package (provided we advertise our repository well enough).  </p></li><li>Experience Modeling System (EMS) - develop software that, by analyzing writings (such as IRC logs, AIM chats, email, and text documents), as well as resumes and user\'s input, models what areas the subject is familiar with.  Develop a subject area classification by mixing the LCC (Library of Congress Classification) system, with existing FLOSS subject ontologies, and extraction by text processing Wikipedia with techniques such as LSI (latent semantic indexing).<p> The EMS works with other areas of POSI such as the core systems and the <a href=\"http://frdcsa.onshore.net/frdcsa/internal/job-search\">Job Search system</a> (<a href=\"http://posithon.org/cgi-bin/js/job-search.cgi\">Sample Resume/Job Matching system</a>).  It is vastly important for figuring out who can perform specific tasks.  Who knows, maybe GSOC itself will use this eventually.  </p></li><li><a href=\"http://frdcsa.onshore.net/frdcsa/internal/gourmet\">Gourmet Meal Planner</a> - Develop the worlds first free and open source food ontology that can be used for various free software meal planners like <a href=\"http://frdcsa.onshore.net/frdcsa/internal/gourmet\">Gourmet Meal Planner</a> and <a href=\"http://grecipe-manager.sourceforge.net/\">Gourmet Recipe Manager</a>.  Do this by writing a module for Gourmet Recipe Manager that propagates ingredient description to SR20 entry mappings to a server.<p>If this is done, we will have done about as  much as is mathematically possible to eliminate hunger, or at least bad-diet.  </p></li></ul> </li> <li><strong>Difficulty: Hard</strong><ul> <li><a href=\"http://frdcsa.onshore.net/frdcsa/internal/verber\">Verber Personal Planner</a> - (Verber) (also see <a href=\"http://frdcsa.org/~andrewdo/writings/semweb.odp\">forthcoming lecture slides</a>) develop interesting extensions to the existing Verber personal task manager, develop PDDL3.0 and Opt domains that include more commonsense information and increase coverage.  Write an Android Interactive Execution Monitor application to walk users through resultant plans, update world state, and allow them to initiate replanning.  Integrate mixed initiative planners, and communicate with leaders in the field of AI Automated Planning and Scheduling. Integrate with existing calendaring systems.<p>  Verber is going to be a life saver for people with ADD, Schizophrenia, or Autistic Spectrum Disorders.  It will provide the so-called execution function or \"time-management skills\" that they so injuriously lack.  However, it will  boost the time management skills of people without these conditions...  </p></li><li>Natural Language Processing - (Sayer/Thinker) Develop state of the art natural language processing techniques for converting text to semantic representations and invoking theorem proving for understanding, as part of the Formalize/Sayer/Thinker systems. <p>  Proper understanding of natural language will prove pivotal in the automatic creation of PDDL3.0 domains from goal statements (to help Verber along), as well as an abundance of other projects.  </p></li><li>FRDCSA Virtual Machine Release - Complete the release of the entire FRDCSA on a Virtual Machine.  While it is already in progress, this has been the achilles heel of the project - so far only privileged developers have access to the full project.</li> </ul> </li> </ul> <hr />  Do whatever you think would be a cool project.  My goal is first to reconnoiter the student\'s goals/interests/abilities and then co-evolve a set of goals that satisfy the users\' interests.<p>&nbsp;</p>',62,5,0,'2015-11-11 18:00:00',0),(6,'Recent developments','Recent_developments','<div class=\"entry\"> 					<p>Wow, so I’m really cruising along on the development of various software systems.  I wrote a web front end for the software that will soon run POSI (http://posithon.org).  It is a goal tracking and knowledge representation system used to model people’s goals, interests, and abilities and use that information to help form teams  to solve specific problems.</p> <p>Related to this is the Job-Search resume matching program, which had been written earlier.  I’m half-way through writing a web front end so anyone can submit their resume and have the results processed.  This includes creating a daily update script for the scraper.  The resume matcher takes your resume, parses all the different skills and experience, and uses this to query Craigslist job postings to find the best matches.</p> <p>Lastly, I’ve written code for Reasonbase that populates a wiki with information that has been extracted from text.  It runs OpenCalais along with other text analysis procedures on the submitted URI, and these provide information for all the named entities, which are then fed into a Wiki.  The first instance of this, the Tara Knowledge Archives, is (partially) online.</p> <p>http://posithon.org/reasonbase/tarawatch</p> <p>Tell your friends, join #posi @ freenode to work with others on interesting projects of your/their choosing.</p> <p>The FRDCSA release is coming along, although I haven’t spent too much time on it recently.  Of course, all the software I mentioned above with be copied via git to the VM before being released.</p> <p>There are so many projects I want to work on.  But reality is calling. Disability will soon expire and then I’ll be looking for a job.  So if you know anyone that wants to hire, please let them and me know.  I am<br />also open to doing consulting once the disability has ended.  If you are looking for consulting work, I am writing code to consolidate consulting tasks using the POSI infrastructure and information.</p> 				</div>',62,6,0,'2015-11-11 18:00:00',0),(7,'Good Things Come to Those Who Wait','Good_Things_Come_to_Those_Who_Wait','Hello friends and bots, the FRDCSA will be available to download soon - in all its glory.  A working, configured virtual machine will be the easiest way to distribute the system for now given the myriad dependencies and other configuration items that have not been ironed out yet.  Just load it into the Virtual Machine software of your choice and you have the nascent FRDCSA at your fingertips.  I would like it if those who are considering downloading it email me, but of course that\'s not necessary.  As there is no coherent documentation, please feel free to contact me for explanation of how the software might suit your needs.  Also, all who discover the software systems of the FRDCSA could help by documenting them.  Okay, thanks.  I\'m sure that you won\'t be disappointed, but chances are you won\'t know which tools are useful to you.',62,7,0,'2015-11-11 18:00:00',0),(8,'Relative Consistency Proofs','Relative_Consistency_Proofs','In the course of a proof, at each step, when you make an inference, you have to protect the inference from leading to a false conclusion, because the axioms and or rules of inference could very well be inconsistent.  What assurance do you have for the safety of the conclusion?  How has it been secured?  And where would you put a proof of the consistency of the axioms and the rules of inference?  Ultimately, perhaps this must reside in the mind of the prover.  It is here that the prover may be tricked.  If she wishes to verify some set of axioms and rules of inference, she must either do it in another proof system, or in her head (or perhaps I am mistaken).  Anyways, this is what a fresh pair of eyes yields upon rediscovering mathematical logic.',62,8,0,'2015-11-11 18:00:00',0),(9,'Raiders of the FTP Sites','Raiders_of_the_FTP_Sites','While the FRDCSA has a ridiculous number of projects ongoing at any<br />time, a recently developing project has taken my fancy because it<br />promises to offer good dividends.  The project, called \"Raiders of the<br />FTP Sites\", well, speaks for itself.  It is a system that searches FTP<br />sites for interesting artifacts and retrieves them.  It works by<br />correlating subject matter of interest with FTP sites, extracting a<br />recursive directory listing of the FTP site, and then performing<br />several analyzes of the contents.  While still a very immature system,<br />it has yielded up a labelled resume corpus which will help the<br />job-search program.<br />',62,9,0,'2015-11-11 18:00:00',0),(10,'One Possible Problem with Seed-AI','One_Possible_Problem_with_Seed_AI','The FRDCSA is a project which works towards the creation of AI through practical methods.  AI is the theory of building intelligently behaving artificial systems.  Strong AI (SAI) holds that human intelligence is Turing equivalent and therefore computer programs which fully model human intelligence are possible.  Weak AI (WAI), on the other hand, asserts that humans are not Turing equivalent and that therefore we may be concerned with writing increasingly intelligent programs, but these must fall short of human intelligence. <br /><br />We  take the  reasonable view  that both  SAI and  WAI  contain an unproven  assertion, namely,  that which  decides the  question of human/computer  equivalence.  Therefore,  we consider  a resticted theory of AI  we designate AI-, the intersection  of the axioms of SAI and WAI.<br /><br />Reasoning  in  this  manner,  we  attempt  to  create  intelligent programs.   The  most obvious  approach  to  bootstrap  AI is  the concept  of seed  AI.  This  is the  idea that  the  AI researcher requires  only to  write  a  simple program  which,  by virtue  of unprecidented  historical   circumstances  and  the   authors  own superior design, is able to grow to be increasingly intelligent.<br /><br />While   in  and  of   itself  possible,   it  relies   on  certain environmental  assumptions  which  are  not known  to  exist,  and therefore does not succeed with certainty.  To see the flaw in the crude argument for seed AI, it is best to consider the restatement \"I am going to write a program that writes a smarter program.\"<br /><br />When this idea becomes formalized,  it is equivalent to this: I am going  to write a  program A  that writes  another program  B that solves problems (aka. proves theorems) that A cannot.<br /><br />This  however is what  is called  a transitive  closure violation. Suppose A cannot prove Phi, yet A writes B and B proves Phi.  This is equivalent to A proves Phi (transitively).  Contradiction.<br /><br />While this  proof sketch is  not convincing outside of  the proper setting of  recursion theory, hopefully  it conveys the  idea.  In the  proper setting,  it is  evident that  B is  only part  of the intermediate execution of A. <br /><br />Most  new AI  researchers, who  understand  the goal  but not  the means, will attempt to continue to justify the concept.  They will resort to having an oracle  O which provides information to A, and thus A  is not affected  in this way.   But this idea is  simply a relativization of the same fundamental error.  In other words, one has  only to  bound  the size  of  the oracle  input  and then  to demonstrate that  the totality  of any additional  problems solved must be provided by the environment.',62,10,0,'2015-11-11 18:00:00',0),(11,'FRDCSA Mission','FRDCSA_Mission','FRDCSA is an organization supporting programmers of the Free and Open Source Software (FLOSS) revolution.  Our goal is to assemble the most comprehensive ontology of FLOSS applications, and make packages available for every free operating system, distribution and hardware platform. We are committed to developing applications that by solving problems improve people\'s lives.',62,11,0,'2015-11-11 18:00:00',0),(12,'The Death of Freedom','The_Death_of_Freedom','<p><span>What is the most essential aspect to life in the ancient Chinese game of Go (WeiQu)?  It is liberties!  A stone group dies if all its liberties are removed.  And it has no life there is no eventual defense of its liberties.  Does not the present seem to feel that way - as though all one\'s liberties are disappearing according to pretexts like counterterrorism?  Unfortunately, there are many tendencies currently in effect which serve as disadvantageous contracts.  From \"Early Irish Law\" pp. 158: </span></p><p> <span>\"An extreme example of a disadvantageous contract is cited from Scripture in the Introduction to the Senchas Mar.  The Fall is seen here as a contract through which Adam exchanged the whole world for one apple.  Though this contract was clearly a case of saithiud (being taken advantage of) on a colossal scale, it was notetheless valid, because Adam was a legally competent adult (sochonn).\"</span></p><p>Likewise, many of us are legally competent adults.  Are we entered into a contract in which we are being taken advantage of, through the removal of our liberties?  I think so:</p><p>From \"Early Irish Law\" pp. 154-155:</p><p>\"A person who witnesses an offence without attempting to prevent it may be guilty of a \'crime of the eye\' (cin sulo) commonly referred to as aircsiu (also forcsiu) \'looking on\'.  Legal commentary includes aircsiu among the four things which debase a lord and his family, on the grounds that \'everyone who looks on at an offence consents to it\' (aititnech gach aircsinach).\"</p><p>Now, is it not self-evident that our civil liberties are being stolen in plain sight, whatever the reason or whether that reason is justified?  Surely we are consenting to it, and consent is in a certain sense a contract.</p><p>What does this mean?  I think it is evident that if one accepts the legal maxims thus advocated, we are indeed culpable and responsible for our own destruction by removal of civil liberties.  With such rights removed, will they ever be restored?  How will we come to defend our few remaining rights if all recourse is removed?  Indeed such situations are very dangerous.</p><p>Therefore, we must act.  What are the threats?  What a great question, that is hard to tell.  But in some cases, the case seems clear.</p><p>Very often times, the authorities are attempting to remove certain rights, such as anonymous communications, due to some pretext, such as child-pornography.  While certainly no ethical adult could argue for child-pornography, \"abuse is no argument against fair use\".  That is, those of us who use anonymous communications responsibly have an inalienable right.  It is for this reason that I advocate against the following bill as it stands:</p><p>http://www.opencongress.org/bill/110-s1738/show</p><p>There are at least 2 other devils of which some account must be made.  The first of these is Digital Rights Management.  This is a scheme by which corporations - operating on the protected territory of \"intellectual property\", seek to determine who can play which files on their computer - enforced through hardware means.  Such a technology, once allowed to exist, will make the confiscation of reading choices all too easy.  It is essentially a way to prevent the free exchange of ideas - which is necessary in a democracy.  Such control gives corporations a blank check to control which arguments people are subjected to - and such control has always been the dream of repressive governments like (supposedly) the former Soviet Union.</p><p>The second devil which should be grabbed by the horns is software patents.  There is an easy argument to see why these are evil.  Artificial Intelligence technology allows the codification of knowledge and argumentation in code.  If they can patent software, then they can patent any idea or argument.  This means you cannot use that argument without their permission, or legal/military force will be applied against you.  The ability to repress argumentation is another goal of repressive governments.</p><p>Do we really want to give up all of our liberties.  Such threats make me sick.  It is enough that in our time we should live to see the rights of others trampled underfoot, let alone that we ourselves will endure such a future.  But if we do nothing, then clear:</p><p>\"The <em>fault</em>, dear Brutus, is not in <em>our stars</em>, but in ourselves\" </p>',62,12,0,'2015-11-11 18:00:00',0),(13,'Overview of Today\'s Work','Overview_of_Today_s_Work','<p>Now that I have this website, I am going to blog to it about what gets done at the FRDCSA.</p><p>I added a lot of new features to RADAR today.  First, radar-web-search has been extended.  This program originally allows for one to search for a topic on the net, say, \"event extraction\" after which it will build a large search for all the software on the net.  It then searches Yahoo and looks at each page, to see if any software is linked:</p><p>andrewdo@box:/var/lib/myfrdcsa/codebases/internal/event-system/IE$ radar-web-search \"event extraction\"<br />QUERY: \"event extraction\"  system OR java OR project OR library OR php OR web OR framework OR open OR manager OR linux OR engine OR net OR server OR management OR game OR tool OR tools OR client OR simple OR editor OR cms OR database OR\\<br /> file OR generator OR software OR network OR xml OR python OR based OR source OR plugin OR data OR amp OR language OR application OR control OR online OR toolkit OR interface OR 3d OR irc OR eclipse OR free OR api OR windows OR code OR \\<br />os OR perl OR virtual OR development OR gui OR driver OR content OR module OR mail OR image OR suite OR player OR portal OR monitor OR platform OR simulator OR script OR object OR log OR media OR text OR easy OR browser OR search OR ser\\<br />vice OR viewer OR de OR chat OR remote OR parser OR mysql OR time OR bot OR mobile OR converter OR sql OR daemon OR tracker OR rpg OR programming OR test OR gnu OR environment OR class OR utility OR gnome OR compiler OR internet OR 0 OR\\<br /> user OR utilities OR html OR package OR desktop<br /><br />Result: #1<br />Url:http://www.pubmedcentral.nih.gov/articlerender.fcgi?tool=pubmed&pubmedid=15494078<br />http://www.pubmedcentral.nih.gov/articlerender.fcgi?tool=pubmed&amp;pubmedid=15494078<br />Summary: With the explosion of molecular data, tools developed by computer scientists are ... BIND-The Biomolecular Interaction Network Database. Nucleic Acids Research. ...<br />Title: PASBio: predicate-argument structures for event extraction in molecular ...<br />$VAR1 = [];<br /><br />Result: #2<br />Url:http://nlp.cs.nyu.edu/info-extr/<br />http://nlp.cs.nyu.edu/info-extr/<br />Summary: This system combines a web crawler (which searches for reports of outbreaks on a ... engine, and a data base browser to examine the extracted events (Proteus Project ...<br />Title: Proteus Project: Information Extraction<br />$VAR1 = [];</p><p>&nbsp;</p><p>So, that\'s what it does.  But a problem it was having is it only looks one layer deep for tar.gz and zip files and the like.  I wanted it to look further, but that would have been bandwidth and time expensive, searching all the links.  So what I did was to download a dataset from: </p><p>http://cybermetrics.wlv.ac.uk/database</p><p>which contained a large dataset of web links.  I then rated the last dir or file of the url that linked to a set of files for how many \"desireable\" files were there.</p><p>i.e.  in the above url it would be \"database\"</p><p>17.0028327481393        jars    40      9       211<br />14.3298883847943        download.html   116     168     498<br />12.9734278116825        edit.html       67      33      67<br />10.8830909612802        patches 8       2       368<br />10.4918735220202        Debug   38      16      42<br />10.0194507146122        golem   29      6       30<br />8.97441185481296        canaries13      20      0       20 </p><p>So I added that and now it can speculatively search 1 extra ply.  It has already helped to find some new software.</p><p>&nbsp;</p><p>Secondly, I went ahead and added the ability to search within pdf and other documents and extract the URLs from them, so that research papers (which often link to systems, or at least name them) can be searched as well.  This is a separate script that will integrate eventually with radar.</p><p>/var/lib/myfrdcsa/codebases/internal/radar/scripts/get-software-by-searching-publications.pl</p><p>&nbsp;</p><p>Additionally, in unrelated news, I worked on better calendar integration.  Instead of having to enter the details manually, I wish to be able to simply highlight some text that contains the event details and have it extract the information.  So I searched around for my old event dataset which turned out to be called sa-tagged.  It only had 48 or so items IIRC.  Not a lot to develop a good model.  Recalling a conversation with Dayne that he would like to go with CRF (conditional random field) learners in the resume analysis domain, when I downloaded mallet which I assume McCallum used on sa-tagged, I noticed it had CRF so I decided to use that.  Setting it up is not a completely trivial, I have to write the feature processor.  I know how to do everything, except add additional linguistic features - for that I am looking elsewhere - perhaps to Stanford\'s NE recognizer since it has one - if I can figure out how to access it - should be easy but need to look first.  Getting tired now.  So, if anyone is interested, tomorrow, I will hold a seminar on doing this.  That\'s it for now.  Happy hacking! </p>',62,13,0,'2015-11-11 18:00:00',0),(14,'A Solution to Weak Weak Artificial Intelligence','A_Solution_to_Weak_Weak_Artificial_Intelligence','<p>Artificial Intelligence may be controversial, but the limitations of computers have been spelled out explicitly for at least 70 years, if not thousands.&lt;p&gt;<br /><br />So in what sense do we take the term Artificial Intelligence? Well, we do not take it in the frame of reference that the reader may be accustomed to. The fact is that we interpret it very differently than is standardly interpretted. I am not saying this to distinguish myself, but only because if I didn\'t I would be blamed later because they would say, \"Oh, well that\'s not what everybody thinks is Artificial Intelligence\".<br /><br />But so far in this paper we haven\'t defined it with even one axiom. And yet, I still cannot be sure that anyone reading this really understands that, as far as we\'ve defined it thus far in this paper, it is not conclusively disprovable that Artificial Intelligence is not Mineral Spirits, that it is not a position in government, or that it is not a shade of blue.<br /><br />Let\'s, for starter\'s look at a few hypothetical definitions of AI.<br /><br />HYPO1) AI is a form of cat wrench.<br /><br />Well, what does this mean. What is a \"cat wrench\"? Well obviously the syntactic term \"cat wrench\" appears to be something in our taxonomy. It says \'AI \"is a form of\"\' seems to imply that the class of \"cat wrench\" subsumes \"AI\". But obviously none of these has been defined sufficiently.<br /><br />Let us also switch now from refering to \"AI\" but let us restrict it further to \"weak weak AI\".<br /><br />HYPO2) \"WWAI\" is a major geopolitical event in the first part of the 20th century.<br /><br />All I am doing is trying to make the point here that any term is subject to its definitions. I am trying to clear the previously held definitions of WWAI for numerous reasons. It is because our present definition of WWAI is motivated by a set of assumptions which may be taken without much hesitation, and then a string of formal inferences which proves conclusively that \"Any computing device whatsoever is a WWAI.\"<br /><br />A first objection is that this definition is overly broad. But realize that we are operating in a &lt;b&gt;more Socratic way than most people are accustomed to in daily usage of language&lt;b&gt;. It is altogether fitting and proper that we use our language differently in this case. IF we were not to make some different usage out of the language, we would have difficulty in making as much progress.<br /><br />Socraties is a model of how we ought to look at things. Because Socraties said, and this is my point in everything I have said up to now, that before we ask questions about a thing, we must ask the question \"what is the essence of this thing?\" So, that is what I am asking, what is the essence of \"WWAI\". I can be relatively sure that since, obviously, \"WWAI\" is not a term that anyone has used before, that no one knows anything about it, and therefore must be willing to take note of my definitions.<br /><br />Socraties would often take a conventional interpretation, and apply a sequence of inferences, known as a proof, to disprove that conventional interpretation.<br /><br />So without further adieu I shall spell out all the assumptions and the inference which leads to WWAI.<br /><br />Assumption 1:</p><p>(End of original article, obviously, this article was never completed). </p>',62,14,0,'2015-11-11 18:00:00',0),(15,'Motivation for Our Programme of Software Conglomeration','Motivation_for_Our_Programme_of_Software_Conglomeration','Let us give a rough outline of the logic behind this decision.<br /><br />First is that one must have a vision, that is an understanding of a goal, such as artificial intelligence.<br /><br />In my case, I could clearly see situations, usually social, in which I could imagine a computer performing a very complex set of tasks to arrive at some socially productive answers.<br /><br />Unlike people untrained in computers and logic, I could not specifically disprove that a computer could do this. Besides, the risk of failure to achieve this goal is very large. &lt;&lt;&lt;opportunity cost&gt;&gt;&gt;<br /><br />So I began to try to create a system. Like many who first start out, I fell into basic traps. I thought that I could write metaprograms, programs that wrote other programs which were more capable than themselves. Of course this ignores fundamental computer science concepts. It is based off practical work with computers, not theoretical. Of course, the lisp language is specifically crafted for this kind of metaprogramming, and it is a very basic possibility for automata to rewrite themselves, so like most beginner AI ideas they are hardly novel. So the idea is actually quite good, but it is not complete, it is only a fragment. It is necessary, but not sufficient.<br /><br />In fact, most beginner AI ideas sound quite fuuny to people who know what has been developed. A beginner AI researcher will come along and say - we can have programs that map out all the words that people use and make a meaning for it (a dictionary?). Or maybe a more advanced suggestion - we could have mysql databases of available software - with all the dependencies recorded (apt-get?). So it is really quite funny listening to someone say basically - we could have round things that we could roll around on, as if the idea were new.<br /><br />There are many other basic traps that I fell into. Another interesting one involved trying to model systems from data. I thought that I could have a system that observed interactions and \"abducted\" models of them. Well, this is quite true and there are many good uses of this, what is called model-checking (although model checking usually works from specifications and not observations). But ultimately, what was most damaging was that I had completely ignored the issue of what I would make my models out of. I thought programs, and this is fine, but really what is necessary is the notion of an object language to be learned. Of course, since these ideas are not well defined, there are many related concepts which are categorized by them. It covers quite a broad range.<br /><br />So, the high point of my research came when I studied existing research extensively, which I had previously tried not to do for fear of confirmation bias. I am happy to say that I do not feel that I have been biased (any more than necessary) by my studies, but only that I came across results which tended to make my own notions more rigorous.<br /><br />Also, during this period of intense study, where I would attend graduate classes from 8 in the morning until 6 at night, and then read at night, I was really fulfilling my neurological needs as an Asperger. Although I didn\'t know it at the time, my obsessive need to collect every fact, which is similar to my obsessive need to look at every possible move on a chess board, was really a fulfillment of my needs.<br /><br />I made a few assumptions about my work on AI. First, without actually learning of the distinction between strong AI and weak AI, I realized that there were indeed two classes of AI, and that weak AI seems a prerequisite of strong AI. In fact I was relatively certain because strong AI would be capable of achieving weak AI on its own. So either way, weak AI would be developed.<br /><br />Weak AI means to me problems that are solved by existing mathematical and computational technologies - that is, all problems that are computable by classical computers.<br /><br />This begs this question, \"what is the class of problems that computer can solve\", and also this, \"can they solve all formalizable problems about their own behaviour\". In fact, my initial work centered on finding this program, but I did not know how complex this program would be.<br /><br />What tended to startle people in the earlier part of last century was that this program did not in fact exist. It had been called by various names in the past - the Entscheidungsproblem, the Hilbert program. Several people simultaneously realized that this program did not exist. This included Church, Turing, Godel, Zermelo, Russell, King, Wittenstein, (even Socrates). Even Von Neumann was startled at this fact, which, in retrospect, is entirely obvious.<br /><br />But this fact is not at all a \"negative\" result as people seem to claim. Indeed this fact presents the solution to us very clearly.<br /><br />That is, for any program, there exists another program which is larger and which can solve a strictly larger class of problems.<br /><br />So, based on this relatively simple analysis, I compared the efficiency of these ideas. Since it is known that the time complexity of solving problems, as well as the extent of computable problems, is strictly increased with certain additions to program length, it was rather obvious which additions would provide the greatest increases. These would be the software systems with the greatest capacity relative to other systems. They would not be systems that I wrote myself, but would be systems that other people, scores of other people, had written with lots of funding.<br /><br />That is, our operative thesis is that the systems capabilities are increased the most by collecting the best software that others have written. Since we do not know, ahead of time, which software is most useful, we collect all of it, and apply decision methods and ratings and tests to all software, and package applications ordered by ease of packaging and utility after being packaged.<br /><br />Many people have problems with the fact that we do not uniquely specify which problem we intend to solve. This is a characteristic requirement which Asperger\'s do not have. The fact is that we have proven the systems capabilities have increased. Furthermore, we simply make the claim that we can, transitively, solve every problem which the system we collected was designed to solve.<br /><br />But in practice there are very few attempts at collecting software. The reason for this is most people are motivated to solve a specific goal. But solving a particular problem is usually a waste of time. It forces a long and complicated search (naturally because the system is weaker proof theoretically than a larger system). Collecting software on the otherhand, in leiu of automatically solving more problems later, is very important. But in order to solve more problems, a certain minimal rate is needed to have a self sustaining reaction.<br /><br />That is why I implore you to help me find people willing to program packages for an indefinite period of time.<br /><br />The cost of failure are infinite stacks, and we have proposed a most reasonable objective. Furthermore, the lack of such similar practices indicates a certain novelty, which may be attached to the probably of finding a gifted Asperger.<br /><br />Of course, there is a limit to how much software we can collect. But we are far from that limit - and once we hit it, our situation will be quite different. We will have shared systems that are in many respects extremely capable. Until we collect this software, we realize, like Godel\'s S and S\', that there are infinitely classes of theorems that we cannot prove with our systems.<br /><br />Einstein, Godel, Newton - all the greats had Asperger\'s. It is ironic and unfortunate that by virtue of the very skills I have, and the skills I apparently don\'t have, the skills I have are ridiculed, and the skills I don\'t have are taken as an excuse to not send me to a school where I belong. Everything we see is a product of this misappropriation of talent. In highschool I worked at Fermilab as an experimental physicist, with a classmate. She went to Princeton as a physicist. But everyone thought I was lazy, because people didn\'t realize that my lack of executive skills, such as time management, allowed me to see things that other people don\'t. Now, daily my work, which is clearly of historical importance, is forsaken by those who claim to love me. Let actions speak louder than words. Let the truth out. Please stop murdering the truth. You are risking the entire stability of reality.<br /><br />If somebody writes a 30 million dollar program and gives it away for free, and you don\'t have it, your genetic material will spontaneously mutate into that of an ameoba. That\'s like rejecting someone\'s offer to give you a space shuttle, on the grounds that you can\'t imagine why in the world you would need it. Moreover if you repeat this 5000 times, you are in trouble. No, I agree with your assessment, why not write it yourself? After all, there\'s nothing that 1000000 postdoctorate genius programmers could do in thirty years that you couldn\'t do in a week with C++, right?<br />',62,15,0,'2015-11-11 18:00:00',0),(16,'Generic Considerations Associated with the Formation of Software Systems','Generic_Considerations_Associated_with_the_Formation_of_Software_Systems','In deciding to make packages for Debian, we are relying on the following maxim:<br /><br />Genus nunquam peruit - Generic things do not perish<br /><br />There are already around 22,000 Debian packages. This principle is stated to identify the naive tendency to complexify through nonstandard additions to a system. The result is a nonstandard system which cannot be easily recreated, which slighty increases the complexity at a cost of great disorder. We are looking for highly complex, highly ordered systems.<br /><br />The advocated method is to cleanly identify a system and package it in a generic way. That is, to make additions to the set of applications not modifications to the operating system.<br /><br />The value of this method is that we can therefore keep things very clean, that we conform to de facto et jour standards (ok, ok, de facto and de jour), that interfaces are implemented wholly and cleanly. There are other important properties of a system in addition to complexity, such as completeness, soundness, consistency, etc.<br /><br />So, imagine that we suppose a measure of a certain property, such as soundness. Let us further imagine that the range is a lattice wrt the ordering of cleanliness',62,16,0,'2015-11-11 18:00:00',0),(17,'\"Untangling the Truth\" Analysis','_Untangling_the_Truth__Analysis','A novel, simple and effective method of untangling the truth from lies we are told that is easy enough for any intellectual to use.<br /><br />Imagine that  you have  many ropes in  a hopelessly tangled  mess.  Is this not the truth about truth and lies we are told?<br /><br />How does one untangle this complicated mess?<br /><br />LOGICAL FALLACIES<br /><br />The first step is that one must be able to recognize when a fallacy is being employed  to support an  argument.  Since the truth  consists in knowing  which assertions  are correct  and which  aren\'t,  the proper methods  of  proving  assertions  are necessary.   If  someone  argues unfairly - i.e. invokes a fallacy to support a step of their argument, you must be  able to confute them.  It follows that  one must know how to recognize  a fallacy.  So study  these.  By our  analogy, each time you recognize  a fallacy,  you have succeeded  in undoing part  of the knot.<br /><br />GO<br /><br />Believe it  or not,  the game  of Go is  necessary to  our theoretical analysis.  Why  is this the case?  Go  is a game in  which two players fight for control of territory.  There is a large conceptual framework and enormous literature on  which techniques work.  The major concepts in Go are cutting and connecting.  You can strengthen weaker groups of stones by connecting  to stronger groups, and you  can weaken them and sometimes kill them by cutting them off from stronger groups.<br /><br />These two tools, and indeed, many  tools in Go, are very useful to the propagandaist.  Think  of an  argument as a  group of stones.   If you don\'t wish a person to believe that what this argument proves is true, and  in this  case that  would be  any of  the  premises, intermediate assertions,  and  conclusions  of  the  argument,  you  can  kill  the argument.  You can do this but  cutting it at the premises, cutting it at an  intermediate step,  or cutting at  the conclusion.   Of course, logical fallacies  are what one  cuts otherwise valid  arguments with. So, the propagandist employs fallacies  as his stones, and the student of  truth employs  truths as  his  stones, with  assertions being  the points of  play and the rules of  inference as the edges  of the board graph.  If  the game is to  fight over other  peoples\' territory, i.e. mindshare, they can also employ fallacies.<br /><br />There are  many properties of  the game of  Go that also hold  true of propaganda techniques.   It follows that many of  the conceptual tools from Go have  a either a direct analog or can  be modified to function in counterpropaganda applications. <br /><br />PUTTING IT ALL TOGETHER<br /><br />So you have  two areas to study - Logical Fallacies  and Go.  It would also help to ensure familiarity  with formal logic, topology and graph theory, as  this would clarify the true  properties wrt argumentation. Then,  by identifying  where stones  have been  placed to  cut certain arguments, you can begin to  gain control of larger territories of the truth.<br /><br />EXERCISES<br /><br />Develop a formal theory of  the basic moves behind employing fallacies in   propaganda/counter-propaganda  applications.   Write   a  generic graph-based  graphical  visualizer  for  these  moves  which  displays verticies/assertions  and  edges/rules-of-inference.   Develop an  NLP program  using  any variety  of  methods for  recognizing/categorizing logical fallacies with a high degree of accuracy.  Process texts using this tool  and employ shape  analysis from Go to  visualize mindshare. From  this  visualization -  assess  the  positional attributes  using transformed Go positional analysis techniques to develop an assessment criteria for counter-propaganda strategies.  Develop a feedback system that measures  the real-world effectiveness of  these strategies.  Use these techniques to convince others to  work with you in your fight to know the truth - a necessary condition for (true) freedom.',62,17,0,'2015-11-11 18:00:00',0),(18,'Increased FRDCSA Involvement','Increased_FRDCSA_Involvement','Recently, with the re-establishment of the POSI group, more people have been involved to some degree with the FRDCSA than ever before.  The use of the FRDCSA core systems in POSI, while increasing the capabilities of the POSI services substantially, also contribute back to the FRDCSA as people become interested in extending the software.',62,18,0,'2015-11-11 18:00:00',0),(19,'The FRDCSA Community','The_FRDCSA_Community','<p><strong>Got a question? </strong>Many people are familiar with components of the FRDCSA because of its use in the POSI group.  Therefore the #posi channel is a great resource for both new and experienced users. </p><p><strong>Do you want to contribute?</strong></p><p>If you think the mission of the FRDCSA is worthwhile, regardless of your background - you can help!  All sorts of people are needed, and we will help train you if you are interested.  Additionally, there are literally hundreds of interesting projects - or start your own!</p><p><strong>Note: </strong> 	    My goal is to help enable you with your own projects, and to 	    work together where we have similar interests. 	  </p> <ul><li>Submit news about FRDCSA.</li><li>Report bugs and request features in. </li></ul>           <p> These are just a few ways you can contribute. See <a href=\"http://frdcsa.org/collab/doc/book1.htm\">Collaboration</a> for many more ways.</p>',62,19,0,'2015-11-11 18:00:00',0),(20,'Oct 23 2008 Update','Oct_23_2008_Update','<p>Three new useful AI systems have been successfully configured and tested:</p><ul><li>Sentiment Analysis using OpinionFinder-1.5</li><li>Query Expansion using LucQE</li><li>Natural Language to Logic Conversion using ResearchCyc</li></ul><p>Unfortunately, I believe only LucQE is free software.  However, having these abilities will improve the analytic capabilities of the FRDCSA to help with the mission of promoting the use of free software.  For instance, the Sentiment Analysis system can determine who is expressing bad opinions about us, allowing us to automatically avenge them.  Lol.  Indeed it unfortunately could be used for that purpose.  However, it is intended to be used for MPQA (Multiple Perspective Question Answering), in order to get a better idea of subjective statements. </p><p>In other news, I am searching for research interest ontologies, in order to have an idea what to search for in terms of new systems.</p><p>&nbsp;</p>',62,20,0,'2015-11-11 18:00:00',0),(21,'Some Common Misconceptions Refuted','Some_Common_Misconceptions_Refuted','This page exists to refute the frequent claim that the FRDCSA project does not finish or complete anything.<br /><br />This would be an example of the classic \"MOVING GOALPOST FALLACY\" (one of the many in ReasonBases database of fallacies.) It is also an inherent accusation levied against Open Systems and transfinite systems. These are systems which are designed to grow. That is not to say that they are not complete. There are core feature sets which have been completed. An interesting fact that probably contributes to this impression is that the system for recording which features have been completed is itself incomplete, since it depends on a great number of important subtasks. It would indeed be silly to think that simply because the system that represents formally which requirements have been finished was itself incomplete, that none of the requirements had been completed.<br /><br />And if you wish to claim that the entire project is incomplete, well then you\'d be correct. This is because of the very nature of the problem - we are working on practical solutions to mathematically incomplete problems! So no solution can exist.<br /><br />Furthermore, because I don\'t have time at this point to list the systems which have been completed to your satisfaction. Below I\'ve included the output of a program that might give you some idea of which systems have been written.<br /><br />From now on it will be policy to blacklist anyone who claims I am not finishing anything as it shows that they not only cannot suspend judgement nor judge soundly what has been accomplished. They will be added to Audience\'s blacklist.<br />',62,21,0,'2015-11-11 18:00:00',0),(22,'FRDCSA requirements','FRDCSA_requirements','<p>Currently the FRDCSA is still in the process of being redistributed.  (You can help with that).  The system is large and has many dependencies, so packaging it has taken a long time.  Additionally, there is material unsuitable for redistribution (such as software that is not licensed for redistribution) which needs to be removed.</p><p>Currently, there are two ways to obtain a copy of the FRDCSA, but they are not yet open to the public.  The first is through git, and the second through the debian packages made by the Task1 system.</p><p>At present, you need a Debian GNU/Linux system.</p><a href=\"http://forum.joomla.org\" title=\"The Joomla! Community Forums\"></a>',62,22,0,'2015-11-11 18:00:00',0),(23,'Technical Motivation','Technical_Motivation','<h1>FRDCSA Technical Motivation</h1> <p> While the technical reference is still being written, please read the following two sources: Wikipedia <a href=\"http://en.wikipedia.org/wiki/Algorithmic_information_theory\"> article </a> on Algorithmic Information Theory , and Chaitin\'s <a href=\"http://www.umcs.maine.edu/%7Echaitin/acm74.pdf\">paper</a>. It is very important that one understand this paper.  If one understands the major concepts in this paper, then there are only a few more concepts required to completely understand why we need to package software. </p> <p> Specifically, note  the section  which states: \"The  approach of this paper,  in contrast, is  to measure the  power of a  set of axioms, to  measure the information that it  contains.  We shall see that there are circumstances in which one only gets out of a set of axioms  what one puts in, and in which  it is possible to reason  in  the  following  manner.  <em>If a  set  of  theorems constitutes t bits of information,  and a set of axioms contains less than t bits of information, then it is impossible to deduce these theorems from these axioms.</em>\" </p> <p> Simply  replace   \"theorems\"  with  \"problems\",   \"axioms\"  with \"programs\", and \"deduce\" with  \"solve\" to understand the general necessity of having more software. </p> <p> A.K.A.:  <em>If  a  set   of  problems  constitutes  t  bits  of information, and a set of  programs contains less than t bits of information, then it is  impossible to solve these problems from these programs.</em>\" </p> <p> So, increasing the information that our set of programs contains is necessary to solve increasingly complex problems.  The FRDCSA thesis held by members of the FRDCSA says <strong>  <!-- given the extent of available software, and the novelty and correctness  of  the  logical  part of  this  thesis,  packaging software en masse  is a necessary part of  any practical attempt of ours to create  increasingly capable problem solving systems! -->  given the extent of free  software, packaging this software is a necessary step of any practical attempt by our group to increase our solution space.  </strong>  It is not sufficient,  therefore we are writing numerous systems to help us glue the functionality of the software together where necessary.</p><p>&nbsp;</p><img src=\"http://frdcsa.onshore.net/frdcsa/introduction/sys.jpg\" border=\"0\" /> <p>  <!--We realization that  we currently do not  always understand exactly what  particular purposes  a  system might  serve.  However,  by packaging, studying and applying  a system we have allocated its capabilities.   These  capabilities  are precisely  those  which others found  to be  of such great  use that they  would develop them themselves.  We believe that our problems and solutions are not  independent.--> </p> <p>  Although it represents almost 5 years of research, the FRDCSA is still in its beginning phases.  Check back frequently for additional functionality.  Help is sincerely needed in getting all these packages made.  Packages are necessary in order to quickly and conveniently access the capabilities of software systems.  If you would like to help make packages or join our group, please send mail to andrewd@onshore.com.  </p> <h1>Further Reading</h1> <p> The  following reading  has been  very  useful in  giving us  an understanding of how to go about solving problems. </p><ul><li>   <a href=\"http://frdcsa.onshore.net/frdcsa/introduction/writeup.txt\">writeup.txt</a>: The closest thing to a paper   I\'ve written.   </li><li>   <a href=\"http://www.andrew.cmu.edu/%7Ecebrown/notes/ebbinghaus.html\">   Introduction  to Mathematical  Logic</a>:  Ebbinghaus, Flum.   </li><li>The Undecidable:    Davis: 1965.   Basic    Papers    on   Undecidable   Propositions,  Unsolvable  Problems  and  Computable  Functions. <br />   Specifically read 1934 development of incompleteness theorems,   and Turing\'s paper <a href=\"http://www.turingarchive.org/browse.php/B/15\">   Systems of Logic Based on Ordinals</a>   <!--  <li>Transfinite Recursive Progressions of Axiomatic Theories:   Feferman, S: 1962.  (I have not yet read this but it would appear to contain   the idea.)-->   </li><li><a href=\"http://www.umcs.maine.edu/%7Echaitin/acm74.pdf\">   Information-Theoretic Limitations of Formal Systems</a>:   Chaitin, G.: 1974.   </li><li><a href=\"http://math.ucsd.edu/%7Esbuss/ResearchWeb/godelone/\">   On Goedel\'s theorems on lengths of proofs</a>:   Buss, S. R.: 1994   </li><li><a href=\"http://www.debian.org/devel/\">Debian Developers\'   Corner</a> </li></ul>   <address><a href=\"mailto:andrewdo@frdcsa.org\">Andrew J. Dougherty</a></address> <!-- Created: Sun Feb  1 18:20:10 EST 2004 --> <!-- hhmts start -->Last modified: Wed Jun  7 10:27:17 CDT 2006',62,23,0,'2015-11-11 18:00:00',0),(24,'FRDCSA Facts','FRDCSA_Facts','<p>Here are some interesting facts about Joomla!</p><ul><li>Over 600 (non-CPAN) Perl5 modules comprise the internal codebases</li><li><span>400 unofficial Debian GNU/Linux packages</span></li></ul>',62,24,0,'2015-11-11 18:00:00',0),(25,'Support and Documentation','Support_and_Documentation','<h1>Support </h1><p>Support for the FRDCSA can be obtained on the FRDCSA channel, or by contacting andrewdo@frdcsa.org.</p><h1>Documentation </h1>Documentation is under development.<br /><h1>Want to help? </h1><p>If you want to help in the documentation project for FRDCSA then please contact us by emai. </p>',62,25,0,'2015-11-11 18:00:00',0),(26,'FRDCSA Overview','FRDCSA_Overview','<div align=\"left\"><strong>Want access to these systems?  Help me release them by signing up to the mailinglist...</strong><p>     The <a href=\"http://frdcsa.onshore.net/frdcsa\">FRDCSA</a> project is an advanced Artificial Intelligence created by automatically scouring the web for advanced AI systems, retrieving and packaging them for various operating systems, and finally building upon these packages. Incidentally, many systems not considered to be AI are also necessary as part of the operating system infrastructure. </p>   <p> FRDCSA was originally two projects, FRD and CSA. FRD stands for Formalized Research Database. It was created as an attempt to fuze all publicly available mathematical knowledge into one store, as this has many practical and theoretical benefits. CSA stands for Cluster, Study and Apply, and is a similar effort to conglomerate useful software. The projects merged when it became apparent that proof systems and programs are equivalent (Curry-Howard Isomorphism). </p>   <p> In attempting to develop practical artificial intelligence systems, one methodology is the symbolic systems approach. When I encountered Goedel\'s incompleteness theorem, rather than perceive it as the bane of symbolic AI, I took it to be the cornerstone. It yields us important information about theorem provers, namely, that for any given proof system, there exists a larger, more powerful system, and that proof systems under a certain size will find it impossible to solve certain problems. The advantage in knowing this is that it can act as a heuristic for the selection of increasingly capable proof systems and motivates the strategy of software conglomeration, which evidently was not taken to the fullest advantage.</p></div><p><strong>What is  the FRDCSA</strong>?</p><p> \"FRDCSA\" stands for \"Formalized Research Database: Cluster, Study and Apply\".</p><p>  <strong>Cluster</strong>: The FRDCSA is a large collection of software (codebases) that is actively maintained and expanded using a variety of methods (see <a href=\"http://frdcsa.onshore.net/frdcsa/internal/radar\"> RADAR Internal Codebase </a>).</p><p>  <strong>Study</strong>: Depending on licensing, packages or installers are semi-automatically created for each codebase.  (see <a href=\"http://frdcsa.onshore.net/frdcsa/internal/packager\"> Packager Internal Codebase </a> )</p><p>  <strong>Apply</strong>:  Packaged  systems  are  then  used  to  solve  existing problems.  (see <a href=\"http://frdcsa.onshore.net/frdcsa/internal/architect\"> Architect Internal Codebase </a>)</p><p>  The archive can be accessed either manually, or preferably, if you have \"apt\", by adding the following line to the /etc/apt/sources.list file:</p>  <pre>deb http://frdcsa.onshore.net/debian/ unstable/</pre>',62,26,0,'2015-11-11 18:00:00',0),(27,'FRDCSA Features','FRDCSA_Features','<h4>Page under construction.<br /> </h4><h4><font color=\"#ff6600\">FRDCSA  features:</font></h4> <ul><li>Robotic book scanner</li><li>Meal planner</li><li>Point of Sale system</li><li>Over 200 Debian packages</li><li>Over 90 applications in various stages of completion</li><li>Bus planner</li><li>Temporal planner with interactive execution monitor</li></ul>',62,27,0,'2015-11-11 18:00:00',0),(28,'AI Overview','AI_Overview','I am tired of those who claim that good is subjective. I am also ntired of those who debate the practical importance of AI, questioning whether there exists a recursive function that is AI-complete.<br /><br />People claim that AI cannot be created, because the human mind is infinite. What do they mean infinite? Limitless? Then, obviously there is no reason they couldn\'t create AI.<br /><br />People say that they are not sure whether human behaviour can be represented in terms of recursive functions. They wonder whether recursive functions are sufficient and AI-complete, and yet every piece of human reasoning yet invented has been.<br /><br />But I won\'t test my arguments against them, I will propose solutions.<br /><br />There are no smart people. There are people who have more than others, there are the rich and the poor. But they are equally unable to make adequate use of their resources. To do so requires systematic intelligence.<br /><br />Fortunately, the computer provides us with systematic intelligence. Because expertise may now be copied instantly, there is no reason why anyone should go without the benefit of expert knowledge at all times.<br /><br />For instance, everyone\'s basic intelligence needs ought to be met, by having a uniform Social Security System.<br /><br />Debian Social Security System<br /><br />The idea of the Debian Social Security System is that expertise may now be copied instantly, and there is no reason that someone should be bereft of basic knowledge that could be taught to them by a computer.<br /><br />As such, a general purpose system which starts from ground up, including meal planning,<br /><br />Currently, there is no software available in Debian which provides for meal planning, or even realtime life planning in general.<br /><br />I argue that having these abilities given to them will not make the person less intelligent. Rather, I think that intelligence and motivation can be instructed. The reason I believe this is that people can be taught with both negative reinforcement, such as life often treats us with, but also positive reinforcement. There is no reason for making mistakes if they don\'t have to be made.<br /><br />My worldview is basically that the universe is a problem, and is defective, for instance, thermodynamics, etc, are all defective. My religous view is that the afterlife is something which is in actually accomplished by our race as transform existing reality into an increasingly heavenlike world, until we have replaced the earth with heaven.<br />',62,28,0,'2015-11-11 18:00:00',0),(29,'Artificial Intelligence','Artificial_Intelligence','The AI I work on has nothing to do with human intelligence, or trying to make a sentient being. If you make that assumption about me, that\'s like hearing that someone is a religious person and then chastising them for believing in Buddha (when in fact they might be Christian). There are many aspects to the field of AI. Probably the best way for you to think of this is that I work on IA, or intelligent agents. These are programs which are capable of solving problems that are considered useful by people.<br /><br />AI concerns itself with minimizing unnecessary psychological suffering due to avoidable accidents. We use techniques from logic, the same techniques that, for instance, make optimal chess playing programs, etc, and treat the world as a game and try to win the game, by mathematical optimizations and proofs that bad things don\'t happen. You can do this, you can make certain guarantees that certain failures don\'t happen for reasons that you are in control of - of course no one can yet control certain things, but at least you do the best you know how to do with what you have all the time. For instance, you won\'t make bad moves at chess, you won\'t not know the definition of a certain word, etc.<br /><br />Anyone who thinks AI is about taking control away from people doesn\'t really realize that a person and an AI together are still going to face difficult problems, it will make us better able to avoid certain common, unnecessary mistakes, and to help us mount higher challenges by providing rigour in situations where it wasn\'t previously available. It will not make us lazier, it will in fact make us harder working because we won\'t be burned and worn out and feel helpless towards mistakes we know ought not happen.<br /><br />People are good at learning complex systems but sacrifice perfect memory in exchange for other skills suited to learning complex systems, but some problems require specialized solutions, and this solution is the computer.<br /><br />We can look at a world with AI in the same way we look at the current world, and we can introduce AI in a way such that no requirements any person may have are rendered invalid by the AI. That is the goal, actually, to satisfy everyone\'s requirements. We model requirements in the usual logical way.<br /><br />A requirement is something that a person could express in English, and is represented by association to the intended semantics of the statement (as opposed to misreads of the requirement). The goal then is for the system to make as many of these requirements simulataneously true based on its laws (the requirements of all people) and its algorithm.<br /><br />algorithm n : a precise rule (or set of rules) specifying how to solve some problem [syn: {algorithmic rule}, {algorithmic program}]<br /><br />When I say that AI solves problems, it is in the sense of problems of logic. However, many real world problems may be solved by reducing them to problems of logic and the interpretting the solution.<br /><br />Let me describe to you in perhaps the clearest way possible the goal of what I work on.<br /><br />I realize that EVERY FAILED DEDUCTION LEADS TO FUTURE ACCIDENTS.<br /><br />Let me describe an accident. This is by no means pleasant. So if the accident I am about to describe were avoidable, it would make the world more pleasant.<br /><br />This accident involves a young boy being hit by a train. I know that what I work on would be capable of preventing his death and the consequent psychological suffering of all that knew him.<br /><br />While we cannot protect one hundred percent of people against one hundred percent of the hazards and vissicitudes of life, we can make relative improvements. We can in a formal sense make 100% safety in restricted systems, and of course the goal is to grow that safety to larger and larger systems. It is exactly the consistency of computers, which don\'t make them rigid thinkers, but which make them conditional and highly reliable system, that allows computers to solve with 100% completeness subclasses of existing problems. That is, prevent whole categories of accidents.<br /><br />The accident involving the boy follows a template that I have seen multiple times in videos of accidents, and even experienced myself. In a different video, the exact same failure situation leads to the death of a gazelle.<br /><br />This failure situation is one that I am aware now and which to some extent motivates unswerving commitment to the completion of my task.<br /><br />Since it will be easier to describe the gazelle scenario, I will start with that. The typical feature is that it is two animals, two deer in this case, and a threat which is perceived by one of the animals, which steps clear without thinking to alert the other. In this case, the deer are drinking from a water hole. The first deer is blocking the view of the second deer of the water hole. The first deer sees something approaching at it (an alligator), and quietly turns around and leaves the water. From the point of view of the second dear, the movement of the first deer conceals the movement of the alligator, which proceeds to jump up and trap and kill the second deer.<br /><br />I am very offended by the existence of such scenarios in nature. I think they should be stopped. I understand methods that would prevent this and a great many other classes of accidents.<br /><br />Now we will describe the death of the boy, which parallels closely the death of the deer. Two young boys are walking towards a train track. There is a stationary train on the track which conceals an oncoming train. A train horn is blowing, and the boys fatally presume it is the stationary train. From the point of view of the camera, as the boys near the tracks we see that the second train moving at about 80 MPH is the real source of the horn sound. The boys are walking side by side, let us call the first boy the boy who is closer to the train. The first boy blocks the view of the second boy. When the train is now within about 80 feet the first boy perceives it and stops on the very edge of track. He turns around and steps back automatically (clearly is not thinking at all about the second boy), barely missing the train. The second boy is now about 4 feet in front of the first boy, and his head may be seen to hesitate for about a 6th of second, an short moment of psychological confusion before his hopelessly lost position is impacted by the approaching train. Needless to say the child\'s body is instantly accelerated and rockets about three hundred feet in a second actually hitting the cameraman at a velocity of roughly 75 MPH.<br /><br />This death may have been prevented as a matter of logical completeness. All that is needing is a facility to alert the child to avoid that position. A deduction was necessary which would have triggered a communication that the child should stop, we in advance of the precipitious accident. I understand how to implement this, and how to set up the correspondances between the mind and the system.<br /><br />It is in this spirit that I pursue the development of AI, a system which I know can prevent large classes of accidents. It is sufficient to prevent an accident to have a proof that it will not happen. Here we take proof in the formal mathematical sense. By establishing correspondances between the physical world and the simulated computer world, simulation occuring with knowledge based systems, etc, (which is more akin to a very precise, somewhat accurate human mental model than to say a simple physics simulation), correspondences that take place through input output devices like mind to machine interfaces, cameras, etc., we will be able to eliminate large ammounts of psychological suffering as the result of accidents that are preventable by these systems.<br /><br />To give a simple account of a simple implementation, suppose that we have image understanding routines. &lt;Show video of VSAM&gt; The camera agent, an IA (intelligent agent) with image understanding intelligent software, would be creating and forwarding live information to an AI, perhaps in the camera, perhaps at a nearby station, across a wireless adhoc network, etc. The information would be complex, but in the spirit of the existing technology, would look about equal to a length novel worth of statements of the following form.<br /><br />(#$approaching #$OurPoorFriendForWhomWeGrieve #$railtrack-39423) (#$approaching #$OurUnfortunateSurvivor #$railtrack-39423) (#$emittingSound #$train-32488)<br /><br />Of course, there would be optimizations, etc, such as dialogs between the camera and the IA.<br /><br />Now, when the camera reports the approaching train (or even before, there might be a system which is devoted to general purpose collision avoidance, which has already contacted the IA with information of the approaching train), the IA makes the inference that there is<br /><br />(#$likelyEvent (#$and (#$dies OurPoorFriendForWhomWeGrieve) (#$collisionWith #$train-32488)))<br /><br />I.E. It is able to prove this. &lt;Show cyc knowledge base&gt;. In which case the IA contacts the agent present with the child. The agent advises the child to stop, 100 feet in advance of the approaching train. This child, if contacted in advance, would not have died.<br /><br />Here we have shown how this child\'s death may have been prevented using existing technology. Now, people might make the claim that this is a pathological singular point and that in reality we cannot prevent such things in all cases. Their argument is overly general and, for what?! The fact is that it is both obviously highly important to protect people from accidents, and it is also not a singular point, it is the rigour and completeness of the search procedures of logic that make this possible, and it does not rely on serendipity. It cannot prove everything, but it could have saved the lives of everyone I have personally known who has died, and it can do much more than that.<br /><br />I am motivated on account of the horrible experience of the similar way in which my beloved sister died and an intuitive understanding of the underlying technology to pursue without hesitation or disruption the development of this technology, and I sincerely hope that people will join me in this effort. (Cruelly, she alone would have supported my work unconditionally.) I have obtained what I feel is the main necessary result, that we may consider for the purposes of our system the world as a large set of problems, which need to be decided, but for any program offered as a solution, there are always much larger fragments of the problems that are not solvable by that program. Therefore I believe it to be the case that by collecting and distributing complex and intelligent software via the Debian GNU/Linux system, we will be rapidly reducing the number of unsolvable problems of logic, which when they remain unsolved, are exactly the cause of every accident in the world and a majority of psychological suffering.<br />',62,29,0,'2015-11-11 18:00:00',0),(30,'FRDCSA License','FRDCSA_License','The FRDCSA is currently licensed under GPLv3.  However, we are uncomfortable with its use in unethical ways, such as in military systems or in certain corporate applications.  While under the GPLv3 we cannot discriminate against its use in such places, we can and do however strongly censure its use in such applications.',62,30,0,'2015-11-11 18:00:00',0),(31,'Arguments in Support of AI Research','Arguments_in_Support_of_AI_Research','What argument do you have for not supporting my research into AI?<br /><br />My research into AI is aimed to reduce psychological suffering. It has nothing to do with human intelligence actual or perceived. It merely relates to the solving of problems that we know the solution to. It rests on no unproven technology. It in fact utilizes existing technology to collect it together to improve the quality of the deductions the system is capable of making. These deductions are aimed at prevent catastrophes and accidents that cause unnecessary psychological suffering. It is my understanding that this is what Jesus would want us to do, it in no way usurps the power of God to decide men\'s fates, but is instead mandated by our call to act justly and to treat each other with respect.<br /><br />So, basically the only reason that no one assists the development of AI is two reasons, they have no interest or purpose in it, and secondly because of historical precident - no one ever has.<br /><br />I think every person has an interest and a purpose in anything that offers a way to reduce psychological suffering of people. Furthermore, since AI has been so long neglected and even harmed by the actions of most people who have heard about it, it makes sense to constitute an effort to restore it so that it may succeed in its purpose.<br /><br />As to historical precident - the main reason there are objections to AI are one, no one believes that it works because they are full of prejudices and are incapable of accepting or deviating from their position, and secondly because of the manner in which I advocated AI.<br /><br />Now clearly the manner in which I advocated AI was the manner in which any person devoid of social sense would go about advocating a matter of supreme importance. I tried to say how important it was and people didn\'t listen to me on account of that. My blood boils and I have no idea what else I can do - this is really not fun at all.<br /><br />To assist AI, one does not even need to touch a computer! By assisting me you will no doubt assist AI.<br /><br />Is it really fair for me to ask for your help? I believe it is, and for this reason - there are more than one forms of capital that may be used in assistance. I possess the capital of a background in computer systems and solutions to problems of this sort, but I do not possess the capital of financial resources. Now, should everyone be required to earn financial capital as proof that their ideas work? If so, there would be no such thing as investment in the world, and we need to invest in our futures. I possess the capital of solutions, whereas some of you might possess financial and other capital. Please use it and don\'t be a squatter.<br /><br />I have come to ask whether anyone would be so inclined as to assist us in getting this project started.<br /><br />People ask me for solid proof that AI works. They said, why don\'t you make something like the internet, to prove to people that it works.<br /><br />Of course if I ever alledged that I would make the internet I would be still further ridiculed. Ignoring this, just what exactly do you think a massive network of computers with petabytes of knowledge instant queryable and accessible throughout the world is? Is it a Quesenark? The internet is proof of AI. This is a classical problem of AI - that once we implement a system that replaces or even extends some human capability, it is contended that it is not really AI. For instance, with chess programs, people say, that is not AI - that\'s only Parallel Brute Force Minimax Search with Alpha Beta Pruning! Its not a fair world.<br /><br />Let us behold without a doubt the definition of AI - that is - any time and any where a computer or computational device is employed to solve a problem previously performed by people, it is an instance of AI. That means unconditionally AI has existed since the 1940\'s.<br /><br />If you don\'t believe me, won\'t you at least give me credit that this might explain why I am not so well understood. Here is the traditional definition of AI:<br /><br />n 1: the branch of computer science that deal with writing computer programs that can solve problems creatively; \"workers in AI hope to imitate or duplicate intelligence in computers and robots\" [syn: {artificial intelligence},<br /><br />I admit, I am wrong, by this definition I am not working on AI at all! There, you have it, I am wrong. This is what everyone in the world want\'s to hear, that Andrew Dougherty, by gosh, he was wrong. Wrong, wrong, wrong, wrong, wrong, Dead wrong!<br /><br />Now of course since I have said that, I can\'t be right about being wrong! That is your psychology! Its not AI, it\'s just parallel brute force minimax search with alphabetapruning.<br /><br />No, the reason I am wrong is that I arrive at my definition of AI as the consequence of a long deduction into creating it. I alledge certain things are equivalent and without a background in CS the proof is not followable.<br /><br />Most people are born with a mechanism that lets them accept these things. By lacking such a mechanism, by lacking an ability to leave the iron tracks of my thinking, I am forced to deal perpetually and at every moment with the dangers of the world and to contemplate their solution.<br /><br />This has lead to an entirely different world view, one that is different in essence from those of people who have more normal reactions. In effect, it has promoted logic to be the sole inheritor of every dilemna, without any appeal to an emotional solution. Therefore the world to me is a problem in logic, and therefore we are able to conclude that all things are more Socratic in their essence. That we may refute possible definitions of things. And that, in general, as more experience comes in, this changes the qualitative nature of reality. Answers are never obtained immediately, which has the paradoxical effect of creating a rush to obtain answers immediately. Answers are really programs that map questions to solutions - that is, they take a question, in any form communicable, be it in English or Japanese or some mathematical language of some facial expression, and they produce an answer. Obviously there are English texts which are borderline between answers and statements, so this is by no means a complete function, that is, a total function, it is only a partial function, and a partial recursive function at that - BUT, there must be saying that says something to effect that, don\'t throw out job that was only 99% finished. You object to the possibility of anything being 100% complete and you reject any solution that isn\'t! Whose side are you on? Logic gives us that answer. You may well be an operative of the devil. I cannot disprove this.<br /><br />When someone looks at what they can prove and what they can\'t, we have the following inference, I should react in such a way that regardless of the actual truth of any relevant proposition, my goals will be met. This entails, in the case of creating AI, operating in such a way that would guarantee the success of AI even if every other person, indeed even if I myself, were an agent of the devil.<br /><br />Whereas other people would find this pedantic and rigid thinking, this is exactly the nature of every thought that guides my thinking, and the way I communicate this to others is under the label of Asperger\'s, which incidentally proves startlingly correct in every case.<br /><br />To use a rather disgusting example, but only for the purposes of illustrating the accuracy of this thesis, the symptoms of Asperger\'s are a model, that is, a plausible interpretation, for virtually every difference that I have been so thoroughly gone over for throughout my life. I have a flat facial affect, I am not very good at certain muscular programming - even down to the fact that I have difficulty in the lavatory. That to me was the last fact, the final guarantee. But there were several before. I have insulted several people by interchanging 1st person pronouns for 2nd and 3rd person pronouns. Example: \"I am above the military just like you\'re below it\". Someone told me I was above the military, and I meant to say \"I am above the military just like I am below it.\" meaning that I was merely different and didn\'t consider myself better or worse, merely different. But of course, the nature of my condition is that I commit social offense, but there is even a specific neurological inability to correctly use 1st, 2nd and 3rd pronouns.<br /><br />I guarantee you, for every listed symptom I can provide three examples in which people were startled because of the presence of this symptom.<br /><br />It just about covers everything.<br /><br />Now, does it really make sense to impose draconian punishments, to apply excessive calumnies, to ridicule and deprive a person because they don\'t fit your mold of what a person ought to be, this being due to the fact that they were born quite different. How many children smile when they are baptised? I was born smiling - it is a problem, it is my permanent condition. I cannot hide my emotions nor the fact that I have no negative emotions (no positive one\'s either) - only anger towards unresolved problems that destroy people, and otherwise a calm happiness. I don\'t think this makes me less of a person. I think if people were willing to acknowledge that there has been a fundamental miscommunication, and further acknowledge that this means that we ought to REMEDY the situation, then we will have to go about REMEDYING the situation.<br /><br />First of all, there are still people who want me to owe up to the problems that have been caused as a result of my differences, they want me to face punishment for these and my defiant self-righteousness.<br /><br />It is even worse that this is a syndrome that is not easily detectable. It is at this point certain undeniable. But no one is willing to relook the past and release that we have miscommunicated. Everyone is hurt, and wants to be repayed out of the capital of my self-righteousness, the part about me that knows that I am right in what I say. But is this really fair, or isn\'t this a bit like the customer at a hardware store who keeps coming back because their vacuum is a perpetual wreck, and keeps demanding that it be fixed free of charge. I am afraid that I have no choice but to ignore such a scam. It is not my problem that the vacuum is broken.<br /><br />The situation is even worse as the whole point of AI is to solve problems that affect my communication. I say, openly, I am going to use computers to express myself better, and I get attacked for this.<br /><br />Often the attacks seem aimed more at me than at what I say, they are simple attacks of the form: find out whatever Andy wants and attack that. That is what my Dad has done and of course under such situations, such one sided situations in which I was constantly vulnerable, in the good work that I had accomplished was being destroyed, so that I was becoming wasted, hopelessly warped and wasted because my talents were unpopular and failures unbounded. Under such circumstances I had to leave, and had to reduce that torture down to nothing.<br /><br />Immediately thereafter I am accused of further disturbing the peace (as if with Dad there ever was such a thing) and furthering psychological suffering. I guarantee you that when attack AI which is designed to reduce psychological suffering, you by definition will have to increase it. People allege that I should give up AI. This is again part of this whole victemology, they want me to give it up to satisfy their hurt egos, they want me to fail. The cause of this of course would be that the world would come to not have this incredibly useful system, that many problems that I was put here on this earth to resolve would remain forever unsolved and would continue to plague and destroy and limit every goal and every desire of every person for all future time. I have special circumstances, every does, that makes them better suited to solve certain problems. AI is damned up by a communication barrier, and the waters are receding. So I cannot be blamed for losing my sanity along with the rest of the world. I cannot provide that service I am afraid, that is logic, if it cannot be done it cannot be done, and under such attack and such isolation and (god damn it I cannot even remember the phrase, right here I might have succeeded in adding a little more conviction to the argument). Well, anytime you have an exchange, with it not quite being just, and then the party which has benefitted more of course wants to sit tight. They have to realize that their beliefs are predicated on a mistaken interpretation of my motivations and that as I was really not to blame, their punishments and sanctions were unjust, just as one does not punish a retard for his retardation, you ought to punish what is to blame, which is to say you ought to pusish our ignorance, which is to say that we should study, and the limit of study is AI, at least for me. There comes a point in study where the actual information theoretical, computational and psychological limitations that you are studying affect your ability to study - this is actually metamathematics. If you apply information theoretic computation complexity to metamathematics, you get the theory of Algorithmic Information Theory, which is synonymous with AI.<br /><br />Here is the most efficient explanation of what motivates me to collect software.<br /><br />http://www.cs.umaine.edu/~chaitin/acm74.pdf<br /><br />\"In a word, we propose that there may be theoretical justification for regarding number theory somewhat more like a dynamicempirical science than a closed static body of theory.\" This illustrates why I think we are destined to catastrophy. I think our logic, which may be formalized in number theory, winds up failing with probability 1.<br /><br />adaptation exaptation excptation<br />',62,31,0,'2015-11-11 18:00:00',0);
/*!40000 ALTER TABLE `blog_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_form`
--

DROP TABLE IF EXISTS `cms_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `url_name` varchar(100) NOT NULL,
  `redirect` varchar(200) DEFAULT NULL,
  `action` varchar(20) NOT NULL,
  `email_to` varchar(100) DEFAULT NULL,
  `template` varchar(100) DEFAULT NULL,
  `has_captcha` tinyint(4) DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_form_url_name` (`url_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_form`
--

LOCK TABLES `cms_form` WRITE;
/*!40000 ALTER TABLE `cms_form` DISABLE KEYS */;
INSERT INTO `cms_form` VALUES (1,'Contact Form','contact','/','Email','2014@denny.me',NULL,1,'2015-11-11 19:01:51');
/*!40000 ALTER TABLE `cms_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_page`
--

DROP TABLE IF EXISTS `cms_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `url_name` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text,
  `template` int(11) NOT NULL,
  `section` int(11) DEFAULT NULL,
  `menu_position` int(11) DEFAULT NULL,
  `hidden` tinyint(4) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_page_url_name` (`section`,`url_name`),
  KEY `cms_page_idx_section` (`section`),
  KEY `cms_page_idx_template` (`template`),
  CONSTRAINT `cms_page_fk_section` FOREIGN KEY (`section`) REFERENCES `cms_section` (`id`),
  CONSTRAINT `cms_page_fk_template` FOREIGN KEY (`template`) REFERENCES `cms_template` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_page`
--

LOCK TABLES `cms_page` WRITE;
/*!40000 ALTER TABLE `cms_page` DISABLE KEYS */;
INSERT INTO `cms_page` VALUES (1,'Home','home','Welcome to ShinyCMS',NULL,1,1,NULL,0,'2015-11-11 19:01:51'),(2,'About ShinyCMS','about','About ShinyCMS',NULL,2,2,1,0,'2015-11-11 19:01:51'),(3,'Feature List','features','Feature List',NULL,2,2,2,0,'2015-11-11 19:01:51'),(4,'Contact Us','contact-us','Contact Us',NULL,3,1,3,0,'2015-11-11 19:01:51');
/*!40000 ALTER TABLE `cms_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_page_element`
--

DROP TABLE IF EXISTS `cms_page_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_page_element` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'Short Text',
  `content` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `cms_page_element_idx_page` (`page`),
  CONSTRAINT `cms_page_element_fk_page` FOREIGN KEY (`page`) REFERENCES `cms_page` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_page_element`
--

LOCK TABLES `cms_page_element` WRITE;
/*!40000 ALTER TABLE `cms_page_element` DISABLE KEYS */;
INSERT INTO `cms_page_element` VALUES (1,1,'heading1','Short Text','Introducing ShinyCMS','2015-11-11 19:01:51'),(2,1,'html1','HTML','<p>\n	This website is powered by <a href=\"http://shinycms.org/\">ShinyCMS</a>, \n	an open source content management system which is flexible and easy to \n	use, giving you the ability to change and update your content safely \n	and easily.</p>\n<p>\n	ShinyCMS can provide customised content management solutions for every \n	aspect of your business, from easily edited web pages to blog, forums, \n	paid memberships, an online store and more.</p>\n<p>\n	This text comes from the database and is under CMS control. It is \n	WYSIWYG editable and <i>can</i> <b>include</b> <u>various</u> \n	<b><i><u>formatting</u></i></b>.</p>\n','2015-11-11 19:01:51'),(3,1,'video_url','Short Text','Shiny.jpg','2015-11-11 19:01:51'),(4,2,'heading1','Short Text','Whose problems are you solving today?','2015-11-11 19:01:51'),(5,2,'paragraphs1','Long Text','','2015-11-11 19:01:51'),(6,2,'html1','HTML','<p>\n	ShinyCMS is an open-source content management system intended for use \n	by web designers and web developers who want to keep a clear distinction \n	between the markup they create and the content their clients can edit.</p>\n<p>\n	On a ShinyCMS-powered site, the pages are constructed using template files \n	on disk which are mostly standard HTML (or XHTML). The CMS then inserts \n	text and images specified by the database in places designated by special \n	tokens (the templating language used is the well-known and flexible \n	<a href=\"http://template-toolkit.org/\">Template Toolkit</a>). The only \n	things the end-user can edit are these small pieces of database-driven \n	content - not the whole page.</p>\n<p>\n	This way of working means that it\'s almost impossible for the end-user to \n	accidentally break the page layout when they edit their content. It also \n	means that the page-editing interface is very clear and simple - making \n	it easy for non-technical people to update the website.</p>\n<p>\n	ShinyCMS has a number of features already in place, and more on the way. \n	Take a look at <a href=\"http://shinycms.org/pages/main/features\">our \n	feature list</a> to see what\'s already working, and at our \n	<a href=\"https://github.com/denny/ShinyCMS/blob/master/docs/TODO\">\'to do\' \n	list</a> (on github) for what\'s coming soon.</p>\n<p>\n	ShinyCMS is built in <a href=\"http://www.perl.org/\">Perl</a> using the \n	<a href=\"http://www.catalystframework.org/\">Catalyst</a> framework. \n	We\'re currently working towards a 1.0 release, but if you\'re interested \n	in trying it out before then, you can \n	<a href=\"https://github.com/denny/ShinyCMS\">download a copy of the code \n	here</a> - please drop us an email to &lt;2014 at shinycms.org&gt; to let \n	us know how you\'re getting on, or come and chat to us in #shinycms on \n	irc.freenode.net</p>\n','2015-11-11 19:01:51'),(7,2,'image1','Image','Shiny.jpg','2015-11-11 19:01:51'),(8,3,'heading1','Short Text','Feature List','2015-11-11 19:01:51'),(9,3,'paragraphs1','Long Text','The following is a list of features currently found in ShinyCMS:\n','2015-11-11 19:01:51'),(10,3,'html1','HTML','<ul>\n	<li>\n		CMS Pages\n		<ul>\n			<li>\n				Add/Edit/Delete templates from CMS control\n				<ul>\n					<li>\n						Templates use on-disk files to define page layouts\n						<ul>\n							<li>\n								Inside each template file, you can specify a wrapper template to use with that template (reduces markup duplication inside sections of client sites</li>\n						</ul>\n					</li>\n				</ul>\n			</li>\n			<li>\n				Add/Hide/Delete sections</li>\n			<li>\n				Edit sections\n				<ul>\n					<li>\n						Select a default page for each section</li>\n					<li>\n						Set menu position</li>\n					<li>\n						Set URL stub for section</li>\n				</ul>\n			</li>\n			<li>\n				Edit pages\n				<ul>\n					<li>\n						Select template to use</li>\n					<li>\n						Edit page name, title, meta description and keywords</li>\n					<li>\n						Set section</li>\n					<li>\n						Set menu position</li>\n					<li>\n						Set page URL stub</li>\n					<li>\n						Edit page content\n						<ul>\n							<li>\n								Plain text elements for simplicity</li>\n							<li>\n								WYSIWYG editor widget for HTML elements where required</li>\n						</ul>\n					</li>\n					<li>\n						Preview edits before saving</li>\n				</ul>\n			</li>\n			<li>\n				Display page\n				<ul>\n					<li>\n						Uses template for layout, content/copy comes from database</li>\n				</ul>\n			</li>\n			<li>\n				Auto-generate menus based on menu position settings of sections and pages</li>\n			<li>\n				Auto-generate basic sitemap based on menu positions and &#39;hidden&#39; status</li>\n			<li>\n				Supply search results to site-wide search</li>\n			<li>\n				Pull in &#39;recent updates&#39; from news, blogs and events sections</li>\n			<li>\n				Pull in atom feeds from external blogs&nbsp;</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		CMS Forms\n		<ul>\n			<li>\n				Add/Edit/Delete CMS form handlers</li>\n			<li>\n				Process form submissions\n				<ul>\n					<li>\n						Spam-protection using reCaptcha</li>\n					<li>\n						Trigger an email\n						<ul>\n							<li>\n								Generic or templated</li>\n						</ul>\n					</li>\n				</ul>\n			</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		Shared Content\n		<ul>\n			<li>\n				Add/Edit/Delete shared content\n				<ul>\n					<li>\n						Store snippets of text and HTML that you want to re-use across multiple pages but still allow user to edit (e.g. contact details for use in page footer, etc)</li>\n				</ul>\n			</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		Restricted Content\n		<ul>\n			<li>\n				Have static files (images, documents, etc) which are only available&nbsp;to logged-in users who have a certain User Access type set\n				<ul>\n					<li>\n						Supports multiple User Access types, for user/content categorisation/separation&nbsp;</li>\n				</ul>\n			</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		Menus\n		<ul>\n			<li>\n				Main menu on user-facing site\n				<ul>\n					<li>\n						Auto-generated for sections and pages in CMS Pages area</li>\n				</ul>\n			</li>\n			<li>\n				Admin footer bar on user-facing site\n				<ul>\n					<li>\n						Useful contextual admin links in page footer when admin user is logged in</li>\n				</ul>\n			</li>\n			<li>\n				Admin menus in back-end can be easily re-ordered via template\n				<ul>\n					<li>\n						Only displays menus for features the logged-in user can access&nbsp;</li>\n				</ul>\n			</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		Site-wide search. &nbsp;Currently pulls in results from:\n		<ul>\n			<li>\n				CMS pages</li>\n			<li>\n				News items</li>\n			<li>\n				Blog posts</li>\n			<li>\n				Forum posts</li>\n			<li>\n				Comments</li>\n			<li>\n				Events</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		Site-wide tag listings. &nbsp;Currently links to:\n		<ul>\n			<li>\n				Blog posts</li>\n			<li>\n				Forum posts</li>\n			<li>\n				Shop items</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		404 handler (with home and sitemap links, and search box)</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		Style-switcher\n		<ul>\n			<li>\n				Allow users to switch between stylesheets, for accessibility or themes</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		Mobile device detection\n		<ul>\n			<li>\n				Detect if user is browsing from a mobile device\n				<ul>\n					<li>\n						Allows you to present content differently, or present different content&nbsp;&nbsp;</li>\n				</ul>\n			</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		Blogs\n		<ul>\n			<li>\n				Display recent posts\n				<ul>\n					<li>\n						With pagination</li>\n				</ul>\n			</li>\n			<li>\n				Display all posts in a given month\n				<ul>\n					<li>\n						With prev/next month navigation</li>\n				</ul>\n			</li>\n			<li>\n				Display summary of all posts in a given year\n				<ul>\n					<li>\n						With prev/next year navigation&nbsp;</li>\n				</ul>\n			</li>\n			<li>\n				Display all posts with a given tag\n				<ul>\n					<li>\n						With pagination</li>\n				</ul>\n			</li>\n			<li>\n				Display all posts by a given author\n				<ul>\n					<li>\n						With pagination&nbsp;</li>\n				</ul>\n			</li>\n			<li>\n				Display a single post</li>\n			<li>\n				Generate atom feed of recent posts</li>\n			<li>\n				Add/Edit/Hide/Delete posts\n				<ul>\n					<li>\n						Schedule posts (future-date a post and it will appear on the site at the specified date and time)</li>\n					<li>\n						Enable/disable comments</li>\n				</ul>\n			</li>\n			<li>\n				Supply search results to site-wide search</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		Forums\n		<ul>\n			<li>\n				Add/Edit/Hide/Delete section</li>\n			<li>\n				Add/Edit/Hide/Delete forum</li>\n			<li>\n				Add/Edit/Hide/Delete new thread</li>\n			<li>\n				Add comments to thread</li>\n			<li>\n				Delete comments (admin-only)</li>\n			<li>\n				Display all forums in all sections</li>\n			<li>\n				Display forums in a specified section</li>\n			<li>\n				Display threads in a forum</li>\n			<li>\n				Display threads with a given tag</li>\n			<li>\n				Display thread\n				<ul>\n					<li>\n						With nested comments</li>\n				</ul>\n			</li>\n			<li>\n				Supply search results to site-wide search&nbsp;</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		News\n		<ul>\n			<li>\n				View list of news items</li>\n			<li>\n				View item</li>\n			<li>\n				Add/Edit/Hide/Delete news items</li>\n			<li>\n				Supply search results to site-wide search</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		Comments\n		<ul>\n			<li>\n				Currently enabled on:\n				<ul>\n					<li>\n						Blog posts</li>\n					<li>\n						Forum threads</li>\n					<li>\n						Shop items</li>\n				</ul>\n			</li>\n			<li>\n				Display comments\n				<ul>\n					<li>\n						With nested threading</li>\n				</ul>\n			</li>\n			<li>\n				Add comments\n				<ul>\n					<li>\n						Reply to original post or to another comment</li>\n					<li>\n						As logged-in, anonymous, or pseudonymous user\n						<ul>\n							<li>\n								Saves and restores details of pseudonymous users</li>\n							<li>\n								Captcha for anonymous and pseudonymous users</li>\n						</ul>\n					</li>\n				</ul>\n			</li>\n			<li>\n				Hide comments\n				<ul>\n					<li>\n						Allows soft removal of comments in mid-thread</li>\n					<li>\n						Can be restored</li>\n				</ul>\n			</li>\n			<li>\n				Delete comments\n				<ul>\n					<li>\n						Cascade deletes any child comments</li>\n				</ul>\n			</li>\n			<li>\n				Supply search results to site-wide search&nbsp;</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		Users\n		<ul>\n			<li>\n				User registration\n				<ul>\n					<li>\n						With email confirmation stage&nbsp;</li>\n				</ul>\n			</li>\n			<li>\n				Log in / out</li>\n			<li>\n				Recover from forgotten password&nbsp;</li>\n			<li>\n				View user profile\n				<ul>\n					<li>\n						Show recent (and total) blog posts and comments</li>\n					<li>\n						Show recent (and total) forum posts and comments</li>\n				</ul>\n			</li>\n			<li>\n				User can edit their own details</li>\n			<li>\n				Roles (&#39;page editor&#39;, &#39;shop admin&#39;, etc)</li>\n			<li>\n				User administration\n				<ul>\n					<li>\n						Add/Delete users</li>\n					<li>\n						Edit existing users\n						<ul>\n							<li>\n								Edit user details</li>\n							<li>\n								Edit user roles</li>\n						</ul>\n					</li>\n					<li>\n						Admin notes (notes about a user which are only visible to admins)</li>\n				</ul>\n			</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		Shop\n		<ul>\n			<li>\n				Display item</li>\n			<li>\n				Display list of items in a category</li>\n			<li>\n				Display list of recently-added items&nbsp;</li>\n			<li>\n				Display list of all items</li>\n			<li>\n				Display list of categories\n				<ul>\n					<li>\n						With nested sub-categories</li>\n				</ul>\n			</li>\n			<li>\n				Add/Edit/Delete product types</li>\n			<li>\n				Add/Edit/Hide/Delete categories</li>\n			<li>\n				Add/Edit/Hide/Delete items</li>\n			<li>\n				Basket and checkout\n				<ul>\n					<li>\n						Use built-in &#39;ShinyShop&#39; basket and checkout\n						<ul>\n							<li>\n								Payment handlers for physical and virtual goods\n								<ul>\n									<li>\n										Support varous credit card payment processors\n										<ul>\n											<li>\n												Currently supported: CCBill</li>\n										</ul>\n									</li>\n								</ul>\n							</li>\n							<li>\n								View orders</li>\n							<li>\n								Cancel order (before despatch only)</li>\n						</ul>\n					</li>\n					<li>\n						Or, use basic PayPal cart and checkout integration</li>\n				</ul>\n			</li>\n			<li>\n				Subscription payment handlers for setting User Access\n				<ul>\n					<li>\n						Support various credit card payment processors\n						<ul>\n							<li>\n								Currently supported: CCBill</li>\n						</ul>\n					</li>\n					<li>\n						Background task to check renewals and maintain/remove access</li>\n				</ul>\n			</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		Mailshot features\n		<ul>\n			<li>\n				Add/edit/delete mailing lists</li>\n			<li>\n				Add/edit/delete newsletter templates from CMS control</li>\n			<li>\n				HTML newsletters\n				<ul>\n					<li>\n						Create/edit/delete newsletters</li>\n					<li>\n						Background task to send out newsletters to mailing lists</li>\n					<li>\n						View previous newsletters on site</li>\n				</ul>\n			</li>\n			<li>\n				Autoresponders\n				<ul>\n					<li>\n						Add/Edit/Delete autoresponders\n						<ul>\n							<li>\n								Add/Edit/Delete autoresponder emails</li>\n						</ul>\n					</li>\n					<li>\n						Allow users to subscribe to autoresponders</li>\n					<li>\n						Background task to send out autoresponder emails to each recipient at configured time intervals</li>\n				</ul>\n			</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		Events\n		<ul>\n			<li>\n				Display &#39;coming soon&#39; events</li>\n			<li>\n				Display all events starting in a given month\n				<ul>\n					<li>\n						With prev/next month navigation</li>\n				</ul>\n			</li>\n			<li>\n				Display details of a single event\n				<ul>\n					<li>\n						Link to external event website</li>\n					<li>\n						Link to external ticket-booking website</li>\n					<li>\n						Link to Google Map for event location</li>\n				</ul>\n			</li>\n			<li>\n				Add/Edit/Hide/Delete events</li>\n			<li>\n				Supply search results to site-wide search</li>\n		</ul>\n	</li>\n</ul>\n<p>\n	&nbsp;</p>\n<ul>\n	<li>\n		Polls\n		<ul>\n			<li>\n				Basic pollbooths</li>\n			<li>\n				Anon &amp; logged-in voting</li>\n			<li>\n				Basic vote-stacking protection (per-IP for anon, per-user for logged-in)</li>\n		</ul>\n	</li>\n</ul>\n','2015-11-11 19:01:51'),(11,3,'image1','Image','Shiny.jpg','2015-11-11 19:01:51');
/*!40000 ALTER TABLE `cms_page_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_section`
--

DROP TABLE IF EXISTS `cms_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_section` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `url_name` varchar(100) NOT NULL,
  `description` text,
  `default_page` int(11) DEFAULT NULL,
  `menu_position` int(11) DEFAULT NULL,
  `hidden` tinyint(4) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_section_url_name` (`url_name`),
  KEY `cms_section_idx_default_page` (`default_page`),
  CONSTRAINT `cms_section_fk_default_page` FOREIGN KEY (`default_page`) REFERENCES `cms_page` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_section`
--

LOCK TABLES `cms_section` WRITE;
/*!40000 ALTER TABLE `cms_section` DISABLE KEYS */;
INSERT INTO `cms_section` VALUES (1,'Home','home',NULL,1,1,0,'2015-11-11 19:01:51'),(2,'More','more',NULL,2,2,0,'2015-11-11 19:01:51');
/*!40000 ALTER TABLE `cms_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_template`
--

DROP TABLE IF EXISTS `cms_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `template_file` varchar(100) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_template`
--

LOCK TABLES `cms_template` WRITE;
/*!40000 ALTER TABLE `cms_template` DISABLE KEYS */;
INSERT INTO `cms_template` VALUES (1,'Homepage','homepage.tt','2015-11-11 19:01:51'),(2,'Subpage 1','subpage1.tt','2015-11-11 19:01:51'),(3,'Contact Form','contact-form.tt','2015-11-11 19:01:51');
/*!40000 ALTER TABLE `cms_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_template_element`
--

DROP TABLE IF EXISTS `cms_template_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cms_template_element` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'Short Text',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `cms_template_element_idx_template` (`template`),
  CONSTRAINT `cms_template_element_fk_template` FOREIGN KEY (`template`) REFERENCES `cms_template` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_template_element`
--

LOCK TABLES `cms_template_element` WRITE;
/*!40000 ALTER TABLE `cms_template_element` DISABLE KEYS */;
INSERT INTO `cms_template_element` VALUES (1,1,'heading1','Short Text','2015-11-11 19:01:51'),(2,1,'html1','HTML','2015-11-11 19:01:51'),(3,1,'video_url','Short Text','2015-11-11 19:01:51'),(4,2,'heading1','Short Text','2015-11-11 19:01:51'),(5,2,'paragraphs1','Long Text','2015-11-11 19:01:51'),(6,2,'html1','HTML','2015-11-11 19:01:51'),(7,2,'image1','Image','2015-11-11 19:01:51');
/*!40000 ALTER TABLE `cms_template_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `discussion` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `parent` int(11) DEFAULT NULL,
  `author` int(11) DEFAULT NULL,
  `author_type` varchar(20) NOT NULL,
  `author_name` varchar(100) DEFAULT NULL,
  `author_email` varchar(200) DEFAULT NULL,
  `author_link` varchar(200) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `body` text,
  `posted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `hidden` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`),
  KEY `comment_idx_author` (`author`),
  KEY `comment_idx_discussion` (`discussion`),
  CONSTRAINT `comment_fk_author` FOREIGN KEY (`author`) REFERENCES `user` (`id`),
  CONSTRAINT `comment_fk_discussion` FOREIGN KEY (`discussion`) REFERENCES `discussion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,1,1,NULL,3,'Site User',NULL,NULL,NULL,NULL,'\"If it isn\'t Double-you-one-enn-five-tee-zero-enn,\" said Fredrick Benson.\n\n\"Sorry, nope,\" I said. \"I never heard of this R2D2 character of yours.\"\n','2015-11-11 19:02:00',0),(2,1,2,1,3,'Site User',NULL,NULL,NULL,NULL,'\"We have reliable intelligence indicating that you are w1n5t0n\" -- again, he spelled it out, and I began to wonder if he hadn\'t figured out that the 1 was an I and the 5 was an S.\n','2015-11-11 19:02:00',0),(3,1,3,NULL,3,'Site User',NULL,NULL,NULL,NULL,'Benson settled down behind his desk and tapped his class-ring nervously on his blotter. He did this whenever things started to go bad for him. Poker players call stuff like this a \"tell\" -- something that let you know what was going on in the other guy\'s head. I knew Benson\'s tells backwards and forwards.\n','2015-11-11 19:02:00',0),(4,1,4,2,3,'Site User',NULL,NULL,NULL,NULL,'\"You have \'reliable intelligence\'? I\'d like to see it.\"\n\nHe glowered at me. \"Your attitude isn\'t going to help you.\"\n','2015-11-11 19:02:00',0),(5,1,5,3,3,'Site User',NULL,NULL,NULL,NULL,'\"Marcus, I hope you realize how serious this is.\"\n\n\"I will just as soon as you explain what this is, sir.\" I always say \"sir\" to authority figures when I\'m messing with them. It\'s my own tell.\n','2015-11-11 19:02:01',0),(6,13,1,NULL,1,'Site User',NULL,NULL,NULL,NULL,'Hi, I\'m interested in the difference between netbooks and laptops...\n','2015-11-11 19:02:03',0),(7,13,2,1,1,'Site User',NULL,NULL,NULL,NULL,'What kind of thing do you want to know?\n','2015-11-11 19:02:03',0),(8,13,3,NULL,1,'Site User',NULL,NULL,NULL,NULL,'How about tablets?\n','2015-11-11 19:02:03',0),(9,13,4,2,1,'Site User',NULL,NULL,NULL,NULL,'Is there a clear definition of which is which?\n','2015-11-11 19:02:03',0),(10,13,5,3,1,'Site User',NULL,NULL,NULL,NULL,'Yeah, they should probably add a section for those.\n','2015-11-11 19:02:04',0);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_like`
--

DROP TABLE IF EXISTS `comment_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment_like` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` int(11) NOT NULL,
  `user` int(11) DEFAULT NULL,
  `ip_address` varchar(15) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `comment_like_idx_comment` (`comment`),
  KEY `comment_like_idx_user` (`user`),
  CONSTRAINT `comment_like_fk_comment` FOREIGN KEY (`comment`) REFERENCES `comment` (`uid`),
  CONSTRAINT `comment_like_fk_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_like`
--

LOCK TABLES `comment_like` WRITE;
/*!40000 ALTER TABLE `comment_like` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `confirmation`
--

DROP TABLE IF EXISTS `confirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirmation` (
  `user` int(11) NOT NULL,
  `code` varchar(32) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user`,`code`),
  KEY `confirmation_idx_user` (`user`),
  CONSTRAINT `confirmation_fk_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `confirmation`
--

LOCK TABLES `confirmation` WRITE;
/*!40000 ALTER TABLE `confirmation` DISABLE KEYS */;
/*!40000 ALTER TABLE `confirmation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discussion`
--

DROP TABLE IF EXISTS `discussion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discussion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL,
  `resource_type` varchar(50) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discussion`
--

LOCK TABLES `discussion` WRITE;
/*!40000 ALTER TABLE `discussion` DISABLE KEYS */;
INSERT INTO `discussion` VALUES (1,1,'BlogPost','2015-11-11 19:02:00'),(2,2,'BlogPost','2015-11-11 19:02:01'),(3,3,'BlogPost','2015-11-11 19:02:01'),(4,4,'BlogPost','2015-11-11 19:02:01'),(5,5,'BlogPost','2015-11-11 19:02:01'),(6,7,'BlogPost','2015-11-11 19:02:01'),(7,8,'BlogPost','2015-11-11 19:02:01'),(8,9,'BlogPost','2015-11-11 19:02:01'),(9,10,'BlogPost','2015-11-11 19:02:01'),(10,11,'BlogPost','2015-11-11 19:02:01'),(11,12,'BlogPost','2015-11-11 19:02:01'),(12,13,'BlogPost','2015-11-11 19:02:01'),(13,1,'ForumPost','2015-11-11 19:02:03'),(14,1,'ShopItem','2015-11-11 19:02:07'),(15,2,'ShopItem','2015-11-11 19:02:07'),(16,3,'ShopItem','2015-11-11 19:02:07');
/*!40000 ALTER TABLE `discussion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `url_name` varchar(100) NOT NULL,
  `description` text,
  `image` varchar(100) DEFAULT NULL,
  `start_date` timestamp NOT NULL DEFAULT '1971-01-01 07:01:01',
  `end_date` timestamp NOT NULL DEFAULT '1971-01-01 07:01:01',
  `address` varchar(250) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `link` varchar(200) DEFAULT NULL,
  `booking_link` varchar(200) DEFAULT NULL,
  `hidden` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'Old Event','old-event','This is the first event, it is in the past.',NULL,'2015-10-12 00:02:11','2015-10-12 01:02:11',NULL,NULL,NULL,NULL,NULL,0),(2,'Current Event','current','This is the second event, it is happening today!',NULL,'2015-11-12 01:02:11','2015-11-13 01:02:11',NULL,'EC1V 9AU',NULL,'http://shinycms.org/',NULL,0),(3,'Christmas','xmas','Tis the season to be jolly, tra-la-la-la-la, la-la la la.',NULL,'2015-12-25 06:00:00','2015-12-25 06:00:00',NULL,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feed`
--

DROP TABLE IF EXISTS `feed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `url` varchar(255) NOT NULL,
  `last_checked` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feed`
--

LOCK TABLES `feed` WRITE;
/*!40000 ALTER TABLE `feed` DISABLE KEYS */;
/*!40000 ALTER TABLE `feed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feed_item`
--

DROP TABLE IF EXISTS `feed_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feed_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feed` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `body` text,
  `posted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `feed_item_idx_feed` (`feed`),
  CONSTRAINT `feed_item_fk_feed` FOREIGN KEY (`feed`) REFERENCES `feed` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feed_item`
--

LOCK TABLES `feed_item` WRITE;
/*!40000 ALTER TABLE `feed_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `feed_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_access`
--

DROP TABLE IF EXISTS `file_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `access_group` varchar(50) NOT NULL,
  `filepath` varchar(250) NOT NULL,
  `filename` varchar(100) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `file_access_idx_user` (`user`),
  CONSTRAINT `file_access_fk_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_access`
--

LOCK TABLES `file_access` WRITE;
/*!40000 ALTER TABLE `file_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum`
--

DROP TABLE IF EXISTS `forum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `section` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `url_name` varchar(100) NOT NULL,
  `description` text,
  `display_order` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forum_url_name` (`section`,`url_name`),
  KEY `forum_idx_section` (`section`),
  CONSTRAINT `forum_fk_section` FOREIGN KEY (`section`) REFERENCES `forum_section` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum`
--

LOCK TABLES `forum` WRITE;
/*!40000 ALTER TABLE `forum` DISABLE KEYS */;
INSERT INTO `forum` VALUES (1,1,'Laptops','laptops',NULL,NULL,'2015-11-11 19:02:03'),(2,1,'Desktops','desktops',NULL,NULL,'2015-11-11 19:02:03'),(3,2,'Linux','linux',NULL,NULL,'2015-11-11 19:02:03');
/*!40000 ALTER TABLE `forum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_post`
--

DROP TABLE IF EXISTS `forum_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forum` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `url_title` varchar(100) NOT NULL,
  `body` text NOT NULL,
  `author` int(11) DEFAULT NULL,
  `posted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `display_order` int(11) DEFAULT NULL,
  `commented_on` timestamp NOT NULL DEFAULT '1971-01-01 07:01:01',
  `discussion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_post_idx_author` (`author`),
  KEY `forum_post_idx_discussion` (`discussion`),
  KEY `forum_post_idx_forum` (`forum`),
  CONSTRAINT `forum_post_fk_author` FOREIGN KEY (`author`) REFERENCES `user` (`id`),
  CONSTRAINT `forum_post_fk_discussion` FOREIGN KEY (`discussion`) REFERENCES `discussion` (`id`),
  CONSTRAINT `forum_post_fk_forum` FOREIGN KEY (`forum`) REFERENCES `forum` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_post`
--

LOCK TABLES `forum_post` WRITE;
/*!40000 ALTER TABLE `forum_post` DISABLE KEYS */;
INSERT INTO `forum_post` VALUES (1,1,'General chat','general-chat','We can discuss anything about laptops here!\n',1,'2015-11-11 19:02:03',NULL,'1971-01-01 07:01:01',13);
/*!40000 ALTER TABLE `forum_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_section`
--

DROP TABLE IF EXISTS `forum_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_section` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `url_name` varchar(100) NOT NULL,
  `description` text,
  `display_order` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forum_section_url_name` (`url_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_section`
--

LOCK TABLES `forum_section` WRITE;
/*!40000 ALTER TABLE `forum_section` DISABLE KEYS */;
INSERT INTO `forum_section` VALUES (1,'Hardware','hardware',NULL,NULL,'2015-11-11 19:02:03'),(2,'Software','software',NULL,NULL,'2015-11-11 19:02:03');
/*!40000 ALTER TABLE `forum_section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gallery`
--

DROP TABLE IF EXISTS `gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hidden` tinyint(4) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallery`
--

LOCK TABLES `gallery` WRITE;
/*!40000 ALTER TABLE `gallery` DISABLE KEYS */;
/*!40000 ALTER TABLE `gallery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `mime` varchar(200) NOT NULL,
  `path` text NOT NULL,
  `caption` text,
  `hidden` tinyint(4) NOT NULL DEFAULT '0',
  `uploaded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail_recipient`
--

DROP TABLE IF EXISTS `mail_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_recipient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(200) NOT NULL,
  `token` varchar(32) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mail_recipient_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail_recipient`
--

LOCK TABLES `mail_recipient` WRITE;
/*!40000 ALTER TABLE `mail_recipient` DISABLE KEYS */;
INSERT INTO `mail_recipient` VALUES (1,'Nice Person','nice.person@example.com','abcd1234abcd1234abcd1234abcd1111','2015-11-11 19:02:09'),(2,'Another Person','another.person@example.com','abcd1234abcd1234abcd1234abcd2222','2015-11-11 19:02:09'),(3,'A. Teacher','a.teacher@example.com','abcd1234abcd1234abcd1234abcd3333','2015-11-11 19:02:09'),(4,'Site Admin','changeme@example.com','abcd1234abcd1234abcd1234abcd4444','2015-11-11 19:02:09');
/*!40000 ALTER TABLE `mail_recipient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mailing_list`
--

DROP TABLE IF EXISTS `mailing_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mailing_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `user_can_sub` tinyint(4) DEFAULT '0',
  `user_can_unsub` tinyint(4) DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mailing_list`
--

LOCK TABLES `mailing_list` WRITE;
/*!40000 ALTER TABLE `mailing_list` DISABLE KEYS */;
INSERT INTO `mailing_list` VALUES (1,'Donators and teachers',0,1,'2015-11-11 19:02:09'),(2,'Testing',0,1,'2015-11-11 19:02:09');
/*!40000 ALTER TABLE `mailing_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_item`
--

DROP TABLE IF EXISTS `news_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `url_title` varchar(100) NOT NULL,
  `body` text NOT NULL,
  `related_url` varchar(255) DEFAULT NULL,
  `hidden` tinyint(4) NOT NULL DEFAULT '0',
  `posted` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `news_item_idx_author` (`author`),
  CONSTRAINT `news_item_fk_author` FOREIGN KEY (`author`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_item`
--

LOCK TABLES `news_item` WRITE;
/*!40000 ALTER TABLE `news_item` DISABLE KEYS */;
INSERT INTO `news_item` VALUES (1,2,'This is the news','this-is-the-news','<p>	HTML content goes here.\n</p>\n',NULL,0,'2010-01-01 18:00:00'),(2,2,'Extra extra','extra-extra','<p>	Read all about it.\n</p>\n',NULL,0,'2010-01-01 19:00:00'),(3,2,'Filler story','filler','<p>	Nothing of interest here.  Move along.\n</p>\n',NULL,0,'2010-01-02 19:00:00');
/*!40000 ALTER TABLE `news_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsletter`
--

DROP TABLE IF EXISTS `newsletter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `url_title` varchar(100) NOT NULL,
  `template` int(11) NOT NULL,
  `plaintext` text,
  `list` int(11) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Not sent',
  `sent` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `newsletter_idx_list` (`list`),
  KEY `newsletter_idx_template` (`template`),
  CONSTRAINT `newsletter_fk_list` FOREIGN KEY (`list`) REFERENCES `mailing_list` (`id`),
  CONSTRAINT `newsletter_fk_template` FOREIGN KEY (`template`) REFERENCES `newsletter_template` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsletter`
--

LOCK TABLES `newsletter` WRITE;
/*!40000 ALTER TABLE `newsletter` DISABLE KEYS */;
INSERT INTO `newsletter` VALUES (1,'Donations and a word to teachers and librarians','donations',1,'If you enjoyed the electronic edition of Little Brother and you want to donate \nsomething to say thanks, go to http://craphound.com/littlebrother/donate/ and \nfind a teacher or librarian you want to support.  Then go to Amazon, BN.com, \nor your favorite electronic bookseller and order a copy to the classroom, \nthen email a copy of the receipt (feel free to delete your address and other \npersonal info first!) to freelittlebrother@gmail.com so that Olga can mark \nthat copy as sent.  If you don\'t want to be publicly acknowledged for your \ngenerosity, let us know and we\'ll keep you anonymous, otherwise we\'ll thank \nyou on the donate page.\n',1,'Not sent','2015-11-11 19:02:09');
/*!40000 ALTER TABLE `newsletter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsletter_element`
--

DROP TABLE IF EXISTS `newsletter_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletter_element` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `newsletter` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'Short Text',
  `content` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `newsletter_element_idx_newsletter` (`newsletter`),
  CONSTRAINT `newsletter_element_fk_newsletter` FOREIGN KEY (`newsletter`) REFERENCES `newsletter` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsletter_element`
--

LOCK TABLES `newsletter_element` WRITE;
/*!40000 ALTER TABLE `newsletter_element` DISABLE KEYS */;
INSERT INTO `newsletter_element` VALUES (1,1,'body','HTML','<p>	A message from Cory Doctorow:\n</p>\n<p>	Every time I put a book online for free, I get emails from readers who \n	want to send me donations for the book. I appreciate their generous\n	spirit, but I\'m not interested in cash donations, because my\n	publishers are really important to me. They contribute immeasurably\n	to the book, improving it, introducing it to an audience I could never\n	reach, helping me do more with my work. I have no desire to cut them\n	out of the loop.\n</p>\n\n<p>	But there has to be some good way to turn that generosity to good use,\n	and I think I\'ve found it.\n</p>\n\n<p>	Here\'s the deal: there are lots of teachers and librarians who\'d love to \n	get hard-copies of Little Brother into their kids\' hands, but don\'t have the\n	budget for it (teachers in the US spend around $1,200 out of pocket\n	each on classroom supplies that their budgets won\'t stretch to cover,\n	which is why I sponsor a classroom at Ivanhoe Elementary in my old\n	neighborhood in Los Angeles; you can adopt a class yourself \n	<a href=\"http://www.adoptaclassroom.org/\">here</a>).\n</p>\n\n<p>	There are generous people who want to send some cash my way to thank me \n	for the free ebooks.\n</p>\n\n<p>	I\'m proposing that we put them together. \n</p>\n\n<p>	If you\'re a teacher or librarian and you want a free copy of Little\n	Brother, email \n	<a href=\"mailto:freelittlebrother@gmail.com\">freelittlebrother@gmail.com</a> \n	with your name and the name and address of your school. It\'ll be \n	<a href=\"http://craphound.com/littlebrother/donate/\">posted to my site</a> \n	by my fantastic helper, Olga Nunes, so that potential donors can see it.\n</p>\n\n<p>	If you enjoyed the electronic edition of Little Brother and you want to\n	donate something to say thanks, \n	<a href=\"http://craphound.com/littlebrother/donate/\">go here</a> \n	and find a teacher or librarian you want to support. Then go to Amazon, \n	BN.com, or your favorite electronic bookseller and order a copy to the\n	classroom, then email a copy of the receipt (feel free to delete your\n	address and other personal info first!) to\n	<a href=\"mailto:freelittlebrother@gmail.com\">freelittlebrother@gmail.com</a> \n	so that Olga can mark that copy as sent. If you don\'t want to be publicly \n	acknowledged for your generosity, let us know and we\'ll keep you \n	anonymous, otherwise we\'ll thank you on the donate page.\n</p>\n\n<p>	I have no idea if this will end up with hundreds, dozens or just a few\n	copies going out -- but I have high hopes!\n</p>\n','2015-11-11 19:02:09');
/*!40000 ALTER TABLE `newsletter_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsletter_template`
--

DROP TABLE IF EXISTS `newsletter_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletter_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `filename` varchar(100) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsletter_template`
--

LOCK TABLES `newsletter_template` WRITE;
/*!40000 ALTER TABLE `newsletter_template` DISABLE KEYS */;
INSERT INTO `newsletter_template` VALUES (1,'Example newsletter template','example.tt','2015-11-11 19:02:09');
/*!40000 ALTER TABLE `newsletter_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsletter_template_element`
--

DROP TABLE IF EXISTS `newsletter_template_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `newsletter_template_element` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'Short Text',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `newsletter_template_element_idx_template` (`template`),
  CONSTRAINT `newsletter_template_element_fk_template` FOREIGN KEY (`template`) REFERENCES `newsletter_template` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsletter_template_element`
--

LOCK TABLES `newsletter_template_element` WRITE;
/*!40000 ALTER TABLE `newsletter_template_element` DISABLE KEYS */;
INSERT INTO `newsletter_template_element` VALUES (1,1,'body','HTML','2015-11-11 19:02:09');
/*!40000 ALTER TABLE `newsletter_template_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session` char(72) DEFAULT NULL,
  `user` int(11) DEFAULT NULL,
  `email` varchar(250) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `billing_address` text NOT NULL,
  `billing_town` varchar(100) NOT NULL,
  `billing_county` varchar(50) DEFAULT NULL,
  `billing_country` varchar(50) NOT NULL,
  `billing_postcode` varchar(10) NOT NULL,
  `delivery_address` text,
  `delivery_town` varchar(100) DEFAULT NULL,
  `delivery_county` varchar(50) DEFAULT NULL,
  `delivery_country` varchar(50) DEFAULT NULL,
  `delivery_postcode` varchar(10) DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Checkout incomplete',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT NULL,
  `despatched` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_idx_session` (`session`),
  KEY `order_idx_user` (`user`),
  CONSTRAINT `order_fk_session` FOREIGN KEY (`session`) REFERENCES `session` (`id`),
  CONSTRAINT `order_fk_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '1',
  `unit_price` decimal(9,2) NOT NULL DEFAULT '0.00',
  `postage` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_item_idx_item` (`item`),
  KEY `order_item_idx_order` (`order`),
  KEY `order_item_idx_postage` (`postage`),
  CONSTRAINT `order_item_fk_item` FOREIGN KEY (`item`) REFERENCES `shop_item` (`id`),
  CONSTRAINT `order_item_fk_order` FOREIGN KEY (`order`) REFERENCES `order` (`id`),
  CONSTRAINT `order_item_fk_postage` FOREIGN KEY (`postage`) REFERENCES `postage_option` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item_attribute`
--

DROP TABLE IF EXISTS `order_item_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_item_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_item_attribute_idx_item` (`item`),
  CONSTRAINT `order_item_attribute_fk_item` FOREIGN KEY (`item`) REFERENCES `order_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item_attribute`
--

LOCK TABLES `order_item_attribute` WRITE;
/*!40000 ALTER TABLE `order_item_attribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_item_attribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paid_list`
--

DROP TABLE IF EXISTS `paid_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paid_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `url_name` varchar(100) NOT NULL,
  `description` text,
  `mailing_list` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paid_list`
--

LOCK TABLES `paid_list` WRITE;
/*!40000 ALTER TABLE `paid_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `paid_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paid_list_email`
--

DROP TABLE IF EXISTS `paid_list_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paid_list_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paid_list` int(11) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `template` int(11) NOT NULL,
  `delay` int(11) NOT NULL,
  `plaintext` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `paid_list_email_idx_paid_list` (`paid_list`),
  KEY `paid_list_email_idx_template` (`template`),
  CONSTRAINT `paid_list_email_fk_paid_list` FOREIGN KEY (`paid_list`) REFERENCES `paid_list` (`id`),
  CONSTRAINT `paid_list_email_fk_template` FOREIGN KEY (`template`) REFERENCES `newsletter_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paid_list_email`
--

LOCK TABLES `paid_list_email` WRITE;
/*!40000 ALTER TABLE `paid_list_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `paid_list_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paid_list_email_element`
--

DROP TABLE IF EXISTS `paid_list_email_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paid_list_email_element` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'Short Text',
  `content` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `paid_list_email_element_idx_email` (`email`),
  CONSTRAINT `paid_list_email_element_fk_email` FOREIGN KEY (`email`) REFERENCES `paid_list_email` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paid_list_email_element`
--

LOCK TABLES `paid_list_email_element` WRITE;
/*!40000 ALTER TABLE `paid_list_email_element` DISABLE KEYS */;
/*!40000 ALTER TABLE `paid_list_email_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll_anon_vote`
--

DROP TABLE IF EXISTS `poll_anon_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_anon_vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` int(11) NOT NULL,
  `answer` int(11) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `poll_anon_vote_idx_answer` (`answer`),
  KEY `poll_anon_vote_idx_question` (`question`),
  CONSTRAINT `poll_anon_vote_fk_answer` FOREIGN KEY (`answer`) REFERENCES `poll_answer` (`id`),
  CONSTRAINT `poll_anon_vote_fk_question` FOREIGN KEY (`question`) REFERENCES `poll_question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll_anon_vote`
--

LOCK TABLES `poll_anon_vote` WRITE;
/*!40000 ALTER TABLE `poll_anon_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `poll_anon_vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll_answer`
--

DROP TABLE IF EXISTS `poll_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` int(11) NOT NULL,
  `answer` varchar(100) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `poll_answer_idx_question` (`question`),
  CONSTRAINT `poll_answer_fk_question` FOREIGN KEY (`question`) REFERENCES `poll_question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll_answer`
--

LOCK TABLES `poll_answer` WRITE;
/*!40000 ALTER TABLE `poll_answer` DISABLE KEYS */;
INSERT INTO `poll_answer` VALUES (1,1,'Here','2015-11-11 19:02:14'),(2,1,'There','2015-11-11 19:02:14');
/*!40000 ALTER TABLE `poll_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll_question`
--

DROP TABLE IF EXISTS `poll_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(100) NOT NULL,
  `hidden` tinyint(4) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll_question`
--

LOCK TABLES `poll_question` WRITE;
/*!40000 ALTER TABLE `poll_question` DISABLE KEYS */;
INSERT INTO `poll_question` VALUES (1,'Poll goes where?',0,'2015-11-11 19:02:14');
/*!40000 ALTER TABLE `poll_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll_user_vote`
--

DROP TABLE IF EXISTS `poll_user_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_user_vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` int(11) NOT NULL,
  `answer` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `poll_user_vote_idx_answer` (`answer`),
  KEY `poll_user_vote_idx_question` (`question`),
  KEY `poll_user_vote_idx_user` (`user`),
  CONSTRAINT `poll_user_vote_fk_answer` FOREIGN KEY (`answer`) REFERENCES `poll_answer` (`id`),
  CONSTRAINT `poll_user_vote_fk_question` FOREIGN KEY (`question`) REFERENCES `poll_question` (`id`),
  CONSTRAINT `poll_user_vote_fk_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll_user_vote`
--

LOCK TABLES `poll_user_vote` WRITE;
/*!40000 ALTER TABLE `poll_user_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `poll_user_vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postage_option`
--

DROP TABLE IF EXISTS `postage_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `postage_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `price` decimal(9,2) NOT NULL DEFAULT '0.00',
  `description` text,
  `hidden` tinyint(4) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postage_option`
--

LOCK TABLES `postage_option` WRITE;
/*!40000 ALTER TABLE `postage_option` DISABLE KEYS */;
INSERT INTO `postage_option` VALUES (1,'Standard',2.22,NULL,0,'2015-11-11 19:02:07'),(2,'Special',3.33,NULL,0,'2015-11-11 19:02:07'),(3,'Gold',5.55,NULL,0,'2015-11-11 19:02:07');
/*!40000 ALTER TABLE `postage_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queued_email`
--

DROP TABLE IF EXISTS `queued_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queued_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` int(11) NOT NULL,
  `recipient` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `send` datetime NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Not sent',
  PRIMARY KEY (`id`),
  KEY `queued_email_idx_email` (`email`),
  KEY `queued_email_idx_recipient` (`recipient`),
  CONSTRAINT `queued_email_fk_email` FOREIGN KEY (`email`) REFERENCES `autoresponder_email` (`id`),
  CONSTRAINT `queued_email_fk_recipient` FOREIGN KEY (`recipient`) REFERENCES `mail_recipient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queued_email`
--

LOCK TABLES `queued_email` WRITE;
/*!40000 ALTER TABLE `queued_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `queued_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queued_paid_email`
--

DROP TABLE IF EXISTS `queued_paid_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queued_paid_email` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` int(11) NOT NULL,
  `recipient` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `send` datetime NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Not sent',
  PRIMARY KEY (`id`),
  KEY `queued_paid_email_idx_email` (`email`),
  KEY `queued_paid_email_idx_recipient` (`recipient`),
  CONSTRAINT `queued_paid_email_fk_email` FOREIGN KEY (`email`) REFERENCES `paid_list_email` (`id`),
  CONSTRAINT `queued_paid_email_fk_recipient` FOREIGN KEY (`recipient`) REFERENCES `mail_recipient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queued_paid_email`
--

LOCK TABLES `queued_paid_email` WRITE;
/*!40000 ALTER TABLE `queued_paid_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `queued_paid_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(50) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'CMS Page Editor','2015-11-11 19:01:48'),(2,'CMS Page Admin','2015-11-11 19:01:48'),(3,'CMS Template Admin','2015-11-11 19:01:48'),(4,'CMS Form Admin','2015-11-11 19:01:48'),(5,'Shared Content Editor','2015-11-11 19:01:48'),(6,'File Admin','2015-11-11 19:01:48'),(7,'News Admin','2015-11-11 19:01:48'),(8,'Blog Author','2015-11-11 19:01:48'),(9,'Blog Admin','2015-11-11 19:01:48'),(10,'Forums Admin','2015-11-11 19:01:48'),(11,'Comment Moderator','2015-11-11 19:01:48'),(12,'Poll Admin','2015-11-11 19:01:48'),(13,'Events Admin','2015-11-11 19:01:48'),(14,'Shop Admin','2015-11-11 19:01:48'),(15,'Newsletter Admin','2015-11-11 19:01:48'),(16,'Newsletter Template Admin','2015-11-11 19:01:48'),(17,'User Admin','2015-11-11 19:01:48');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `id` char(72) NOT NULL DEFAULT '',
  `session_data` text,
  `expires` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shared_content`
--

DROP TABLE IF EXISTS `shared_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shared_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'Short Text',
  `content` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shared_content`
--

LOCK TABLES `shared_content` WRITE;
/*!40000 ALTER TABLE `shared_content` DISABLE KEYS */;
INSERT INTO `shared_content` VALUES (1,'site_tagline','Short Text','Clean and simple content management.','2015-11-11 19:01:53'),(2,'powered_by','Long Text','Powered by <a href=\"http://shinycms.org/\">ShinyCMS</a>','2015-11-11 19:01:53');
/*!40000 ALTER TABLE `shared_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_category`
--

DROP TABLE IF EXISTS `shop_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `url_name` varchar(100) NOT NULL,
  `description` text,
  `hidden` tinyint(4) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `shop_category_url_name` (`url_name`),
  KEY `shop_category_idx_parent` (`parent`),
  CONSTRAINT `shop_category_fk_parent` FOREIGN KEY (`parent`) REFERENCES `shop_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_category`
--

LOCK TABLES `shop_category` WRITE;
/*!40000 ALTER TABLE `shop_category` DISABLE KEYS */;
INSERT INTO `shop_category` VALUES (1,NULL,'Widgets','widgets','This is the widgets section.',0,'2015-11-11 19:02:07'),(2,NULL,'Doodahs','doodahs','This is the doodahs section.',0,'2015-11-11 19:02:07'),(3,1,'Ambidextrous Widgets','ambi-widgets','This is the section for ambidextrous widgets.',0,'2015-11-11 19:02:07');
/*!40000 ALTER TABLE `shop_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_item`
--

DROP TABLE IF EXISTS `shop_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_type` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `code` varchar(100) NOT NULL,
  `description` text,
  `image` varchar(200) DEFAULT NULL,
  `price` decimal(9,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `restock_date` datetime DEFAULT NULL,
  `hidden` tinyint(4) NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT NULL,
  `discussion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `shop_item_product_code` (`code`),
  KEY `shop_item_idx_discussion` (`discussion`),
  KEY `shop_item_idx_product_type` (`product_type`),
  CONSTRAINT `shop_item_fk_discussion` FOREIGN KEY (`discussion`) REFERENCES `discussion` (`id`),
  CONSTRAINT `shop_item_fk_product_type` FOREIGN KEY (`product_type`) REFERENCES `shop_product_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_item`
--

LOCK TABLES `shop_item` WRITE;
/*!40000 ALTER TABLE `shop_item` DISABLE KEYS */;
INSERT INTO `shop_item` VALUES (1,1,'Blue left-handed widget','blue-lh-widget','A blue widget, suitable for left-handed applications.','blue-dog.jpg',3.14,NULL,NULL,0,'2015-11-11 19:02:07',NULL,14),(2,2,'Red right-handed widget','red-rh-widget','A red widget, suitable for right-handed applications.','redphanatic.jpg',2.72,NULL,NULL,0,'2015-11-11 19:02:07',NULL,15),(3,1,'Green ambidextrous widget','green-ambi-widget','A green widget; swings both ways.','razer.jpg',1.23,NULL,NULL,0,'2015-11-11 19:02:07',NULL,16),(4,3,'Green T-shirt','green-t-shirt','T-shirt with green design.','razer.jpg',5.15,NULL,NULL,0,'2015-11-11 19:02:07',NULL,NULL);
/*!40000 ALTER TABLE `shop_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_item_category`
--

DROP TABLE IF EXISTS `shop_item_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_item_category` (
  `item` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`item`,`category`),
  KEY `shop_item_category_idx_category` (`category`),
  KEY `shop_item_category_idx_item` (`item`),
  CONSTRAINT `shop_item_category_fk_category` FOREIGN KEY (`category`) REFERENCES `shop_category` (`id`),
  CONSTRAINT `shop_item_category_fk_item` FOREIGN KEY (`item`) REFERENCES `shop_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_item_category`
--

LOCK TABLES `shop_item_category` WRITE;
/*!40000 ALTER TABLE `shop_item_category` DISABLE KEYS */;
INSERT INTO `shop_item_category` VALUES (1,1,'2015-11-11 19:02:07'),(2,1,'2015-11-11 19:02:07'),(3,1,'2015-11-11 19:02:07'),(3,3,'2015-11-11 19:02:07');
/*!40000 ALTER TABLE `shop_item_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_item_element`
--

DROP TABLE IF EXISTS `shop_item_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_item_element` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'Short Text',
  `content` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `shop_item_element_idx_item` (`item`),
  CONSTRAINT `shop_item_element_fk_item` FOREIGN KEY (`item`) REFERENCES `shop_item` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_item_element`
--

LOCK TABLES `shop_item_element` WRITE;
/*!40000 ALTER TABLE `shop_item_element` DISABLE KEYS */;
INSERT INTO `shop_item_element` VALUES (1,1,'paypal_button','Long Text','<form target=\"paypal\" action=\"https://www.paypal.com/cgi-bin/webscr\" method=\"post\">\n<input type=\"hidden\" name=\"cmd\" value=\"_s-xclick\">\n<input type=\"hidden\" name=\"hosted_button_id\" value=\"8299526\">\n<input type=\"image\" src=\"https://www.paypal.com/en_GB/i/btn/btn_cart_LG.gif\" border=\"0\" name=\"submit\" alt=\"PayPal - The safer, easier way to pay online.\">\n<img alt=\"\" border=\"0\" src=\"https://www.paypal.com/en_GB/i/scr/pixel.gif\" width=\"1\" height=\"1\">\n</form>\n','2015-11-11 19:02:07'),(2,2,'paypal_button','Long Text','<form target=\"paypal\" action=\"https://www.paypal.com/cgi-bin/webscr\" method=\"post\">\n<input type=\"hidden\" name=\"cmd\" value=\"_s-xclick\">\n<input type=\"hidden\" name=\"hosted_button_id\" value=\"8299566\">\n<input type=\"image\" src=\"https://www.paypal.com/en_GB/i/btn/btn_cart_LG.gif\" border=\"0\" name=\"submit\" alt=\"PayPal - The safer, easier way to pay online.\">\n<img alt=\"\" border=\"0\" src=\"https://www.paypal.com/en_GB/i/scr/pixel.gif\" width=\"1\" height=\"1\">\n</form>\n','2015-11-11 19:02:07'),(3,4,'sizes','Short Text','Small,Medium,Large','2015-11-11 19:02:07'),(4,4,'colours','Short Text','Black,Blacker,Blackest','2015-11-11 19:02:07');
/*!40000 ALTER TABLE `shop_item_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_item_favourite`
--

DROP TABLE IF EXISTS `shop_item_favourite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_item_favourite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` int(11) NOT NULL,
  `user` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `shop_item_favourite_idx_item` (`item`),
  KEY `shop_item_favourite_idx_user` (`user`),
  CONSTRAINT `shop_item_favourite_fk_item` FOREIGN KEY (`item`) REFERENCES `shop_item` (`id`),
  CONSTRAINT `shop_item_favourite_fk_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_item_favourite`
--

LOCK TABLES `shop_item_favourite` WRITE;
/*!40000 ALTER TABLE `shop_item_favourite` DISABLE KEYS */;
/*!40000 ALTER TABLE `shop_item_favourite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_item_like`
--

DROP TABLE IF EXISTS `shop_item_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_item_like` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` int(11) NOT NULL,
  `user` int(11) DEFAULT NULL,
  `ip_address` varchar(15) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `shop_item_like_idx_item` (`item`),
  KEY `shop_item_like_idx_user` (`user`),
  CONSTRAINT `shop_item_like_fk_item` FOREIGN KEY (`item`) REFERENCES `shop_item` (`id`),
  CONSTRAINT `shop_item_like_fk_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_item_like`
--

LOCK TABLES `shop_item_like` WRITE;
/*!40000 ALTER TABLE `shop_item_like` DISABLE KEYS */;
/*!40000 ALTER TABLE `shop_item_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_item_postage_option`
--

DROP TABLE IF EXISTS `shop_item_postage_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_item_postage_option` (
  `item` int(11) NOT NULL,
  `postage` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`item`,`postage`),
  KEY `shop_item_postage_option_idx_item` (`item`),
  KEY `shop_item_postage_option_idx_postage` (`postage`),
  CONSTRAINT `shop_item_postage_option_fk_item` FOREIGN KEY (`item`) REFERENCES `shop_item` (`id`),
  CONSTRAINT `shop_item_postage_option_fk_postage` FOREIGN KEY (`postage`) REFERENCES `postage_option` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_item_postage_option`
--

LOCK TABLES `shop_item_postage_option` WRITE;
/*!40000 ALTER TABLE `shop_item_postage_option` DISABLE KEYS */;
INSERT INTO `shop_item_postage_option` VALUES (1,1,'2015-11-11 19:02:07'),(1,2,'2015-11-11 19:02:07'),(1,3,'2015-11-11 19:02:07'),(2,1,'2015-11-11 19:02:07'),(2,2,'2015-11-11 19:02:07'),(2,3,'2015-11-11 19:02:07'),(3,1,'2015-11-11 19:02:07'),(3,2,'2015-11-11 19:02:07'),(3,3,'2015-11-11 19:02:07'),(4,2,'2015-11-11 19:02:07'),(4,3,'2015-11-11 19:02:07');
/*!40000 ALTER TABLE `shop_item_postage_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_item_view`
--

DROP TABLE IF EXISTS `shop_item_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_item_view` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` int(11) NOT NULL,
  `user` int(11) DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `shop_item_view_idx_item` (`item`),
  KEY `shop_item_view_idx_user` (`user`),
  CONSTRAINT `shop_item_view_fk_item` FOREIGN KEY (`item`) REFERENCES `shop_item` (`id`),
  CONSTRAINT `shop_item_view_fk_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_item_view`
--

LOCK TABLES `shop_item_view` WRITE;
/*!40000 ALTER TABLE `shop_item_view` DISABLE KEYS */;
/*!40000 ALTER TABLE `shop_item_view` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_product_type`
--

DROP TABLE IF EXISTS `shop_product_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_product_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `template_file` varchar(100) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_product_type`
--

LOCK TABLES `shop_product_type` WRITE;
/*!40000 ALTER TABLE `shop_product_type` DISABLE KEYS */;
INSERT INTO `shop_product_type` VALUES (1,'Standard','standard.tt','2015-11-11 19:02:07'),(2,'Paypal','paypal.tt','2015-11-11 19:02:07'),(3,'T-shirt','t-shirt.tt','2015-11-11 19:02:07');
/*!40000 ALTER TABLE `shop_product_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_product_type_element`
--

DROP TABLE IF EXISTS `shop_product_type_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shop_product_type_element` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_type` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'Short Text',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `shop_product_type_element_idx_product_type` (`product_type`),
  CONSTRAINT `shop_product_type_element_fk_product_type` FOREIGN KEY (`product_type`) REFERENCES `shop_product_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_product_type_element`
--

LOCK TABLES `shop_product_type_element` WRITE;
/*!40000 ALTER TABLE `shop_product_type_element` DISABLE KEYS */;
INSERT INTO `shop_product_type_element` VALUES (1,2,'paypal_button','Long Text','2015-11-11 19:02:07'),(2,3,'sizes','Short Text','2015-11-11 19:02:07'),(3,3,'colours','Short Text','2015-11-11 19:02:07');
/*!40000 ALTER TABLE `shop_product_type_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `list` int(11) NOT NULL,
  `recipient` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `subscription_idx_list` (`list`),
  KEY `subscription_idx_recipient` (`recipient`),
  CONSTRAINT `subscription_fk_list` FOREIGN KEY (`list`) REFERENCES `mailing_list` (`id`),
  CONSTRAINT `subscription_fk_recipient` FOREIGN KEY (`recipient`) REFERENCES `mail_recipient` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription`
--

LOCK TABLES `subscription` WRITE;
/*!40000 ALTER TABLE `subscription` DISABLE KEYS */;
INSERT INTO `subscription` VALUES (1,1,1,'2015-11-11 19:02:09'),(2,1,2,'2015-11-11 19:02:09'),(3,1,3,'2015-11-11 19:02:09'),(4,2,4,'2015-11-11 19:02:09');
/*!40000 ALTER TABLE `subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `tag` varchar(50) NOT NULL,
  `tagset` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tag`,`tagset`),
  KEY `tag_idx_tagset` (`tagset`),
  CONSTRAINT `tag_fk_tagset` FOREIGN KEY (`tagset`) REFERENCES `tagset` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES ('armed forces',6,'2015-11-11 19:02:01'),('cell',8,'2015-11-11 19:02:01'),('crowds',4,'2015-11-11 19:02:01'),('explosions',3,'2015-11-11 19:02:01'),('interview',7,'2015-11-11 19:02:01'),('interview',9,'2015-11-11 19:02:01'),('interview',10,'2015-11-11 19:02:01'),('interview',11,'2015-11-11 19:02:01'),('interview',12,'2015-11-11 19:02:01'),('paperwork',12,'2015-11-11 19:02:01'),('phone',7,'2015-11-11 19:02:01'),('phone',10,'2015-11-11 19:02:01'),('prison',8,'2015-11-11 19:02:01'),('prison',9,'2015-11-11 19:02:01'),('school',1,'2015-11-11 19:02:01'),('school',2,'2015-11-11 19:02:01'),('sirens',3,'2015-11-11 19:02:01'),('surveillance',2,'2015-11-11 19:02:01'),('terrorism',5,'2015-11-11 19:02:01'),('terrorism',7,'2015-11-11 19:02:01'),('test',14,'2015-11-11 19:02:04'),('toilet break',6,'2015-11-11 19:02:01'),('truck',6,'2015-11-11 19:02:01'),('truck',7,'2015-11-11 19:02:01'),('truck',13,'2015-11-11 19:02:01'),('USA',6,'2015-11-11 19:02:01'),('yard',11,'2015-11-11 19:02:01');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tagset`
--

DROP TABLE IF EXISTS `tagset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tagset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL,
  `resource_type` varchar(50) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagset`
--

LOCK TABLES `tagset` WRITE;
/*!40000 ALTER TABLE `tagset` DISABLE KEYS */;
INSERT INTO `tagset` VALUES (1,1,'BlogPost','2015-11-11 19:02:01'),(2,2,'BlogPost','2015-11-11 19:02:01'),(3,3,'BlogPost','2015-11-11 19:02:01'),(4,4,'BlogPost','2015-11-11 19:02:01'),(5,5,'BlogPost','2015-11-11 19:02:01'),(6,6,'BlogPost','2015-11-11 19:02:01'),(7,7,'BlogPost','2015-11-11 19:02:01'),(8,8,'BlogPost','2015-11-11 19:02:01'),(9,9,'BlogPost','2015-11-11 19:02:01'),(10,10,'BlogPost','2015-11-11 19:02:01'),(11,11,'BlogPost','2015-11-11 19:02:01'),(12,12,'BlogPost','2015-11-11 19:02:01'),(13,13,'BlogPost','2015-11-11 19:02:01'),(14,1,'ForumPost','2015-11-11 19:02:04');
/*!40000 ALTER TABLE `tagset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_log`
--

DROP TABLE IF EXISTS `transaction_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logged` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) NOT NULL,
  `notes` text,
  `user` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_log_idx_user` (`user`),
  CONSTRAINT `transaction_log_fk_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_log`
--

LOCK TABLES `transaction_log` WRITE;
/*!40000 ALTER TABLE `transaction_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(74) NOT NULL,
  `email` varchar(200) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `surname` varchar(50) DEFAULT NULL,
  `display_name` varchar(100) DEFAULT NULL,
  `display_email` varchar(200) DEFAULT NULL,
  `website` varchar(200) DEFAULT NULL,
  `profile_pic` varchar(100) DEFAULT NULL,
  `bio` text,
  `location` varchar(100) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `admin_notes` text,
  `discussion` int(11) DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  `forgot_password` tinyint(4) DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_username` (`username`),
  KEY `user_idx_discussion` (`discussion`),
  CONSTRAINT `user_fk_discussion` FOREIGN KEY (`discussion`) REFERENCES `discussion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','a2adc857997332af84fb9bd1036b677c8b398f17511d681cfc7f094fb8a00601ZwDmy6JPqG','changeme@example.com','Default','Admin','Admin',NULL,NULL,NULL,NULL,NULL,NULL,'This is the default admin user account.  Please either remove it before putting your site online, or at least make sure that you change the password - and preferably, change the username too!',NULL,1,0,'2015-11-11 19:01:48'),(2,'trevor','f569e47bc2bab4ecdd2c496932dfd633dc977813012abc92283dbe8ee2fecad30Jg+sbSGFw','trevor@example.com','Trevor','McDonald',NULL,NULL,NULL,NULL,NULL,'London, England',NULL,'Part of the news demo data.',NULL,1,0,'2015-11-11 19:01:58'),(3,'w1n5t0n','23a73e39e99ec5adcff0f483109282f82ba0190df511bfc977cfd02068b4309f4Gp0+2nVbA','w1n5t0n@example.com','Marcus','Yarrow',NULL,NULL,NULL,NULL,NULL,'San Francisco',NULL,'Part of the Little Brother blog demo data.',NULL,1,0,'2015-11-11 19:02:00');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_access`
--

DROP TABLE IF EXISTS `user_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_access` (
  `user` int(11) NOT NULL,
  `access` int(11) NOT NULL,
  `subscription_id` varchar(50) DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `recurring` int(11) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user`,`access`),
  KEY `user_access_idx_access` (`access`),
  KEY `user_access_idx_user` (`user`),
  CONSTRAINT `user_access_fk_access` FOREIGN KEY (`access`) REFERENCES `access` (`id`),
  CONSTRAINT `user_access_fk_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_access`
--

LOCK TABLES `user_access` WRITE;
/*!40000 ALTER TABLE `user_access` DISABLE KEYS */;
INSERT INTO `user_access` VALUES (1,1,NULL,NULL,NULL,'2015-11-11 19:01:55');
/*!40000 ALTER TABLE `user_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_login`
--

DROP TABLE IF EXISTS `user_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_login_idx_user` (`user`),
  CONSTRAINT `user_login_fk_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_login`
--

LOCK TABLES `user_login` WRITE;
/*!40000 ALTER TABLE `user_login` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `user` int(11) NOT NULL,
  `role` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user`,`role`),
  KEY `user_role_idx_role` (`role`),
  KEY `user_role_idx_user` (`user`),
  CONSTRAINT `user_role_fk_role` FOREIGN KEY (`role`) REFERENCES `role` (`id`),
  CONSTRAINT `user_role_fk_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,1,'2015-11-11 19:01:48'),(1,2,'2015-11-11 19:01:48'),(1,3,'2015-11-11 19:01:48'),(1,4,'2015-11-11 19:01:48'),(1,5,'2015-11-11 19:01:48'),(1,6,'2015-11-11 19:01:48'),(1,7,'2015-11-11 19:01:48'),(1,8,'2015-11-11 19:01:48'),(1,9,'2015-11-11 19:01:48'),(1,10,'2015-11-11 19:01:48'),(1,11,'2015-11-11 19:01:48'),(1,12,'2015-11-11 19:01:48'),(1,13,'2015-11-11 19:01:48'),(1,14,'2015-11-11 19:01:48'),(1,15,'2015-11-11 19:01:48'),(1,16,'2015-11-11 19:01:48'),(1,17,'2015-11-11 19:01:48'),(2,7,'2015-11-11 19:01:58'),(3,8,'2015-11-11 19:02:00');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-11 21:46:36
