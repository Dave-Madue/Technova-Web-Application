# TechNova AWS Development Environment

This project provisions a secure AWS development environment using Terraform and deploys a working web application using Ansible.

The infrastructure is fully automated and can be destroyed and rebuilt reliably.

---

## 🔧 Architecture Overview

- Custom VPC (10.20.0.0/16)
- 2 Public Subnets (2 Availability Zones)
- 2 Private Subnets (2 Availability Zones)
- Internet Gateway + Public Route Table
- EC2 (Ubuntu 22.04) in Public Subnet (Application Host)
- RDS PostgreSQL in Private Subnets (Not Publicly Accessible)
- S3 Bucket with Versioning Enabled and Public Access Blocked

The database is intentionally placed in private subnets and only accessible from the EC2 security group (least-privilege design).

---

## 🚀 Application

The deployed application is a database-backed feedback wall built with:

- Node.js (Express)
- PostgreSQL (Amazon RDS)
- Nginx reverse proxy
- Systemd service management

Endpoints:

- `/` – Landing page
- `/wall` – Displays stored messages
- `/health` – Health check
- `/db` – Database connectivity test
- `/s3` – Displays S3 bucket information

---

## 📦 Provision Infrastructure (Terraform)

```bash
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
```

🚀 Deploy Application (Ansible)
cd ansible

# Generate inventory
EC2_IP=$(cd ../terraform && terraform output -raw ec2_public_ip)

cat > inventory.ini <<EOF
[web]
$EC2_IP ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/technova
EOF

# Export Terraform outputs
TF_DB_HOST=$(cd ../terraform && terraform output -raw rds_endpoint)
TF_DB_PORT=$(cd ../terraform && terraform output -raw rds_port)
TF_S3_BUCKET=$(cd ../terraform && terraform output -raw s3_bucket_name)

export TF_DB_HOST TF_DB_PORT TF_S3_BUCKET

ansible-playbook -i inventory.ini playbook.yml
🔐 Security Decisions

RDS is not publicly accessible.

Database access is restricted to EC2 security group only.

SSH access restricted to a specific public IP.

S3 public access is blocked.

This follows least-privilege principles and production-ready networking patterns.

🧹 Tear Down
cd terraform
terraform destroy -auto-approve

📊 Production Considerations

For production, this architecture would be upgraded with:

Application Load Balancer

Auto Scaling Group (2+ EC2 instances across AZs)

Multi-AZ RDS with automated backups

CloudWatch monitoring

Reserved Instances or Savings Plans for cost optimization


