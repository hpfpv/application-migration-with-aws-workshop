#!/bin/bash
# This script will install and configure an S3 bucket as nfs local drive
sudo apt-get update

# Install the s3fs on linux
sudo apt install s3fs awscli -y

# Add the below entry in fstab to set the mount point automatically
#sudo s3fs -o iam_role=auto,endpoint='us-west-2',use_cache=/tmp/s3fs,nonempty houessou-test-s3-nfsmount:/var/www/html/wp-content /var/www/html/wp-content
sudo su
echo "s3fs#REPLACE_ME_NFS_S3_BUCKET:/var/www/html/wp-content /var/www/html/wp-content fuse _netdev,allow_other,endpoint=us-west-2,iam_role=auto,nonempty 0 0" >> /etc/fstab
sed -i "s/REPLACE_ME_NFS_S3_BUCKET/${NFS_S3_BUCKET}/g" /etc/fstab
# Initiate the mount
mount /var/www/html/wp-content -o nonempty,iam_role=auto
exit