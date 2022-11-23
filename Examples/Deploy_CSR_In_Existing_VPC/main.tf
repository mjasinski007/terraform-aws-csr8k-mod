module "onprem_csr1k" {
    source  = "github.com/mjasinski007/terraform-aws-onprem-csr.git"

    vpc_id         = var.existing_vpc_id
    gig1_subnet_id = var.gig1_existing_subnet_id # Public Subnet
    gig2_subnet_id = var.gig2_existing_subnet_id # Private Subnet
    key_name       = var.csr_keypair
}