resource "aws_vpc" "this" {
    count                = var.create_vpc ? 1 : 0
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = var.enable_dns_hostnames
    enable_dns_support   = var.enable_dns_support

    tags = merge(
        { 
            "Name" = var.vpc_name 
        },

        var.tags,
    )
}

resource "aws_subnet" "public_subnet" {
    count             = var.create_vpc ? 1 : 0
    vpc_id            = aws_vpc.this[0].id
    availability_zone = local.az1
    cidr_block        = cidrsubnet(var.vpc_cidr, local.newbits, local.netnum - 1)

    tags = merge(
        {
            "Name" = "${var.vpc_name}-${var.public_subnet_suffix}-${local.az1}"
        }
    )
}
resource "aws_subnet" "private_subnet" {
    count             = var.create_vpc ? 1 : 0
    vpc_id            = aws_vpc.this[0].id
    availability_zone = local.az2
    cidr_block        = cidrsubnet(var.vpc_cidr, local.newbits, local.netnum - 2)

        tags = merge(
        {
            "Name" = "${var.vpc_name}-${var.private_subnet_suffix}-${local.az2}"
        }
    )
}


resource "aws_internet_gateway" "this" {
    count         = var.create_vpc ? 1 : 0
    #  count = local.create_public_subnets && var.create_igw ? 1 : 0
    vpc_id        = aws_vpc.this[0].id

    tags = merge(
        {
            "Name" = "${var.vpc_name}-igw"
        },
    )
}





# resource "aws_vpn_gateway" "this" {
#     count = local.create_vpc && var.enable_vpn_gateway ? 1 : 0

#     vpc_id            = local.vpc_id
#     amazon_side_asn   = var.amazon_side_asn
#     availability_zone = var.vpn_gateway_az

#     tags = merge(
#         { "Name" = var.name },
#         var.tags,
#         var.vpn_gateway_tags,
#         )
# }


## Generate Private-Key Pair
# resource "tls_private_key" "onprem_csr_priv_key" {
#     algorithm = "RSA"
#     rsa_bits  = 4096
# }

# resource "aws_key_pair" "onprem_csr_key_pair" {
#     key_name   = "OnPremCSR_KeyPair"       # Create a "myKey" to AWS!!
#     public_key = tls_private_key.onprem_csr_priv_key.public_key_openssh
# }

# resource "local_file" "local_ssh_key" {
#     filename = "${aws_key_pair.onprem_csr_key_pair.key_name}.pem"
#     content = tls_private_key.onprem_csr_priv_key.private_key_pem
#     file_permission = "0400"
# }

# # Create a Security Group for Cisco CSR Gig1
# resource "aws_security_group" "gig1_sg" {
#     vpc_id = var.vpc_id
#     name   = "OnPremCSR GigabitEthernet1 Security Group"

#     dynamic "ingress" {
#         for_each = local.ingress_ports
#         content {
#             description = ingress.key
#             from_port   = ingress.value.port
#             to_port     = ingress.value.port
#             protocol    = ingress.value.protocol
#             cidr_blocks = ingress.value.cidr_blocks
#         }
#     }
#     egress {
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = var.egress_cidr_blocks
#     }

#     tags = {
#         Name = "OnPremCSR_Gig1_SG"
#     }

#     lifecycle {
#         ignore_changes = [ingress, egress]
#     }
# }

# # Create a Security Group for Cisco CSR Gig2
# resource "aws_security_group" "gig2_sg" {
#     vpc_id = var.vpc_id
#     name   = "OnPremCSR GigabitEthernet2 Security Group"

#     dynamic "ingress" {
#         for_each = local.ingress_ports
#         content {
#             description = ingress.key
#             from_port   = ingress.value.port
#             to_port     = ingress.value.port
#             protocol    = ingress.value.protocol
#             cidr_blocks = ingress.value.cidr_blocks
#         }
#     }
#     egress {
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = var.egress_cidr_blocks
#     }

#     tags = {
#         Name = "OnPremCSR_Gig2_SG"
#     }

#     lifecycle {
#         ignore_changes = [ingress, egress]
#     }
# }

# # Create eni for CSR Gi1
# resource "aws_network_interface" "csr_gig1" {
#     description       = "OnPremCSR GigabitEthernet1"
#     subnet_id         = var.gig1_subnet_id
#     security_groups   = [aws_security_group.gig1_sg.id]
#     source_dest_check = false

#     tags = {
#         Name = "OnPremCSR_Gig1_ENI"
#     }
# }

# # Create eni for CSR Gi2
# resource "aws_network_interface" "csr_gig2" {
#     description       = "OnPremCSR GigabitEthernet2"
#     subnet_id         = var.gig2_subnet_id
#     security_groups   = [aws_security_group.gig2_sg.id]
#     source_dest_check = false

#     tags = {
#         Name = "OnPremCSR_Gig2_ENI"
#     }
# }

# # Allocate EIP for CSR Gi1
# resource "aws_eip" "this" {
#     domain               = "vpc" # used from version 5.x, before it, use  vpc = true
#     network_interface = aws_network_interface.csr_gig1.id

#     tags = {
#         "Name" = "OnPremCSR-Gig1-EIP@${var.csr_hostname}"
#     }
# }

# # Create CSR EC2 instance
# resource "aws_instance" "this" {
#     ami           = data.aws_ami.this.id
#     instance_type = var.instance_type
#     #key_name      = var.key_name
#     key_name      = aws_key_pair.onprem_csr_key_pair.key_name

#     network_interface {
#         network_interface_id = aws_network_interface.csr_gig1.id
#         device_index         = 0
#     }

#     network_interface {
#         network_interface_id = aws_network_interface.csr_gig2.id
#         device_index         = 1
#     }

#     user_data = local.csr_bootstrap

#     tags = {
#         Name = var.csr_hostname
#     }

#     lifecycle {
#         ignore_changes = [ami]
#     }
# }
