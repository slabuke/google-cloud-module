#!/usr/bin

gcloud config set compute/zone us-central1-c
gcloud config set compute/region us-central1
gcloud auth list
# gcloud config set account `ACCOUNT`
gcloud config list project

# gcloud config set project <Project_ID>


mkdir networking101
cd networking101
# copy the scripts to your local environment with gsutil
gsutil cp gs://networking101/* .
gcloud deployment-manager deployments create networking101  --config networking-lab.yaml
# This command sets up the environment consisting of one network with five subnetworks in different regions and five Debian VMs in those subnetworks

# put it into networking-lab-snippet.yaml

# - name: networking-firewall
#   type: firewall-template.jinja
#   properties:
#     network: networking101

cat networking-lab-snippet.yaml >> networking-lab.yaml
gcloud deployment-manager deployments update networking101 --config networking-lab.yaml

ping -i0.2 w2-vm #(sends a ping every 200ms)
sudo ping -i0.05 w2-vm -c 1000 #(sends a ping every 50ms, 1000 times)
sudo ping -f -i0.05 w2-vm #(flood ping, adds a dot for every sent packet, and removes one for every received packet)  - careful with flood ping without interval, it will send packets as fast as possible, which within the same zone is very fast
sudo ping -i0.05 w2-vm -c 100 -s 1400 #(send larger packets, does it get slower?)


gcloud compute firewall-rules create nw101-allow-http \
--allow tcp:80 --network networking101 --source-ranges 0.0.0.0/0 \
--target-tags http-server


# The following gcloud command will create this instance template:

gcloud compute instance-templates create "us-east1-template" \
--subnet "us-east1" \
--metadata "startup-script-url=gs://networking101-lab/startup.sh" \
--region "us-east1" \
--tags "http-server"

# similar instance template for europe-west1 replacing the name, region, and subnetwork fields
gcloud compute instance-templates create "europe-west1-template" \
--subnet "europe-west1" \
--metadata "startup-script-url=gs://networking101-lab/startup.sh" \
--region "europe-west1" \
--tags "http-server"


gcloud compute instance-groups list


# delete

gcloud compute instance-groups managed delete europe-west1-mig \
--region=europe-west1

gcloud compute instance-groups managed delete us-east1-mig \
--region=us-east1

gcloud compute instance-templates delete us-east1-template

gcloud compute instance-templates delete europe-west1-template

gcloud compute firewall-rules delete nw101-allow-http

# To delete the automatically created deployment (with the networks and subnetworks) run the following command in Cloud Shell:

gcloud deployment-manager deployments delete networking101