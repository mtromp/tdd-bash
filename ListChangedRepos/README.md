# List Repos with Changes

This bash script go down the directory tree starting at the current directory
and do the following:

- When a directory contains a `.git` directory it will:
  - check the git status and if it has outstanding changes:
    - it will print the full path directory
    - it will print the changes files
    - it will print files that are not under source control as noted by git
  - check the git status and if it is not in sync with remote
    - it will print whether is has unpushed changes
    - it will print if remote has unpulled Changes

## How to run tests

From a terminal session, in the same directory as this README, run the following:
`bundle exec rspec`
