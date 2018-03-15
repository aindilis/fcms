(Make it so that it can load different items, and the ones we
 don't want to include, we can break the symlink to them, and
 those files won't be included.  Refactor all the logic into FCMS
 itself.  In a secure KB keep the names of different systems, and
 create the ability to assert ids of different systems as part of
 things like assertedTask1,
 i.e. task(system(id108513,assertedTask1),...) or something.
 Then keep track of which systems forked and so on.  This way
 different systems can have different tasks.  Keep a central git
 repo.  Include: FRDCSA.org, FRDCSA.com, ByteLibrary.com,
 FreeLifePlanner.org in it.  make it so that the symlink which
 chooses which site to run and other metasite configuration
 information is not in the git repo itself so that info won't be
 changed everytime we commit from a different site repo.)

(possible things to create
 (make an interface to our to.do files)
 (make a list of all appointments, no matter how far out, sorted
  in order of soonest)
 (integrate flux to choose upcoming appointments)
 (use KState to model the state of the user's knowledge regarding
  appointments and such)
 (query manager for the times I'm expected to go to bed and awake)
 (add a thing that lists all the daily things, and gives us an
  opportunity to mark when they have been done.  do not assume
  that the time recorded is the time completed.)
 (integrate what-to-do)
 (integrate world state monitor, using FLUX syntax, to represent
  the current world state, have FCMS interface for this)
 (have the world state queried through the Verber::Federated::WSM
  module)
 (Add stuff to the planning domain to take into account the
  things we have to do for meds and teeth brushing etc)
 (integrate flux and have it use WSM to calculate it's moves,
  import temporal plan as needed, store to wsm as needed, which is
  integrated with Verber::Federated::WSM) )

(create a form that submits the value from the Task_Manager.html
 using POST, and have a processor that processes it.  When it is
 processed it is from the FCMS agent to the Test / WSM agent,
 with instructions to kassert into the WSM.  Then, have the form
 load display the result by querying Guardian probably or
 something.  Add stuff to the form for the user to submit
 different kinds of things, different submit buttons or options.
 Including a calendar to set the date, similar to SPSE2.)


(have it so that we can record new task assertions)

(read up on access control)

(integrate permissions)

(integrate the task manager)

(Set it up so that we can query SPSE2 modes from a prolog
 compatibility option that integrates SPSE2 domains, with contexts
 as modules, and that handles the date reasoning.)


(FreeLifePlanner: come up with dashboard for bills and show all
 things.  also make crises first class objects and treated, like
 contingencies.)
(look into Service Contracts in Logic Programming formalisms for
 Resource-Manager. e.g. RBSLA)
(FreeLifePlanner use case: surviving a war)

(for the life planner have different degrees of usage: beginner,
 intermediate, advanced, etc.  then have a permissions system for
 such)

(for abilities unilang have a stream of the chatter on it, with
 different log visualization abilities)

(use a web based version of graphviz in order to visualize the
 contigency planning action trees.)

(make it so that, if an agent is going to consume a lot of the
 available resources or time, it checks first with the user -
 i.e. software-finder)

(make an editor for creating new planning actions from the
 webbrowser)
