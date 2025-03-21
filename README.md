# Automated-Secure-VPC-Setup-with-IAM-S3-Access-Control

![image_alt](https://github.com/Tatenda-Prince/Automated-Secure-VPC-Setup-with-IAM-S3-Access-Control/blob/2fb3a4ca41c58fb9e0eb09a389e2906e29a76719/screenshots/Screenshot%202025-03-17%20203717.png)


## Project Overview
This project demonstrates secure cloud infrastructure setup using AWS services and Terraform. It provisions a secure VPC, an EC2 instance in a private subnet, an S3 bucket with restricted access.The goal is to showcase security best practices by ensuring that only authorized resources can access sensitive data.

## Project Objective
1.Create a Secure AWS VPC with private and public subnets

2.Provision a private EC2 instance with no internet access

3.Restrict access to an S3 bucket, allowing only private EC2 instances via a VPC endpoint

4.Use AWS Systems Manager (SSM) Session Manager for secure EC2 access (no SSH required)

6.Automate the entire infrastructure using Terraform


## Features
1.Private & Public Subnet Configuration – Ensures controlled access to AWS resources

2.EC2 with No Internet Access – Secured to only communicate within the VPC

3.VPC Endpoint for S3 – Allows private access to S3 without an internet gateway

4.IAM Role & S3 Bucket Policy – Restricts access to only authorized EC2 instances

5.AWS SSM Session Manager – Enables secure access to EC2 without SSH

6.Terraform Automation – Easily deploy and manage infrastructure

## Technologies Used
1.Infrastructure as Code (IaC): Terraform

2.Cloud Provider: AWS

3.Networking: VPC, Subnets, Security Groups

4.Compute: EC2

5.Storage: S3 (with IAM Policies & VPC Endpoint)

6.Security: IAM

7.EC2 Access: AWS Systems Manager (SSM) Session Manager

## Use Case
You work at the Up The Chels Bank institution as Cloud Engineer and you tasked with securing storage and process customer transaction data without exposing to public internet.Your S3 bucket access is restricted to only EC2 instances in a private subnet.

## Prerequisites
Before deploying this project, ensure you have:
1.AWS CLI installed & configured (`aws configure`)

2.Terraform installed (`terraform -v`)

3.An AWS IAM user with necessary permissions

4.AWS Systems Manager (SSM) Agent enabled on EC2 for session access

## Step 1: Clone the Repository
1.1.Clone this repository to your local machine.

```language
git clone https://github.com/Tatenda-Prince/Automated-Secure-VPC-Setup-with-IAM-S3-Access-Control.git
```

## Step 2 : Run Terraform workflow to initialize, validate, plan then apply
2.1.Terraform will provision:

1.EC2 instance with no public IP

2.Amazon S3 Bucket

3.VPC with a Public Subnet,Private Subnet and VPC Endpoint


2.2.In your local terraform visual code environment terminal, to initialize the necessary providers, execute the following command in your environment terminal.

```language
terraform init
```

Upon completion of the initialization process, a successful prompt will be displayed, as shown below.

![image_alt](https://github.com/Tatenda-Prince/Automated-Secure-VPC-Setup-with-IAM-S3-Access-Control/blob/0026b9d0a63fbff87786c9253fd354df27a3e963/screenshots/Screenshot%202025-03-18%20120406.png)


2.3.Next, let’s ensure that our code does not contain any syntax errors by running the following command

```language
terraform validate
```

The command should generate a success message, confirming that it is valid, as demonstrated below.

![image_alt](https://github.com/Tatenda-Prince/Automated-Secure-VPC-Setup-with-IAM-S3-Access-Control/blob/12eb5c17f7e9b712e47d1e5ac52d206b67f85914/screenshots/Screenshot%202025-03-18%20120619.png)


2.4.Let’s now execute the following command to generate a list of all the modifications that Terraform will apply.

```language
terraform plan
```

![image_alt](https://github.com/Tatenda-Prince/Automated-Secure-VPC-Setup-with-IAM-S3-Access-Control/blob/26b83ff541d460ac7dee4fb6cce6e62068475d33/screenshots/Screenshot%202025-03-18%20121214.png)


The list of changes that Terraform is anticipated to apply to the infrastructure resources should be displayed. The “+” sign indicates what will be added, while the “-” sign indicates what will be removed.


2.5.Now, let’s deploy this infrastructure! Execute the following command to apply the changes and deploy the resources. Note — Make sure to type “yes” to agree to the changes after running this command.

```language
terraform apply
```

Terraform will initiate the process of applying all the changes to the infrastructure. Kindly wait for a few seconds for the deployment process to complete.

![image_alt](https://github.com/Tatenda-Prince/Automated-Secure-VPC-Setup-with-IAM-S3-Access-Control/blob/75cb27b58f574ab2910e2fbda6076bc922be4457/screenshots/Screenshot%202025-03-18%20121327.png)


## Success
The process should now conclude with a message indicating “Apply complete”, stating the total number of added, modified, and destroyed resources, accompanied by several resources.

![image_alt](https://github.com/Tatenda-Prince/Automated-Secure-VPC-Setup-with-IAM-S3-Access-Control/blob/c81c7181a7b3c8f5adad09fe2fb5a8e97f8217f2/screenshots/Screenshot%202025-03-18%20121607.png)


## Step 3: Verify creation of our resources
3.1.In the AWS Management Console, head to the EC2 Instance Console and verify that there is instance running as show below

![image_alt](https://github.com/Tatenda-Prince/Automated-Secure-VPC-Setup-with-IAM-S3-Access-Control/blob/0a2692709d53dbf7c2d17c9ece1cb60feee1bb4b/screenshots/Screenshot%202025-03-18%20121813.png)


3.2.In the AWS Management Console, head to the Amazon S3 Console and verify that there is Bucket as show below

![image_alt](https://github.com/Tatenda-Prince/Automated-Secure-VPC-Setup-with-IAM-S3-Access-Control/blob/c502e9634065458d454d6bd69e35edd2a4fc5701/screenshots/Screenshot%202025-03-18%20121845.png)


Now Head to your bucket permission Tab and copy the bucket policy json file below and click edit Bucket policy and click the orange button to save changes.

```langauge
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::secure-private-s3-bucket-tatenda",
            "Condition": {
                "StringNotEqualsIfExists": {
                    "aws:PrincipalArn": "arn:aws:iam::<YOUR ACCOUNT ID>:role/EC2S3AccessRole"
                }
            }
        },
        {
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:DeleteObject",
            "Resource": "arn:aws:s3:::secure-private-s3-bucket-tatenda/*",
            "Condition": {
                "Bool": { "aws:MultiFactorAuthPresent": "false" }
            }
        },
        {
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::secure-private-s3-bucket-tatenda/*",
            "Condition": {
                "Bool": { "aws:SecureTransport": "false" }
            }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::<YOUR ACCOUNT ID> :role/EC2S3AccessRole"
            },
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::secure-private-s3-bucket-tatenda/*",
            "Condition": {
                "StringEquals": {
                    "aws:SourceVpce": "YOUR VPC ENDPOINT ID"
                },
                "StringEqualsIfExists": {
                    "s3:x-amz-server-side-encryption": "aws:kms"
                }
            }
        }
    ]
}
```


3.3.In the AWS Management Console, head to the VPC dashboard and verify that you have a custom VPC created as show below

![image_alt](https://github.com/Tatenda-Prince/Automated-Secure-VPC-Setup-with-IAM-S3-Access-Control/blob/0b22d6ab602bb792a7c5ed54d77a9147e882f8b8/screenshots/Screenshot%202025-03-18%20121927.png)



## Step 4: Testing the System
4.1.Connect to EC2 Using SSM Session Manager
In AWS Management Console head to your EC2 dashboard and click on `Connect` and choose Session Manager. 

![image_alt](https://github.com/Tatenda-Prince/Automated-Secure-VPC-Setup-with-IAM-S3-Access-Control/blob/b9ed1526568e2980837702783df29308b7963088/screenshots/Screenshot%202025-03-18%20123532.png)


Expected Result: You should be connected to the EC2 instance without using SSH or a public IP.


![image_alt](https://github.com/Tatenda-Prince/Automated-Secure-VPC-Setup-with-IAM-S3-Access-Control/blob/fa946af9de2eacd81097fce3bbe366aa02e4dbcf/screenshots/Screenshot%202025-03-18%20125830.png)


4.2.Verify S3 Access Control
From the EC2 instance, try listing the S3 bucket:

```language
aws s3 ls s3://secure-private-s3-bucket
```

![image_alt](https://github.com/Tatenda-Prince/Automated-Secure-VPC-Setup-with-IAM-S3-Access-Control/blob/9da05cb817d0c00e6656f516e5f9b83642fefa81/screenshots/Screenshot%202025-03-18%20123827.png)

Expected Result: The bucket should be listed with Objects


4.3.Try accessing S3 from your local machine (Should be Denied):
```language
aws s3 ls s3://secure-private-s3-bucket
```

![image_alt](https://github.com/Tatenda-Prince/Automated-Secure-VPC-Setup-with-IAM-S3-Access-Control/blob/c6376b985000d8953d480be67659f6db360f0ca3/screenshots/Screenshot%202025-03-18%20124231.png)

Expected Result: Access Denied (Only EC2 can access).


## Future Enhancements
1.Add Multi-Region Support – Deploy resources in multiple AWS regions for disaster recovery

2.Use AWS Lambda for Automated Security Remediation – Automatically respond to security threats

3.Integrate AWS GuardDuty & AWS Config – Improve threat detection and compliance monitoring

4.Enhance S3 Encryption Policies – Add AWS KMS for data encryption

## What We Learned
1.How to set up a Secure AWS VPC with private and public subnets

2.How to control S3 access using IAM roles and bucket policies

3.How to enable secure EC2-S3 communication using VPC Endpoints

4.How to use AWS SSM Session Manager to connect to EC2 (No SSH required!)

5.How to use Terraform to automate AWS infrastructure deployment


## Congratulations
We have succesfully created security solution by ensuring data protection, access control using AWS best practices. By leveraging Terraform, the infrastructure is automated, scalable, and easy to manage.

























