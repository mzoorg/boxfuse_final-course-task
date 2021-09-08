variable username {
    type = string
    sensitive = true
}

variable ubuntu_image_id {
    type = string
}

variable public_key {
    type = string
}

variable "user_security_groups" {
  type = string
}