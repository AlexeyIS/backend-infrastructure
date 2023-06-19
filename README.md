## SUMMARY

This repository is used to define core Networking and Kubernetes Cluster Infrastructure.

## PRE-REQUISITES

* Generate IAM access keys from the AWS console
* Install aws cli - https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
* Use aws cli to configure a named profile, e.g., "aws configure"
* Your credentials file should look like below(~/.aws/credentials)
    > [profile-name] <br />
    > aws_access_key_id = AKIA3.... <br />
    > aws_secret_access_key = u8kee0..... <br />
* Install kubectl - https://kubernetes.io/docs/tasks/tools/
* Install argocd cli - https://argo-cd.readthedocs.io/en/stable/cli_installation/

## TOOLS OF THE TRADE

* awscli
* helm (Helm 3 cli)
* kubectl
* argocd cli


#### CORE COMPONENTS

* Networking - 2 Tier VPC (Public, Private)
* EKS - Managed Kubernetes Service
* Charts - Install required helm charts upon cluster creation


## CREATING A NEW ENVIRONMENT

An environment its a combination of the following modules:

* network  - 2 tier network setup
* eks - the majority of EKS cluster set up occurs here. AWS resources and some core helm charts
* charts - all the helm charts(Nginx Controller, ArgoCD) to be installed after cluster creation.

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

1. Update your kubeconfig file so you can start administrating the cluster using kubectl with the following command
    > aws --profile <profile-name>  eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
2. Get the initial generated password for argocd Admin user
    > argocd admin initial-password 
3. Generate SSH Keys for github -  [github guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key)
4. Import your public key to github
5. Iclude your github private key in the provided "application.yml" file under the secret resource.
6. Push a new commit to your server repo to trigger the Github actions pipeline in order to build and push a new image to the ECR repository within your newly created infrastructure
7. Apply the "application.yml" file
    > kubectl apply -f application.yml

## DESTROYING THE CLUSTER

> terraform destroy  <br />

##### remember to remove the cluster from your ~/.kube/config

### Exceptions
* Applications that have issues resources outside K8S such as Load Balancers, DNS Entries may remain upon the cluster deletion and may hang terraform destroy. You will need to manually delete those resources.

## IMPROVEMENTS FROM ORIGINAL ITERATION
* Route 53 and Certificate manager setup
* Add DynamoDB for state locking  - https://developer.hashicorp.com/terraform/language/settings/backends/s3

## TO-DO
* Deploy Argo resources in different namespace than the default one
* Store the Private SSH key in AWS Secrets Manager/Parameter Store
* Deploy External Secrets Operator to create Kubernetes secrets by integrating with AWS Secrets Manager/Parameter Store



