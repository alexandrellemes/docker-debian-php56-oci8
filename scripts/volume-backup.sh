#!/bin/bash
# This script allows you to backup a single volume from a container
# Data in given volume is saved in the current directory in a tar archive.
CONTAINER_NAME=$1
VOLUME_NAME=$2

usage() {
  echo "Usage: $0 [container name] [volume name]"
  exit 1
}

if [ -z $CONTAINER_NAME ]
then
  echo "Error: missing container name parameter."
  usage
fi

if [ -z $VOLUME_NAME ]
then
  echo "Error: missing volume name parameter."
  usage
fi

sudo docker run -it -v $VOLUME_NAME:/volume -v $(pwd)/backup:/backup busybox \
    tar -cjf /backup/$VOLUME_NAME.tar.bz2 -C /volume ./

# 2o exemplo
#sudo docker run -v some_volume:/volume -v /tmp:/backup loomchild/volume-backup backup some_archive

#sudo docker run --rm --volumes-from $CONTAINER_NAME -v $(pwd):/backup busybox tar czvf /backup/backup.tar.gz $VOLUME_NAME
