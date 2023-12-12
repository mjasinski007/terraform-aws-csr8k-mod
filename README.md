# Objectives

- Deploy [Cisco CSR 8000V](https://aws.amazon.com/marketplace/pp/prodview-cjzny6dzcbrom?sr=0-2&ref_=beagle&applicationId=AWSMPContessa)
  - Cisco 1000v EOL (not supported anymore). More info [here](https://aws.amazon.com/marketplace/pp/prodview-eiyjsmv7u3luy)

# Examples

- Provision Cisco CSR8k in new VPC
- Provision Cisco CSR8k in exsiting VPC
- Provision Cisco CSR8k along with Aviatrix Site-to-Cloud VPN connection (end-to-end automatic implementation) - In Progress
- Provision Cisco CSR8k along with AWS Transit Gateway VPN connection (end-to-end automatic implementation) - In Progress


# Cisco CSR8k (New VPC)

- Please navigate to `Examples` > `deploy_csr8k_new_vpc`.
- The following example deploys:
  - New VPC
  - New Internet Gateway
  - New public subnet (for Gig1 interface)
  - New private subnet (for Gig2 interface)
  - Assign EIP for Gig1 interface
  - Private and public route tables
  - Assign subnets to route tables respectively.

## Variables 

- The following variables are required:

| Key                     | Default Value | Description                                                                                                       |
|-------------------------|---------------|-------------------------------------------------------------------------------------------------------------------|
| vpc_name                | ""            | VPC name                                                                                                          |
| vpc_cidr                | ""            | VPC CIDR. For example `10.0.0.0/16`                                                                               |
| csr8k_ami               | "BYOL"        | Type of AMI. `BYOL` or `PAYG`                                                                                     |
| instance_type           | "c5.large"    | EC2 instance size                                                                                                 |
| admin_password          | ""            | Password for Cisco CSR CLI                                                                                        |
| hostname                | ""            | Cisco CSR hostname                                                                                                |
| custom_bootstrap        | True          | Should be `True`.Enable `user_data` for EC2 instance. Please use `running_config.tpl` as configuration template.  |
| bootstrap_data          | ""            | Template file path. Default `data.template_file.running_config.rendered`                                          |
| private_ip_list_enabled | True          | Set `True` id you want to assign private IP addresses to the Cisco CSR interfaces                                 |
| gig1_private_address    | [""]          | List of private IP addresses assigned to first interface. The `private_ip_list_enabled` must be `true`            |
| gig2_private_address    | [""]          | List of private IP addresses assigned to second interface. The `private_ip_list_enabled` must be `true`           |
| gig1_subnet_id          | ""            | Public subnet CIDR used by first interface                                                                        |
| gig2_subnet_id          | ""            | Private subnet CIDR used by second interface                                                                      |


- The following variables are optional:

| Key                      | Default Value | Description                                                                |
|--------------------------|---------------|----------------------------------------------------------------------------|
| enable_dns_hostnames     | Yes           | Should be true to enable DNS hostnames in VPC                              |
| enable_dns_support       | Yes           | Should be true to enable DNS support in VPC                                |
| gig1_ingress_cidr_blocks | ["0.0.0.0/0]  | List of CIDRs used for Network Security Group for Gig1 interface (ingress) |
| gig1_egress_cidr_blocks  | ["0.0.0.0/0]  | List of CIDRs used for Network Security Group for Gig1 interface (egress)  |
| gig2_ingress_cidr_blocks | ["0.0.0.0/0]  | List of CIDRs used for Network Security Group for Gig2 interface (ingress) |
| gig2_egress_cidr_blocks  | ["0.0.0.0/0]  | List of CIDRs used for Network Security Group for Gig2 interface (egress)  |
















# Cisco CSR8k (Existing VPC)

- Please navigate to `Examples` > `deploy_csr8k_existing_vpc`.















- **Terraform Module:** Single CSR 1000v on AWS


# Module Usage

- This module creates only one CSR instance.

## Deploy CSR1000v Instance In Existing VPC

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

## Deploy CSR1000v Instance And New VPC

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

## Connect to CSR1000v Instance

```bash
ssh -i OnPremCSR_KeyPair.pem ec2-user@18.168.60.21 -o kexalgorithms=diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1
```



# TODO

- Add option create VPC or existing VPC
  - with subnets name private/public
- Add options:
  - Create AWS VPNs ?
  - Create Aviatrix VPNs?
- Assign Private IP addresses from root module
  - Used them to configure interfaces (initial_config)
- Add option to configure security-groups from root module


