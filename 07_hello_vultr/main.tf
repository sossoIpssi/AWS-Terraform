#Conf fournisseur
terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "~> 2.14"
    }
  }
}

#Auth sur Vultr
provider "vultr" {
  api_key = var.vultr_api_key
}

#VM
resource "vultr_instance" "vm_docker" {
  region   = "cdg"
  plan     = "vc2-1c-1gb" #type machine
  os_id    = 387
  label    = "terraform-docker"
  hostname = "terraform-docker"

  user_data = file("${path.module}/user_data.sh")

  tags = ["terraform", "docker"]
}
