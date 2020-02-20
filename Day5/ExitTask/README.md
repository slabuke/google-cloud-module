# google-cloud-module

# Pavel_Karunas_Report_5_ExitTask

	This terraform configuration does the following:

 1. Creates VPC network

 2. Creates two subnetworks private with ip_cidr_range = "10.3.2.0/24" and public with ip_cidr_range = "10.3.1.0/24".

 3. Apply firewall rules to VPC

 4. Creates HTTP load balancer (listen 80 port)

 5. Creates instance group (Multi-regional)

 5. Creates Instance with NGINX in Multi-regional instance group (which is balanced by HTTP lb created in previous step) (listen 80 port)

 6. Creates Bastion Instance in public network

 7. Creates NAT router and applyed NAT routes

 8. Creates instance-group (backend) with 3 Instance members (DB) in private subnetwork (NGXIN installed listen to 80 for testing)

 9. Creates internal load balancer which is balancing backend instances created previously (listen to 80 port and redirect to backend)

 10. Creates storage bucket for backend static content 

![IAMperm](https://github.com/MNT-Lab/google-cloud-module/blob/pkarunas/Day5/ExitTask/Screenshots/Screenshot%20from%202020-02-20%2018-25-00.png)

![IAMperm](https://github.com/MNT-Lab/google-cloud-module/blob/pkarunas/Day5/ExitTask/Screenshots/Screenshot%20from%202020-02-20%2018-24-36.png)

![IAMperm](https://github.com/MNT-Lab/google-cloud-module/blob/pkarunas/Day5/ExitTask/Screenshots/Screenshot%20from%202020-02-20%2018-24-23.png)

![IAMperm](https://github.com/MNT-Lab/google-cloud-module/blob/pkarunas/Day5/ExitTask/Screenshots/Screenshot%20from%202020-02-20%2018-20-46.png)
