# Kubernetes Event-Driven Autoscaling (KEDA) on AWS EKS

## Overview
This project implements an **Event-Driven Autoscaling** architecture on **Amazon EKS (Elastic Kubernetes Service)** using **KEDA**. The system scales workloads based on **Amazon SQS (Simple Queue Service) queue depth**.

### **Key Components**:
- **Terraform**: Provisions AWS infrastructure (VPC, EKS, IAM, S3, SQS, etc.).
- **Ansible**: Configures EC2 instances for Kubernetes and deployment.
- **Kubernetes Manifests**: Deploys workloads, ServiceAccount, KEDA authentication, and scaling configurations.
- **Docker & Flask App**: A simple web application deployed on Kubernetes.

## **Project Structure**
```
keda-project/
│── terraform/
│   ├── main.tf               # Main Terraform script
│   ├── variables.tf          # Variables for Terraform
│   ├── outputs.tf            # Terraform outputs
│   ├── vpc.tf                # VPC, Subnets, and Internet Gateway
│   ├── eks.tf                # EKS Cluster and Node Groups
│   ├── iam.tf                # IAM Roles and Policies
│   ├── sqs.tf                # Amazon SQS queue setup
│   ├── s3.tf                 # S3 bucket for triggering events
│   ├── provider.tf           # Terraform AWS provider
│── ansible/
│   ├── inventory.ini         # Ansible inventory file
│   ├── playbook.yml          # Ansible playbook for EC2 configuration
│   ├── roles/
│   │   ├── common/           # Common tasks (install Docker, AWS CLI)
│   │   ├── kubernetes/       # Install kubectl, eksctl, configure kubeconfig
│   │   ├── deploy/           # Deploy KEDA, Python App, and scaling config
│── k8s/
│   ├── deployment.yaml       # KEDA-enabled application deployment
│   ├── service.yaml          # LoadBalancer service for the app
│   ├── serviceaccount.yaml   # ServiceAccount for IRSA
│   ├── triggerauth.yaml      # KEDA authentication for AWS SQS
│   ├── scaledobject.yaml     # KEDA scaling config
│── scripts/
│   ├── setup_kubeconfig.sh   # Configure kubeconfig for EKS
│── Dockerfile                # Dockerfile for Flask App
│── app.py                    # Flask App Code
│── README.md                 # Documentation
```

## **Deployment Steps**
### **Step 1: Deploy Terraform Infrastructure**
```sh
cd terraform
terraform init
terraform apply -auto-approve
```

### **Step 2: Configure EC2 Instances with Ansible**
```sh
cd ansible
ansible-playbook -i inventory.ini playbook.yml
```

### **Step 3: Deploy Kubernetes Manifests**
```sh
kubectl apply -f k8s/
```

### **Step 4: Verify KEDA Scaling**
```sh
kubectl get pods -w
```

## **Key Features**
- **Automatic Scaling**: Uses KEDA to scale pods dynamically based on SQS message count.
- **Infrastructure as Code**: Terraform provisions AWS resources in a structured manner.
- **Configuration Management**: Ansible automates EC2 instance configuration.
- **Microservice Deployment**: The Python Flask app runs inside a Kubernetes cluster.
- **AWS Integration**: Utilizes IAM roles, IRSA, and EKS authentication for secure operations.

## **Suggestions for Enhancement**
- Implement **GitHub Actions** for CI/CD automation.
- Use **Terraform remote state** (S3 + DynamoDB) for better state management.
- Implement **Ansible Vault** to secure sensitive credentials.
- Use **AWS Secrets Manager** for managing application secrets.

## **Troubleshooting**
- **Terraform Apply Issues**: Run `terraform destroy` and retry applying.
- **Kubernetes Pods Not Running**:
  ```sh
  kubectl describe pod <pod-name>
  ```
- **EC2 SSH Access Issues**: Verify security group rules allowing SSH access.


