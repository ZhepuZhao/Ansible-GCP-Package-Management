#!/bin/bash
#
# author: Zhepu Zhao
# purpose: Create GCP VM instance and associated resources
# usage: sh ./part1_create_vm.sh


# VMs we use
# centos7: https://www.googleapis.com/compute/v1/projects/centos-cloud/global/images/centos-7-v20190326
# debian:  https://www.googleapis.com/compute/v1/projects/debian-cloud/global/images/debian-9-stretch-v20190312
# ubuntu:  https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20190320
# rhel:    https://www.googleapis.com/compute/v1/projects/rhel-cloud/global/images/rhel-7-v20190326 


# Constants - CHANGE ME!
readonly PROJECT='project name shown on GCP console interface'
readonly SERVICE_ACCOUNT='account name in json credential file'
readonly ZONE='us-east1-b'

# Create GCE VM with disk storage
time gcloud compute instances create web-1-ubuntu1804-2 \
  --project $PROJECT \
  --zone $ZONE \
  --machine-type n1-standard-1 \
  --network default \
  --subnet default \
  --network-tier PREMIUM \
  --maintenance-policy MIGRATE \
  --service-account $SERVICE_ACCOUNT \
  --scopes https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
  --tags apache-http-server \
  --image ubuntu-1804-bionic-v20190320 \
  --image-project ubuntu-os-cloud \
  --boot-disk-size 10GB \
  --boot-disk-type pd-standard \
  --boot-disk-device-name compute-disk

# The firewall already exists
# Create firewall rule to allow ingress traffic from port 80
#time gcloud compute firewall-rules create default-allow-http \
#  --project $PROJECT \
#  --description 'Allow HTTP from anywhere' \
#  --direction INGRESS \
#  --priority 1000 \
#  --network default \
#  --action ALLOW \
#  --rules tcp:80 \
#  --source-ranges 0.0.0.0/0 \
#--target-tags apache-http-server
