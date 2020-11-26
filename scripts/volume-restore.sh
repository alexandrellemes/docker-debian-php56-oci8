#!/bin/bash
# This script allows you to restore a single volume from a container
# Data in restored in volume with same backupped path
VOLUME_NAME=$1

usage() {
  echo "Usage: $0 [volume name]"
  exit 1
}

if [ -z $VOLUME_NAME ]
then
  echo "Error: missing container name parameter."
  usage
fi

sudo docker run -it -v $VOLUME_NAME:/volume -v $(pwd)/backup:/backup busybox \
    sh -c "rm -rf /volume/* /volume/..?* /volume/.[!.]* ; tar -C /volume/ -xjf /backup/$VOLUME_NAME.tar.bz2"

# 2o exemplo
#sudo docker run -v some_volume:/volume -v /tmp:/backup loomchild/volume-backup \
#    restore some_archive

#sudo docker run --rm --volumes-from $NEW_CONTAINER_NAME -v $(pwd):/backup busybox tar xzvf /backup/backup.tar.gz
