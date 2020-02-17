# google-cloud-module

# Pavel_Karunas_Report_2

   Create Virtual Machine in Google cloud by the following ways:
 * gcp-ui (complete Lab: google codelabs: VM creation)

 * gcloud

gcloud compute instances create nginx-gcloud --zone=us-central1-c --custom-cpu=1 --custom-vm-type=n1 --custom-memory=4608MB --boot-disk-type=pd-ssd --boot-disk-device-name nginx-console --boot-disk-size=35GB --image=centos-7 --labels servertype=nginxserver,osfamily=redhat,wayofinstallation=gcloud --tags http-server,https-server --deletion-protection --metadata-from-file startup-script=startup.sh

 * terraform (all settings should be provided via variables (tfvars), add URL (“http://IP. Address/” to output )

Virtual Machine Properties:
InstanceName : nginx-${creation-way}
Region: us-central1
Zone: us-central1-c
Type: General Purpose, n1, 1CPU 4.5GB RAM, Disk SSD 35Gb;
OS: Centos7
Allow http,https traffic
Labels: 
ServerType=NginxServer
OSFamily=RedHat
WayOfInstallation=${creation-way}

The instance should be protected for deletion.
VM should have the up and running Nginx (automatically provisioned after VM is started via yum, default configuration)
The instance is running in default network

![IAMperm](https://github.com/MNT-Lab/google-cloud-module/blob/pkarunas/Screenshots/Screenshot%20from%202020-02-14%2016-36-47.png)

![RunningVM](https://github.com/MNT-Lab/google-cloud-module/blob/pkarunas/Screenshots/Screenshot%20from%202020-02-14%2013-41-58.png)
	
![TerraGCP](https://github.com/MNT-Lab/google-cloud-module/blob/pkarunas/Screenshots/Screenshot%20from%202020-02-14%2017-04-38.png)
