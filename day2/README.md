# Compute: Virtual Machine creation
# Home task

## TASK 1


### Create Virtual Machine in Google cloud by the following ways:
#### -	gcp-ui (complete Lab: google codelabs: VM creation)

![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day2/img/ui0.png "ui method")
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day2/img/ui1.png "ui method")
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day2/img/ui2.png "ui method")
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day2/img/ui3.png "ui method")

#### -	gcloud
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day2/img/gcloud.png "gcloud method")

#### -	terraform (all settings should be provided via variables, add URL (“http://IP. Address/” to output )
> .tf files are attached ( inst.tf contains resource instance config, vars.tf - variables config)
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day2/img/attach.png "terraform method")

Virtual Machine Properties:
-	InstanceName : nginx-${creation-way}
-	Region: us-central1
-	Zone: us-central1-c
-	Type: General Purpose, n1, 1CPU 4.5GB RAM, Disk SSD 35Gb;
-	OS: Centos7
-	Allow http,https traffic
-	Labels: 
o	ServerType=NginxServer
o	OSFamily=RedHat
o	WayOfInstallation=${creation-way}

-	The instance should be protected for deletion.
-	VM should have the up and running Nginx (automatically provisioned after VM is started via yum, default configuration)
-	The instance is running in default network



## TASK 2


### Create Persistent Disk and attach it to one of existing Virtual machine (nginx-gcp-ui).
#### 1)	Complete Lab goolge codelabs: persistent disk with using your VM name
#### 2)	Create terraform configuration to do the same via terraform (use VM: nginx-gcp-terraform).

> Lab google codelabs complete

> .tf file is attached ( att_disk.tf contain disk creation and attachmend configuration and 

