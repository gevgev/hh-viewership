#!/bin/sh
set -x

sudo mkdir /data
sudo chown ec2-user:ec2-user /data
sudo yum install -y tree
