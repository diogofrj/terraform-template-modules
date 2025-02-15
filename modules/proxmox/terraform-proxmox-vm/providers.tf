
provider "proxmox" {
  endpoint = var.endpoint
  api_token = var.api_token
  insecure  = true
  ssh {
    agent    = true
    username = "terraform"
  }
}