# Objectives

- Deploy [Cisco CSR 8000V](https://aws.amazon.com/marketplace/pp/prodview-cjzny6dzcbrom?sr=0-2&ref_=beagle&applicationId=AWSMPContessa)
  - Cisco 1000v EOL (not supported anymore). More info [here](https://aws.amazon.com/marketplace/pp/prodview-eiyjsmv7u3luy).

# Examples

- :heavy_check_mark: Provision Cisco CSR8k in new VPC
- :x:~~Provision Cisco CSR8k in exsiting VPC~~
- :black_square_button: Provision Cisco CSR8k along with Aviatrix Site-to-Cloud VPN connection (end-to-end automatic implementation) - In Progress
- :black_square_button: Provision Cisco CSR8k along with AWS Transit Gateway VPN connection (end-to-end automatic implementation) - In Progress


# Cisco CSR8k (New VPC)

- Navigate to `Examples` > `deploy_csr8k_new_vpc`.
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


## Modules Usage

```hcl
module "csr8k_vpc" {
    source                  = "github.com/mjasinski007/terraform-aws-onprem-csr.git"
    vpc_name                 = var.vpc_name
    vpc_cidr                 = var.vpc_cidr
    csr8k_ami                = var.ami_type
    instance_type            = var.instance_type
    admin_password           = var.admin_password
    hostname                 = var.hostname
    custom_bootstrap         = true # set always as true to use running_config.tpl # Issue 1 in progress
    bootstrap_data           = data.template_file.running_config.rendered
    private_ip_list_enabled  = true
    gig1_private_address     = var.gig1_private_address
    gig2_private_address     = var.gig2_private_address
    gig1_subnet_id           = module.csr8k_vpc.public_subnets[0].cidr_block
    gig2_subnet_id           = module.csr8k_vpc.private_subnets[0].cidr_block
}
```


## SSH To Cisco CSR8k Instance

- The keypair `CSR8k_KeyPair.pem` will be created under the deployment folder.
- The output with the SSH command will be genrated after `terraform apply --auto-approve`

```
ssh -i CSR8k_KeyPair.pem admin@18.170.152.96
```