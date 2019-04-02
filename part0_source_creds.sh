#!/bin/bash
#
# author: Zhepu Zhao
# usage: source ./ansible_gcp_creds.sh

# Constants - CHANGE ME!
export GCP_PROJECT='project name shown on GCP console'
export GCP_AUTH_KIND='serviceaccount'
export GCP_SERVICE_ACCOUNT_FILE='sample_credential.json'
export GCP_SCOPES='https://www.googleapis.com/auth/compute'
