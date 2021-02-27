variable project {
  description = "Project ID"
  default     = "winged-polygon-303720"
}

variable region {
  description = "Region"

  # Значение по умолчанию
  default = "europe-west1"
}

variable zone {
  description = "Zone"

  default = "europe-west1-b"
}

variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
  default     = "~/.ssh/ll_rsa.pub"
}

variable private_key_path {
  # Описание переменной
  description = "Path to the private key"
  default     = "~/.ssh/ll_rsa"
}

variable disk_image {
  description = "Disk image"
  default     = "reddit-base"
}

