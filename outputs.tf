output "csr_gig1" {
    description = "CSR GigabitEthernet1 network insterface as an object with all of it's attributes."
    value       = aws_network_interface.csr_gig1
}

output "csr_gig2" {
    description = "CSR GigabitEthernet2 network insterface as an object with all of it's attributes."
    value       = aws_network_interface.csr_gig2
}

output "csr_instance" {
    description = "The created CSR instance as an object with all of it's attributes."
    value       = aws_instance.this
}