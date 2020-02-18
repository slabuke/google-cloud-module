#!/bin/bash

sudo yum -y update
sudo yum -y install nginx
systemctl enable nginx
systemctl start nginx
