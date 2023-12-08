# module "csr_vpc" {
#     source = "terraform-aws-modules/vpc/aws"

#     name                 = "OnPrem_CSR"
#     cidr                 = "10.0.0.0/16"
#     azs                  = ["eu-west-2a"]
#     private_subnets      = ["10.0.1.0/24"]
#     public_subnets       = ["10.0.101.0/24"]
#     enable_dns_hostnames = true
#     enable_dns_support   = true

#     tags = {
#         Name = "OnPremCSR_VPC"
#     }
# }

module "onprem_csr" {
    source  = "github.com/mjasinski007/terraform-aws-onprem-csr.git"
    create_vpc = true

    vpc_id         = module.csr_vpc.vpc_id
    gig1_subnet_id = module.csr_vpc.public_subnets[0]
    gig2_subnet_id = module.csr_vpc.private_subnets[0]
    key_name       = var.csr_keypair
}