# Manage Docker Development with Bash
The code in this directory is an example of how to test drive bash scripts that
will assist in developing dockers. The docker for this example is `sonatype/nexus`.
Nexus was chosen because the artifacts should be stored on a mapped volume
and the is a web interface on port 8080.

The problem to solve is as follows:

A running docker container provides a service that should not be interrupted
until a new version of the image is fully tested. Two bash scripts are to be
written. One to build the image and the second to run the container.

## assumptions
- The volume to be mounted for the release container has been setup with the
  correct permissions so that artifacts can be written to it from the user
  inside the container. (uid = 200. on a Mac this is the `_softwareupdate` user.)

## buildDockerImage script
The requirements for the buildDockerImage script are:
- print a help message when `-h` is passed on the command line
- by default create a dev image
- the dev image should not overwrite the latest dev image
- the latest dev image should be retagged as previous
- if a previous image exists, and a container is using it, then check
  if the running container is a dev container.
  - if the running container is the dev container, the stop and remove the container.
  - if the running container is the release container, there is no problem
    since there is a release image to support the release container.
- remove the previous image, if it exists (this happens after the container checks
  listed above)
- when `-r` is passed to the script, then a release image is created.
- the release image should not overwrite the latest release image, which is the
  image for the running container.
- the latest release image should be retagged as previous.
- if the previous release image exists, remove it.

## runDockerContainer script
The requirements for the runDockerContainer script are:
- print a help message when `-h` is passed on the command line
- by default create a dev container
- the dev container must not map any volumes
- the dev container must map ports not used by release
- if an existing dev container is running, stop and remove it
- the dev container will not run as a daemon so that all docker log messages
  will be shown in the command window
- when `-r` is passed to the script, then a release container is started
  after the currently running release container is stopped and removed.
- the release container runs as a daemon
- the release container has volume mapping
- the release container has default port mappings
