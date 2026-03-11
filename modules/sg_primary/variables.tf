variable "vpc_id" {
  description = "AWS VPC ID where the Security Group will be created"
  type        = string
  default     = "vpc-0d06538a9701e9bf3"
}

variable "sg_name" {
  description = "Name of the Security Group"
  type        = string
  default     = "pe-primary-sg"
}

variable "sg_description" {
  description = "Description of the Security Group"
  type        = string
  default     = "Inbound and Outbound rules for Puppet Primary"
}

variable "ingress_rules" {
  description = "List of ingress rule maps"
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
    description      = string
  }))
  default = [
    {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["172.31.0.0/16", "66.242.207.174/32"]
      ipv6_cidr_blocks = []
      description      = "Default SSH access from VPC and specific IP"
    }
  ]
}

variable "additional_ingress_rules" {
  description = "Additional ingress rule maps appended to ingress_rules"
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
    description      = string
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rule maps"
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
    description      = string
  }))
  default = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      description      = "Allow all outbound traffic"
    }
  ]
}

variable "additional_egress_rules" {
  description = "Additional egress rule maps appended to egress_rules"
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
    description      = string
  }))
  default = []
}