- Make sure anything in master branch is always deployable, and never do edits on master branch (protect it in gitlab)
  - Master branch to start with v0.0.0 till then its empty (start with new branch at begning)
  - If there is an issue with master, revert commits or create new commits. Never roolback or rewound the branch
  - There is no need to create release or develop branch, to work on something new, create a descriptively named branch
  - Consider this feature branch as your release, or develop. Commit to that branch locally and regularly push your work.
  - If the branch has been open for too long and you feel it’s getting out of sync with the master branch, you can merge
    master into your topic branch and keep going.
  - Send pull-requests for feature as WIP or FIN (WIP - just needs review, dont merge. FIN - review, merge, release and close)
  - Once it is merged and pushed to 'master', you can and should deploy immediately to staging (automatically)
  - Sync master, hotfixes and production to feature regularly and during creation on FIN type pull-request (call update-merge)
  - Make sure you always push succefull & updated features or hotfixes only to master.
  - For automated (build + update-merge + testing), one must not build every ref (costly). CI setup should be: - To conduct auto-build, auto-update-merge and auto-testing for desired commit refs as mentioned next points here - Regular (daily or friday) run of 'unbuilt top-most refs of all features' with email to team for confidance building - Keep these artifacts per-feature and expiry within 3-7 days for saving space on CI server - No need to run tests or build regularly setup a topic branch with manual feature built where CI will run when developer
    merge feature to topic branch haivng no access to manual button. - Setup 'daily automated update-merge' with this if developer forgets update-merge manually, their branch will still be good - Pull-request's (build+merge+test) status helps in making decision for next release - No need to test, update-merge and push to master a WIP pull request, to save CPU times - Every FIN pull-request to be proccessed automatically and always - Once approved auto-merge to master for instant staging deploy and auto-close of pull request
    when we push to master. Also merge in safe branch first (master-copy or mixin) [no commits] - If a pull-request is not merged for a period, one has to re-raise for re-merge-update to run - Pull-request artifacts are short-lived even on close, delete or approved to save space - Generate warning if older pull-request is pending for merge (not deleted or closed). Don't allow
    (only allow re-up of pull-request)
    - Deploy only master to staging automatic and always and upwards (uat, pre-prod and prod) - Artifacts from Staging, UAT, Pre-prod & Prod are long lived (1-3 months) to give approver some time - Artifacts Prod (Released / Tagged) with REFs should never be deleted [they're client property] - Do not create seperate branch for Staging+ to avoid merging changes back-and-forth and land into conflicts
    - Carry build REFs (SHAs) in upwards everywhere with release number for easy tracking be everybody
      - Accompany with pull-request id, pipeline/job/build id with SHAs for tracking - Setup a review mechanism with review deployments for features (on-demand) - At just start of build create new branch from feature (mixin) for work-safety (from update-merge) and halt current
        work-feature (locked)
    - Always use a static build enviornment (docker image), infact 3rd party libraries etc can also be dockerized for
      company-wide uniformity
    - Always use a static build runner (non changing version) for protection against related errors. When org wants they
      can update company wide docker-images for build-env, libraries, and build-runners etc.
    - Whenever a build-env, ci-env is upgraded run a dummy redeploy of all released tags (no commits) for future saftey.
      - It's better to tie up a tag (REFs) with docker-compose.yml this way an old tag will build from an old build-env
        and hassle for redeploy of all released tags (you may still run latest release tag for mental happiness)
    - During pre-build latest un-merged master, production & hotfix changes to be merged with work-feature clone-branch
      conflicts if any to be resolved manually, for multi-feature release combine all with master, hotfix, production in
      in clone-branch). Failure of merger to reflect in merge request report.
    - Ensure that latest production (environment as well as configuration is merged with) during this stage for minimum impact
    - Whenever there is new change in master, hotfix, staging ... indicating release update active feature in repository from
      master and resolve conflicts. If this is somehow automated it will be wonderful
    - During the pre-build (prepare) phase changelog to be generated from feature, master, hotfix and production branches
      (although changelog requires manual editing at times slowing the process, try to avoid this by having proper comments)
  - SUCCESS: build success, auto-test success, no merge-conflicts & updated-merge done on mixin (of feature and master-copy)
    - Compilation and building of artifact (preferably docker container, if not zip or tar) is successful without errors
    - All types of tests with build artifact is successful, that includes at least following testing:
      - Artifact Deployment: Like extracting archive, running docker tar or image, deploy msi or environment
      - Automated Testing: Code Quality, Integration (with other modules), Users (Test Classes), & UI Tests (Selenium)
    - All this with update-merge without conflict as well as no merge-to-master conflicts
    - Once 'SUCCESS' pull-request after approval to be merged with master (bearing new release number as single commit
      with 'squash and a new commit' as you don't want to carry feature history to master. It shoudl not be `--no-ff and new commit')
    - Try not to have multiple environments to zero on parity, always have production environment pool area for review, staging and UAT like 'https://staging.example.com'
    - Upon merge in master immediately deploy to stagin (inside production area) with updated production configuration ??
    - Proceed with manual testing of auto-deployed app in staging. Staging onwards everything is manually deployed and tested
    - If failure in production area (staging onwards) like faliure in staging: re-deploy to reset stanging, try hotfix, try redeploy last-working-revision from UI, reset master's commit.
    - Only master branch can be delivered from Staging onwards, that is to UAT, PRE_PROD, & PROD. All deployments after staging is to be manual
    - Everywhere keep latest production configuration while testing (automatic or manual) and deploy in production environment only
    - Keep pushing master upwards manually if test passes till production, when at production create it's clone pre-production for
      final test, thereafter deploy in ginny-pig area to minimize impact for final approval. Once final-approved deploy or rollback
      in production as rolling releases
    - Once released, tag refs in repository with artifact as released (lock for deletion indefinitely)
    - If one is confident enough, this process can be without manual intervention (auto deploy on new-incoming) to be continual
  - Consider having automatically-configured and auto-healed orchestrator, proxy and load balancer in service for seamless fun
  - In case of any minor bug in staging onwards create hotfix from master (and start again by creating pull-request)
