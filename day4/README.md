# Terraform / Cloud Storage

## Home tasks

***

# Cloud Storage

***

### TASK 1

#### Objectives In this lab, you'll learn:

In this lab, I've learned:

· How to access the Cloud Storage Browser in the Google Cloud Console.

· How to create a Cloud Storage bucket.

· How to upload objects to a Cloud Storage bucket.

· How to delete a Cloud Storage bucket and all the object it contains.




![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/c1.png "course screenshot")

![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/c2.png "course screenshot")

![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/c3.png "course screenshot")

![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/c4.png "course screenshot")


***


### TASK 2

In this lab, I've learned how to perform the following tasks:

· Create and interact with your first GCS bucket using the UI and Command Line tool

· Setup ACL bucket and file permissions

· How to use the online transfer tool

· Configure Lifecycle Management

· Setup IAM permissions

> Same procedure like in first course, no screenshots needed.


***

### TASK 3

In this lab, I've learned how to perform the following tasks:

● Create and use buckets

● Set access control lists to restrict access

● Use your own encryption keys

● Implement version controls

● Use directory synchronization

● Share a bucket across projects using Cloud IAM

> Whole course was dedicated to gcloud sdk commands, there is nothing to show via screenshots.


### TASK 4

In this lab, I've learned how to perform the following tasks:

· How to Create a CNAME record

· How to point that CNAME record at Google Cloud Storage.

· How to Create a Google Cloud Storage bucket named like your domain.

· How to Upload and set permissions on the static files for your website.

· How to Test your website.

· How to Add HTTPS support with a HTTPS LoadBalancer

> Pretty same like in task 3, moving on.


***

# Terraform

## TASK:

### Create the following configuration via terraform:

![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/plan.png "network schema")


> **Whole configuration vas divided on 3 modules, which were imported in main.tf file**
>
> **Folder tree looks like this:**

![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/11.png "network schema")

> **module-network configures my custom VPC with public and private subnetworks, also there are described firewall rules**
>
> **module-instance creates  bastion instance, regional managed instance group, instance template for it. Also there are importing GCP's module for making a HTTP load balancer. Instance template is configured to install and start nginx server on default 80 port on startup**
>
> **module-private_inst does almost the same for the private subnetwork. The difference is that it also sets autoscaler for internal TCP load balancer and configures its autoscaling policy**

### Final configuration of network will look like the following:

![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/4.png "network schema")
***
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/5.png "network schema")
***
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/6.png "network schema")
***
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/7.png "network schema")
***
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/8.png "network schema")
***
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/0.png "network schema")
***
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/1.png "network schema")
***
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/2.png "network schema")
***
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/3.png "network schema")
***
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/9.png "network schema")
***
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/mbazhok/day4/img/10.png "network schema")














