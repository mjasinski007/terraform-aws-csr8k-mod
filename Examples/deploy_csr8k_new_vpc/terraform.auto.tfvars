aws_profile              = "169444603265"
aws_region               = "eu-west-2"

vpc_name                 = "OnPremCSR8k"
vpc_cidr                 = "10.0.0.0/16"

ami_type                 = "BYOL"       # "BYOL" or "PAYG"
instance_type            = "c5.large"
admin_password           = "Cisco123#"
hostname                 = "OnpremCSR8k"
gig1_private_address     = ["10.0.255.10"]
gig2_private_address     = ["10.0.255.70"]

gig1_ingress_cidr_blocks = ["0.0.0.0/0"]
gig1_egress_cidr_blocks  = ["0.0.0.0/0"]
gig2_ingress_cidr_blocks = ["0.0.0.0/0"]
gig2_egress_cidr_blocks  = ["0.0.0.0/0"]