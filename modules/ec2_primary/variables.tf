variable "ami_id" {
  description = "AMI ID to use for the Primary Server"
  type        = string
  default     = "ami-0a7d80731ae1b2435"
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "m5.large"
}
variable "subnet_id" {
  description = "Subnet to launch the instance in"
  type        = string
  default     = "subnet-0af52d0bd637fe797"
}
variable "security_group_id" {
  description = "ID of the security group to associate with the instance"
  type        = string
}
variable "pub_key" {
  description = "SSH public key for SSH access to the instance"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOYsA+hHuP13L9ANvRdcokzfVL5xAPFxJPpwK/NTKMk+ ubuntu@ptran1124"
}

variable "hostname" {
  description = "Optional full hostname (FQDN) override; leave empty to use hostname_short + domain_suffix"
  type        = string
  default     = ""
}

variable "hostname_short" {
  description = "Short hostname to set on the instance"
  type        = string
  default     = "pe-primary"
}

variable "domain_suffix" {
  description = "DNS suffix appended to hostname_short to form the FQDN"
  type        = string
  default     = "triplo.psedemos.com"
}

variable "console_password" {
  description = "Console admin password to inject into the Puppet Enterprise config template"
  type        = string
  sensitive   = true
  default     = "HelloDolly1!"
}