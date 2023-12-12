resource "aws_vpc" "this" {
    count                = var.create_vpc ? 1 : 0
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = var.enable_dns_hostnames
    enable_dns_support   = var.enable_dns_support

    tags = merge(
        {
            Name = "${var.vpc_name}-vpc"
        },

        var.tags,
    )
}

resource "aws_subnet" "gig1_public_subnet" {
    count                = var.create_vpc ? 1 : 0
    vpc_id               = aws_vpc.this[0].id
    availability_zone    = local.az1
    cidr_block           = cidrsubnet(var.vpc_cidr, local.newbits, local.netnum - 4)

    tags = merge(
        {
            Name = "${var.vpc_name}-${var.public_subnet_suffix}-${local.az1}"
        }
    )
}
resource "aws_subnet" "gig2_private_subnet" {
    count             = var.create_vpc ? 1 : 0
    vpc_id            = aws_vpc.this[0].id
    availability_zone = local.az1
    cidr_block        = cidrsubnet(var.vpc_cidr, local.newbits, local.netnum - 3)

        tags = merge(
        {
            Name = "${var.vpc_name}-${var.private_subnet_suffix}-${local.az1}"
        }
    )
}

resource "aws_internet_gateway" "igw" {
    count         = var.create_vpc && var.create_igw ? 1 : 0
    vpc_id        = aws_vpc.this[0].id

    tags = merge(
        {
            "Name" = "${var.vpc_name}-igw"
        },
    )
}

resource "aws_route_table" "public_rtb" {
    count = var.create_vpc ? 1 : 0
    vpc_id = aws_vpc.this[0].id

    tags = merge(
        {
            "Name" = "${var.vpc_name}-${var.public_subnet_suffix}-rtb"
        }
    )
}


resource "aws_route" "default_route" {
    count                  = var.create_vpc && var.create_igw ? 1 : 0
    route_table_id         = aws_route_table.public_rtb[0].id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.igw[0].id
    timeouts {
        create = "5m"
    }
}


resource "aws_route_table" "private_rtb" {
    count = var.create_vpc ? 1 : 0
    vpc_id = aws_vpc.this[0].id

    tags = merge(
        {
            "Name" = "${var.vpc_name}-${var.private_subnet_suffix}-rtb"
        }
    )
}

resource "aws_route_table_association" "public_rtb_assoc" {
    count = var.create_vpc ? 1 : 0

    subnet_id      = element(aws_subnet.gig1_public_subnet[*].id, count.index)
    route_table_id = aws_route_table.public_rtb[0].id
}

resource "aws_route_table_association" "private_rtb_assoc" {
    count = var.create_vpc ? 1 : 0

    subnet_id      = element(aws_subnet.gig2_private_subnet[*].id, count.index)
    route_table_id = aws_route_table.private_rtb[0].id
}


## Generate Private-Key Pair
resource "tls_private_key" "private_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
    key_name   = "CSR8k_KeyPair"       # Create a "myKey" to AWS!!
    public_key = tls_private_key.private_key.public_key_openssh
}

resource "local_file" "local_ssh_key" {
    filename = "${aws_key_pair.key_pair.key_name}.pem"
    content = tls_private_key.private_key.private_key_pem
    file_permission = "0400"
}

# Create a Security Group for Cisco CSR Gig0
resource "aws_security_group" "gig1_nsg" {
    vpc_id = aws_vpc.this[0].id
    name   = "CSR8k GigabitEthernet1 NSG"

    dynamic "ingress" {
        for_each = local.ingress_ports
        content {
            description = ingress.key
            from_port   = ingress.value.port
            to_port     = ingress.value.port
            protocol    = ingress.value.protocol
            cidr_blocks = ingress.value.cidr_blocks
        }
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = var.gig1_egress_cidr_blocks
    }

    tags = {
        Name = "CSR8k_Gig1_NSG"
    }

    lifecycle {
        ignore_changes = [ingress, egress]
    }
}

# Create a Security Group for Cisco CSR Gig2
resource "aws_security_group" "gig2_nsg" {
    vpc_id = aws_vpc.this[0].id
    name   = "CSR8k GigabitEthernet2 NSG"

    dynamic "ingress" {
        for_each = local.ingress_ports
        content {
            description = ingress.key
            from_port   = ingress.value.port
            to_port     = ingress.value.port
            protocol    = ingress.value.protocol
            cidr_blocks = ingress.value.cidr_blocks
        }
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = var.gig2_egress_cidr_blocks
    }

    tags = {
        Name = "CSR8k_Gig2_NSG"
    }

    lifecycle {
        ignore_changes = [ingress, egress]
    }
}

# # Create eni for CSR Gi1
resource "aws_network_interface" "gig1_nic" {
    description             = "CSR8k GigabitEthernet1"
    subnet_id               = aws_subnet.gig1_public_subnet[0].id
    security_groups         = [aws_security_group.gig1_nsg.id]
    source_dest_check       = false
    private_ip_list_enabled = var.private_ip_list_enabled
    private_ip_list         = var.gig1_private_address

    tags = {
        Name = "CSR8k_Gig1_ENI"
    }
}

# # Create eni for CSR Gi2
resource "aws_network_interface" "gig2_nic" {
    description             = "Cisco CSR GigabitEthernet2"
    subnet_id               = aws_subnet.gig2_private_subnet[0].id
    security_groups         = [aws_security_group.gig2_nsg.id]
    source_dest_check       = false
    private_ip_list_enabled = var.private_ip_list_enabled
    private_ip_list         = var.gig2_private_address

    tags = {
        Name = "CSR8k_Gig2_ENI"
    }
}

# # Allocate EIP for CSR Gig1
resource "aws_eip" "eip" {
    domain               = "vpc" # used from version 5.x, before it, use  vpc = true
    network_interface = aws_network_interface.gig1_nic.id

    tags = {
        "Name" = "CSR8k-Gig1-EIP@${var.hostname}"
    }
}

# # Create CSR EC2 instance
resource "aws_instance" "this" {
    ami           = data.aws_ami.ami_csr.id
    instance_type = var.instance_type
    key_name      = aws_key_pair.key_pair.key_name
    network_interface {
        network_interface_id = aws_network_interface.gig1_nic.id
        device_index         = 0
    }

    network_interface {
        network_interface_id = aws_network_interface.gig2_nic.id
        device_index         = 1
    }

    user_data = local.csr_bootstrap

    tags = {
        Name = var.hostname
    }

    lifecycle {
        ignore_changes = [ami]
    }
}
