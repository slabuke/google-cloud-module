#!/bin/bash

#Set region
gcloud config set compute/zone us-central1-c
gcloud config set compute/region us-central1


# Make a script to install nginx
cat << EOF > startup.sh
#! /bin/bash
apt-get update
apt-get install -y nginx
service nginx start
sed -i -- 's/nginx/Google Cloud Platform - '"\$HOSTNAME"'/' /var/www/html/index.nginx-debian.html
EOF

# Create an instance template that will use the startup script:
gcloud compute instance-templates create nginx-template --metadata-from-file startup-script=startup.sh

# Create target pool. A target pool allows us to have a single access point to all the instances 
# in a group and is necessary for load balancing in the future steps
gcloud compute target-pools create nginx-pool

# Create a managed instance group using the instance template
gcloud compute instance-groups managed create nginx-group \
         --base-instance-name nginx \
         --size 2 \
         --template nginx-template \
         --target-pool nginx-pool

# To show instances list
gcloud compute instances list

# Configure firewall so that you can connect to the machines on port 80 
gcloud compute firewall-rules create www-firewall --allow tcp:80


# Let's create a L3 network load balancer targeting our instance group:

gcloud compute forwarding-rules create nginx-lb \
		--region us-central1 \
		--ports=80 \
		--target-pool nginx-pool



### 							L7

# Create a health check. Health checks verify that the instance is responding
gcloud compute http-health-checks create http-basic-check

# Create a backend service
gcloud compute instance-groups managed set-named-ports nginx-group --named-ports http:80

gcloud compute backend-services create nginx-backend --http-health-checks http-basic-check --global

# Add the instance group into the backend service
gcloud compute backend-services add-backend nginx-backend --instance-group nginx-group

# Create a default URL map that directs all incoming requests to all your instances
gcloud compute url-maps create web-map --default-service nginx-backend

# Create a target HTTP proxy to route requests to your URL map:
gcloud compute target-http-proxies create http-lb-proxy --url-maps web-map

# Create a global forwarding rule to handle and route incoming requests
gcloud compute forwarding-rules create http-content-rule \
        --global \
        --target-http-proxy http-lb-proxy \
        --port-range 80