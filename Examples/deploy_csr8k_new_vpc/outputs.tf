output "SSH_To_CSR8k_Instance" {
  value = "ssh -i CSR8k_KeyPair.pem admin@${module.csr8k_vpc.gig1_eip.public_ip}"
}