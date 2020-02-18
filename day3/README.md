# google-cloud-module - Siarhei Kazak
# Day-3

# Today I've done the following:
## Completed lab:: https://codelabs.developers.google.com/codelabs/cloud-load-balancers/index.html?index=..%2F..index#0
## Completed lab:: https://codelabs.developers.google.com/codelabs/cloud-networking-101/index.html?index=..%2F..index#0

### Network name:  skazak-vpc
### Firewall rules for external (allow 80,22) and internal (allow 0-65535) access 
### Subnets with ranges: 10.8.1.0/24 10.8.2.0/24
### nginx with default page “Hello from Siarhei Kazak”

## Attaching a few screenshots

## Task1: 
### Facing some troubles in:
![lab1_trouble1](../Screenshots/lab1_trouble1.png)

### The output is:
![lab1_trouble2](../Screenshots/lab1_trouble2.png)

### Anyway got it done by choosing another region for LB
![lab1_trouble_done](../Screenshots/lab1_done.png)

## Task2:
### Siege attack on LB:
![VMs provisioned with nginx](../Screenshots/lab2_siege.png)

### LB graph: actually seems to be okay with it :)
![VMs provisioned with nginx](../Screenshots/lab2_graph.png)

![VMs provisioned with nginx](../Screenshots/lab2_done.png)

## Task5
### Custon nginx page:
![List of running instances](../Screenshots/task5_nginx.png)

### Firewall rules:
![Additional drive for nginx-tf instance](../Screenshots/task5_firewall.png)

### Subnets:
![Additional drive for nginx-tf instance](../Screenshots/task5_subnets.png)
