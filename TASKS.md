# Tasks for DevOps Intern

## 0. Prerequsites

Provision an EC2 in us-west-1 in aws-intern.ncats.io

OS is Ubuntu 18; instance type is t2.small; VPC is devops-intern; subnet is public subnet; root volume is 50 GB; add tag Owner with your name; initial security group should only allow SSH from your public IP; create key pair with your name and download it for future usage 

## 1. Dockerize a sample application

Commit your sample application to your GitHub with meaningful name

Create readme file for your app with instructions about compilation, build, configuration and run

Create Dockerfile for this app with multi-stage build

Run this docker application on EC2

## 2. Expose your application

Install and configure nginx on EC2

Create a domain in route53 for your app

Configure letsencrypt cert for your app in nginx

## 3. Jenkins Instance

Install and configure latest Jenkins on EC2

Configure Jenkins agent on worker node (application EC2)

Configure SSL for Jenkins master website

Configure Roles in Jenkins for different privileges: admin, regular user, etc. 

## 4. Create Jenkins Declarative pipeline

Create pipeline task in Jenkins, add configuration files specific to the application

Add meaning labels to worker nodes in Jenkins and use it as agent in pipeline file

Configure Trigger in pipeline using Git Polling with interval as 5 minutes

Create stages in pipeline for version generation, code compilation/build docker image, deployment, etc. 

Configure credential in Jenkins for GitHub access, Docker Hub access, AWS ECR access, etc. 

Install plugins in Jenkins if needed

## 5. Provison AWS infrastructure with Terraform

Create 1 VPC

Create 2 public subnets in 2 AZ; 2 private subnets in the same AZ as public subnets

Create Internet Gateway, NAT Gateway as needed

Create 1 security group pub-ssh-sg for bastion host with SSH port 22 access to only your IP

Create 1 security group prv-ssh-sg for application server with SSH port 22 access from public subnets

Create 1 EC2 (t3.small, disk 20 GB) with Ubuntu 20 in public subnet as bastion host, assigning with pub-ssh-sg

Create 1 EC2 (t3.medium, disk 50 GB) with Ubuntu 20 in private subnet as application server, assigning with prv-ssh-sg

Provision the application server as a worker node in Jenkins, install packages as needed

Configure Jenkins pipeline to deploy docker application to application server

Create 1 security group prv-app-sg and assign it to application server, with port opening for application to public subnets

Create Route 53 record and create SSL certificate using ACM

Create 1 security group for pub-http-sg with port HTTP and HTTPS open to your IP

Create 1 target group with application server as node

Create 1 ALB for application  with 2 listners: port 443 with SSL cert forwarding to target group; port 80 redirecting to port 443





