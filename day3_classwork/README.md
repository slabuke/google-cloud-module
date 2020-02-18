# google-cloud-module - Siarhei Kazak
# Day-3 ClassWork

## Created and pre-configured two Virtual Machines in Google Cloud by terraform.
## Virtual Machine Properties:

### - InstanceName : nginx-classwork-terraform
### - Region: us-central1
### - Zone: us-central1-a
### - Type: General Purpose, g1, 1CPU 1.7GB RAM, Disk SSD 30Gb;
### - OS: Ubuntu 16.04 LTS
### - Allow http,https traffic
### - Labels:
### - ServerType=NginxServer
### - OSFamily=Debian
### - WayOfInstallation=terraform
### - The instance should be protected for deletion.
### - The instance should contain desciption
### - VM should have the up and running Nginx (automatically provisioned after VM is started via yum, default configuration)
### - The instance is running in default network
### - Timeout for deletion set to 40 mins
