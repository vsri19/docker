# !! Github-Flow ++ !!

- Make sure anything in master branch is always deployable, and never directly-edit master branch (protect it in gitlab)
- Make sure to never create a release or develop branch, Work only one feature at a time & consider it release/develop
- Developers may send pull-requests for `not-ready` code so that admin can review pull request and provide feedbacks.
- If the branch has been open for too long and you feel it’s getting out of sync with the master branch, you can merge
  master into your topic branch and keep going (this can be an automatic daily merge)
- Make sure to always merge only successful feature and hotfixes to master. By successful we mean all of the following
  - Do not build on every commit of feature, start building when a pull request is given specifically for release only
    - To save build time of CPU you can build an unbuilt-feature nightly for developer confidante (include auto-testing here)
      - Keep timer-built artifacts for 2-3 days only for saving storage
    - You must build and auto-test pull-request immediately for ease out decision to move ahead or not
      - Keep pull-request artifacts indefinitely if released (tagged on production)
      - Delete pull-request artifacts if pull-request is deleted (not closed)
      - Generate warning if older pull-request is pending for merge (not deleted or closed) [do not stop process latest only]
      - Allow new pull-request if there is no other pull request in the system.
  - You may setup a review mechanism where review deployments are done for features on demand (includes review deployments)
  - Always make sure to carry following IDs everywhere for tracking: pull-request, pipeline, job and build id etc.
  - At just start of build create a new branch from work-feature for safety and halt current work-feature (locked)
  - I would recommend always using a static build env. for protection against related bugs, if build-env or ci-env is
    upgraded dummy test last released production with same for least parity
  - During pre-build latest un-merged master, production & hotfix changes to be merged with work-feature clone-branch
    (conflicts if any to be resolved manually, for multi-feature release combine all with master, hotfix, production in
    in clone-branch). Failure of merger to reflect in merge request report.
  - Ensure that latest production (environment as well as configuration is merged with) during this stage for minimum impact
  - Whenever there is new change in master, hotfix, staging ... indicating release update active feature in repository from
    master and resolve conflicts. If this is somehow automated it will be wonderful
  - During the pre-build (prepare) phase changelog to be generated from feature, master, hotfix and production branches
    (although changelog requires manual editing at times slowing the process, try to avoid this by having proper comments)
  - Compilation and building of artifact (preferably docker container, if not zip or tar) is successful without errors
  - All types of tests with build artifact is successful, that includes at least following testing:
    - Able to successfully deploy artifact (like extracting archive, running docker tar or image, deploy msi or environment)
  - All automatic tests passed: Code Quality Tests, Integration Tests (with other modules), User Tests (Test Classes), and
    UI Tests (Selenium)
- Once `pull-request` is accepted it needs to be merged to latest copy of `master` branch (_not on master_) and thoroughly checked
  for `no merge-conflicts, build success, test success`. If this `temporary-master` succeeds this pull imay be finally accepted
  and released. This will become a `tag on master now`.
- Once automatic (build + deploy + testing) is successful, work-feature to be merged with master (bearing new release number
  as single commit and no-ff). Master branch will not be build.
  - Try not to have multiple environments to zero on parity, always have production environment pool area for staging and uat.
  - Do not create separate branches for staging, onwards else you've to bear pain of merging (deploy from master and tag when
    production is released)
  - Upon merge in master immediately deploy to staging (in production area) with latest (updated) production configuration.
  - Proceed with manual testing of application in staging area, but if deploy fails revert master to previous commit to reset
    staging
  - Only master branch can be delivered from Staging onwards, that is to UAT, pre-production and production and all deliveries
    should be manually done
    - Everywhere keep latest production configuration while testing (automatic or manual) and deploy in production environment only
    - Keep pushing master upwards manually if test passes till production, when at production create it's clone pre-production for
      final test, thereafter deploy in ginny-pig area to minimize impact for final approval. Once final-approved deploy or rollback
      in production as rolling releases
    - Once released, tag refs in repository with artifact as released (lock for deletion indefinitely)
    - If one is confident enough, this process can be without manual intervention (auto deploy on new-incoming) to be continual
  - Consider having automatically-configured and auto-healed orchestrator, proxy and load balancer in service for seamless fun
  - In case of any minor bug in staging onwards create hotfix from master (and start again by creating pull-request)
