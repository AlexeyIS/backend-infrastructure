## SUMMARY

This repository is used to define core Networking and Kubernetes Cluster Infrastructure.

## PRE-REQUISITES

* Generate IAM access keys from the AWS console
* Install aws cli - https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
* use aws cli to configure a named profile, e.g., "aws configure"
* Your credentials file should look like below(~/.aws/credentials) assuming your profile named "dev"
    > [<profile-name>]
    > aws_access_key_id = AKIA3.....
    > aws_secret_access_key = u8kee0......
* Install kubectl


## TOOLS OF THE TRADE

* awscli
* helm (Helm 3 cli)
* kubectl


#### CORE COMPONENTS

* Networking - 2 Tier VPC (Public, Private)
* EKS - Managed Kubernetes Service


## CREATING A NEW ENVIRONMENT

An environment its a combination of the following modules:

* network  - 2 tier network setup
* eks - the majority of EKS cluster set up occurs here. AWS resources and some core helm charts


#### Authentication

> Currently configure to read a local AWS PROFILE, but can be switch to any Terraform AWS Provider Authentication Method once Terraform Cloud is used.

#### Terraform Structure

> There is one .tfvars file for each environment and it needs to be referred with --var-file=[environment].tfvars during apply/destroy
> Terraform states are stored remotely in AWS S3(Precreated Bucket)

### Running the project

> terraform fmt -recursive <br />
> terraform init  <br />
> terraform validate <br />
> terraform apply --var-file=[environment].tfvars  <br />


### Configuring your environment

> Update your kubeconfig file so you can start administrating the cluster using kubectl with the following command
> aws --profile <profile-name>  eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
>

## DESTROYING THE CLUSTER

> terraform destroy  <br />

##### remember to remove the cluster from your ~/.kube/config

### Exceptions
* Applications that have issues resources outside K8S such as Load Balancers, DNS Entries may remain upon the cluster deletion and may hang terraform destroy. You will need to manually delete those resources.

## IMPROVEMENTS FROM ORIGINAL ITERATION
* ARGO CD for continous integration
* Route 53 and Certificate manager setup

## TO-DO
* review EKS module

