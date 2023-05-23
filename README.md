# Objectives

- **Terraform Module:** Single CSR 1000v on AWS


# Module Usage

- This module creates only one CSR instance.

## Deploy CSR 1000v to existing VPC

- Please refer to `/Examples/Deploy_CSR_In_Existing_VPC` example.

```hcl
module "onprem_csr1k" {
  source  = "github.com/mjasinski007/terraform-aws-onprem-csr.git"

  vpc_id         = var.existing_vpc_id
  gig1_subnet_id = var.gig1_existing_subnet_id
  gig2_subnet_id = var.gig2_existing_subnet_id
  key_name       = var.csr_keypair
}
```

## Create a new VPC and Deploy CSR 1000v into it

- Please refer to `/Examples/Deploy_CSR_In_New_VPC` example.

```hcl
module "csr_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = "OnPremCSR_VPC"
  cidr                 = "10.0.0.0/16"
  azs                  = ["ap-southeast-2a"]
  private_subnets      = ["10.0.1.0/24"]
  public_subnets       = ["10.0.101.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "OnPremCSR_VPC"
  }
}

module "onprem_csr1k" {
  source  = "github.com/mjasinski007/terraform-aws-onprem-csr.git"

  vpc_id        = module.csr_vpc.vpc_id
  gi1_subnet_id = module.csr_vpc.public_subnets[0]
  gi2_subnet_id = module.csr_vpc.private_subnets[0]
  key_name      = var.csr_keypair
}
```

## Connect to Cisco CSR Instance

```bash
ssh -i OnPremCSR_KeyPair.pem ec2-user@18.168.60.21 -o kexalgorithms=diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1
```