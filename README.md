# zunaisha static website hosting on AWS--- 
    A simple asian clothing static website hosted on AWS S3 with AWS cloudfront for CDN.
    infrastructure is provisioned using terraform and deployment is fully automated with Github Action CI/CD.

                        -----Project Overview-----   
 This Project Demonstrate:                       
    -hosting a static website on "S3 private bucket"
    -content delivery through "Cloudfront" with "HTTPS"
    -for infrastructure as a code using "Terraform"
    -fully automated deployment pipeline via "github action"
    -remote state management with "S3-backend", "dynamodb-locking" 

   its a simple website containing 3 pages with HTML, CSS, images.

# AWS Configurations---  

# S3 Bucket--
-private bucket with blocked public accessed
-versionig disabled to reduce cost
-using server side encryption keys managed by S3
-Contents sync automatically from test-site/ folder via github action

# Cloudfront Distribution--
-origin: S3 private Bucket
-HTTPS Enabled
-Default caching behaviour
-URL: https://d398f6tzs8481a.cloudfront.net

# IAM Setup---
-A dedicated iam user with access keys, credentials stored  in "Github Secrets"
-credentials used by Github Action for authentication
-no IAM Role was required for this project

# CI/CD Workflow---
-the Github Action workflow (.github/workflows/deploy-s3.yml) does the following things:

    1- Checkout repository
    2- Configure the aws credentials from github secrets
    3- Setup terraform CLI
    4- RUN "tarraform init--->terraform plan--->terraform apply" inside the `terraform/` folder
    5- sync static wesite file from test-site/ folder to S3
    6- Invalidate cloudfront cache for updates

    -----WORKFLOW TRIGGER ON---
    -push to main
    -push to terraform-ci (for testing)

 # Terraform Setup---   

 -Terraform Version: 1.6.0
 -remote backend: S3 and Dynamodb for state locking and encryption

            "FOLDER STRUCTURE"
            terraform/
                        ├─ backend.tf
                        ├─ provider.tf
                        ├─ cloudfront.tf
                        ├─ s3.tf
                        ├─ s3_policy.tf
                        ├─ .terraform.lock.hcl
            test-site/
                        ├─ index.html
                        ├─ collection.html
                        ├─ contact.html
                        ├─ style.css
                        ├─ images/
            .github/workflows/deploy-s3.yml
            .gitignore
            README.md

 -.gitignore include:
    .terraform/
    *.tfstate
    *.tfstate.backup  

# How To Run This Project Locally---

-clone the repository:
             bash
       git clone https://github.com/zitayyab17-afk/zunaisha-terraform-website.git
        cd zunaisha-terraform-website             

 -go to terraform folder:
            bash
        cd terraform       

-initialize terraform:
            bash
        terraform init

-preview the infrastructure changes:
            bash
        terraform plan

-apply the infrastructure
            bash
        terraform apply
    
This will:

--Create or update the S3 bucket

--Create or update the CloudFront distribution

--Apply bucket policies

-Upload static website to S3 and invalidate CloudFront via GitHub Actions workflow (automatic on push)

# LIVE DEMO---

Visit the URL:  https://d398f6tzs8481a.cloudfront.net