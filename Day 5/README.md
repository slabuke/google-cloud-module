# google-cloud-module


<dl>
  <dt>Terraform</dt>
  <dd>Home task</dd>
</dl>



#### Here's Kirill Baravoy home task report:
#### Task 1: Recreate follow environments  <br>
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/kbaravoy/Day%205/img/scheme.png "Scheme")

##### Created instance groups
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/kbaravoy/Day%205/img/instance_group.png "Instance group")

##### Created instance templates
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/kbaravoy/Day%205/img/instance_group.png "Instance templates")

##### Created load-balancers
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/kbaravoy/Day%205/img/lb.png "LB")

##### Connection to Web-servers via LB
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/kbaravoy/Day%205/img/nginx-via-lb.png "Instance templates")

##### Enable Auto-scaling
![alt text](https://github.com/MNT-Lab/google-cloud-module/blob/kbaravoy/Day%205/img/scaling-on.png "Auto-scaling - ON)


##### My terraform file:
[Terraform main file](https://github.com/MNT-Lab/google-cloud-module/blob/kbaravoy/Day%205/main.tf "Main.tf") <br>
[Modules for main.tf](https://github.com/MNT-Lab/google-cloud-module/blob/kbaravoy/Day%205/networks.tf "networks.tf") <br>
