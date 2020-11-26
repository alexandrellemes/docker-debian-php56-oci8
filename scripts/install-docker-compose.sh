#!/bin/sh
#
# Run docker-compose in a container
#
# This script will attempt to mirror the host paths by using volumes for the
# following paths:
#   * $(pwd)
#   * $(dirname $COMPOSE_FILE) if it's set
#   * $HOME if it's set
#
# You can add additional volumes (or any docker run options) using
# the $COMPOSE_OPTIONS environment variable.
#


set -e

VERSION="1.25.4"
IMAGE="docker/compose:$VERSION"

sudo curl -L https://github.com/docker/compose/releases/download/$VERSION/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose

sudo chmod +x /usr/bin/docker-compose

sudo docker-compose --version
