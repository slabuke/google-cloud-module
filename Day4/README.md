# gcp-cloud-module
## task 4 by Vitali Andrushkevich

> I have completed labs grom google code lab, few screenshots u may find [here][1]

[1]: https://github.com/MNT-Lab/google-cloud-module/tree/vandrushkevich/Day4/imgs_gcloud_lab



> Also have compeleted task to create infrastructure with terraform - IT's was really interesting.

![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day4/imgs_terraform/main%20schema.png)

You can see my prof below:

Fisrstly, images to show created isntances, group, templates, vpc network, load-balancer and others:

Instences:
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day4/imgs_terraform/tf-instances.png)

Insatnce groups:
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day4/imgs_terraform/tf-zones.png)

Templates:
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day4/imgs_terraform/tf-instance-templace.png)

Load balancers:
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day4/imgs_terraform/tf-lbs.png)

VPC network details:
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day4/imgs_terraform/tf-network.png)

Secondly, I want to show u my resulsts:

I have an access to http nginx server.

![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day4/imgs_terraform/tf-http-loadbalancer.png)
![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day4/imgs_terraform/tf-http-access.png)

I have an access to BASTION server via ssh:

![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day4/imgs_terraform/tf-connect-to-bastion.png)

For showing internal load balancer I used nginx with custom pages on each instances and try to use curl from bastion to balancer (as I understand, we need that someone will listen us in some port, and the most easiest way for me was install nginx and listen on 80 port):

![Image alt](https://github.com/MNT-Lab/google-cloud-module/blob/vandrushkevich/Day4/imgs_terraform/tf-curl-from-bastion.png)

