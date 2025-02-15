packer {
  required_plugins {
    proxmox = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "proxmox_username" {
  type = string
  description = "API token for proxmox"
  default = "root@pam"
}

variable "proxmox_password" {
  type = string
  description = "API token secret for proxmox"
  sensitive = true
  default = "homelab"
}

variable "proxmox_api_url" {
  type = string
  description = "API url for proxmox"
  default = "https://192.168.31.180:8006/api2/json"
}

source "proxmox-iso" "ubuntu-server" {
  # Proxmox Connection Settings
  proxmox_url = var.proxmox_api_url
  username = var.proxmox_username
  password = var.proxmox_password
  insecure_skip_tls_verify = true

  # VM General Settings
  node = "bee"
  vm_id = "9003"
  vm_name = "ubuntu-server-template-24.04"
  template_description = "Ubuntu Server 24.04 Template with Docker"
  qemu_agent = true

  # VM OS Settings
  #   iso_url = "https://releases.ubuntu.com/noble/ubuntu-24.04.1-live-server-amd64.iso"
#   iso_checksum = "sha256:1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef"
boot_iso {
  iso_file = "local:iso/ubuntu-24.04.1-live-server-amd64.iso"
  iso_storage_pool = "local"
  unmount = true
}
  # VM System Settings
  cores = "1"
  memory = "2048"
  sockets = "1"

  # VM Hard Disk Settings
  scsi_controller = "virtio-scsi-pci"
  disks {
    disk_size = "20G"
    format = "raw"
    storage_pool = "local-lvm"

    type = "virtio"
  }

  # VM Network Settings
  network_adapters {
    model = "virtio"
    bridge = "vmbr0"
    firewall = false
  }

  # VM Cloud-Init Settings
  cloud_init = true
  cloud_init_storage_pool = "local-lvm"

  # PACKER Boot Commands
  boot_command = [
    "<esc><wait>",
    "e<wait>",
    "<down><down><down><end>",
    "<bs><bs><bs><bs><bs>",
    "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"
  ]

  # PACKER Autoinstall Settings
  http_directory = "."
  ssh_username = "lab"
  ssh_password = "lab"
  ssh_timeout = "2m"
}

build {
  name = "ubuntu-server-template-24.04"
  sources = ["source.proxmox-iso.ubuntu-server"]

  # Provisioning the VM Template for Cloud-Init Integration
  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 1; done",
      "sudo rm /etc/ssh/ssh_host_*",
      "sudo truncate -s 0 /etc/machine-id",
      "sudo apt -y autoremove --purge",
      "sudo apt -y clean",
      "sudo apt -y autoclean",
      "sudo cloud-init clean",
      "sudo rm -f /etc/cloud/cloud.cfg.d/subiquity-disable-cloudinit-networking.cfg",
      "sudo sync"
    ]
  }

  # Provisioning the VM Template with Docker
  provisioner "shell" {
    pause_before = "1m"
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y ca-certificates curl gnupg lsb-release",
      "sudo mkdir -p /etc/apt/keyrings",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.asc",
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update", 
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose",
      "sudo systemctl enable docker",
      "sudo systemctl start docker"
    ]
  }
}