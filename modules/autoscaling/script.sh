#!/bin/bash
yum update -y
amazon-linux-extras install -y nginx1
systemctl start nginx
systemctl enable nginx