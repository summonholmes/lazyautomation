#!/bin/sh

# Dependencies
# * osxfuse
# * ext4fuse

# Substitute /dev/disk2s3 with the appropriate device
sudo ext4fuse /dev/disk2s3 Mount -o allow_other
