# Ansible-Manage-GoogleCloudPlatformVMs
Use ansible to manage Vms on GCP(Google Cloud Platform) including creating, os configuration, package installation, and running web demo

## Step #0: Create GCP service account and get GCP credentials
Follow [this link](https://docs.ansible.com/ansible/latest/scenario_guides/guide_gce.html) to create your service account, then download and store the credential file(a `json` file)
- **another way to set environment variables mentioned in the link above**: 
  - create file like `part0_source_creds.sh` in this repo
  - run it by `source part0_source_creds.sh`

Some usefullinks you might need:
- **To know what is service accounts**: [go here](https://cloud.google.com/iam/docs/service-accounts)
- **To under the structure of service accounts**: [go here](https://cloud.google.com/iam/docs/understanding-service-accounts)
- **To create and manage service accounts**: [go here](https://cloud.google.com/iam/docs/creating-managing-service-accounts)

*Make sure you have the permission to create service accounts and keys to that service account.*

1. After downloading the `json` credential file (GCP key for the service account), place it into the directory you want.
(*Usually you probably want to place it under `/etc/ansible` after installing ansible in the Step #2*)
2. generate public and private keys for your working server.(The machine you want to manege the VM instances)

## Step #1: Create VM instances on Google Cloud Platform
Basically, we can create VM instances in 3 ways:
1. create VM instances through **GCP console interface**
2. create VM instances through **shell script** in this repo which is specified in `part1_create_vm.sh`. The script mainly contains 
gcloud command.
   - download and install gcloud sdk
      - [Install tutorial](https://cloud.google.com/sdk/docs/#rpm)
      - `gcloud init`
      - Open the link from the prompt info in the browser
      - Enter the verification code in the browser
      - To get the absolute URIs of the available images: `gcloud compute images list --uri`
   - create a `.sh` file like `part1_create_vm.sh`
      - Specify image and image-project in it(Debian is the default one is the image is not found)
      - If you didn't install firewalls yet, uncomment the firewall code blocks.
   - run `sh /directoryOfYourShellScriptFile/part1_create_vm.sh`
3. create VM instances through **ansible playbook**(a `.yml` file). I am working on it right now to replace the shell script since 
we want to only use ansible to implement the functionality.

## Step #2: Install ansible
There are many ways to install ansible. [Go here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) 
to learn different ways to install ansible on different Operating Systems.
Here are some ways you might want to use based on your OS:
- CentOS / RHEL: `sudo yum install ansible`
- Fedora: `sudo dnf install ansible`
- Ubuntu / Debian: 
  - `sudo apt-get update`
  - `sudo apt-get install software-properties-common`
  - `sudo apt-add-repository --yes --update ppa:ansible/ansible`
  - `sudo apt-get install ansible`
- Debian:
  - `sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367`
  - `sudo apt-get update`
  - `sudo apt-get install ansible`
- Another general way: `sudo pip install ansible`

## Step #3: Configure ansible
1. Configure `ansible.cfg` file 
  - follow `ansible.cfg` in this repo
2. Configure `hosts` file
  - If we are working with GCP, we don't have to edit `hosts`, we are going to create customized inventory for use.

## Step #4: Connect to the VM instances 
1. Create and configure an inventory file like inventory.gcp.yml in this repo. Use [this link](http://matthieure.me/2018/12/31/ansible_inventory_plugin.html) to get help of configuring dynamic 
inventory file
2. Connection testing:
   - Go to the directory where inventory.gcp.yml is located
   - `ansible -i inventory.gcp.yml all -m ping`

## Step #5: Configure and run the playbook
- Create and configure a ansible playbook like php_playbook.yml in this repo. [Get Help from Ansible Doc](https://docs.ansible.com/)
- Run the playbook by `ansible-playbook ../playbooks/php_playbook.yml -i inventory.gcp.yml`

## Step #6: Check the installation results
- For Ubuntu / Debian: 
  - `php -v`
  - `cd /etc/php/`
- For CentOS / RHEL:
  - `php -v`
  - `cd /usr/bin` and then `ls -al | grep php`
  
  
## Debugging Strategies
1. The directories of some of your files like (credential file in json format, the private key of your machine, the inventory.gcp.yml, php_playbook.yml) are not specified in the right way. You might want to use absolute path to avoid this problem
2. make sure you configure all the information in the inventory.gcp.yml correctly
   - `projects`: project name in your GCP console interface
   - `auth_kind`: always be "serviceaccount" if you are using service account to manage VMs
   - `service_account_file`: directory of your GCP credential json file
   
  Enjoy your journey with GCP and Ansible!
