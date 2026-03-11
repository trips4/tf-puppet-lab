module "primary_sg" {
  source = "./modules/sg_primary"
  additional_ingress_rules = [
    {
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["172.31.0.0/16", "66.242.207.174/32"]
      ipv6_cidr_blocks = []
      description      = "PE Web Console access from internal and MyIP"
    }
  ]
}

module "ec2_primary" {
  source = "./modules/ec2_primary"
  hostname_short = "lab2-prim01"
  domain_suffix = "triplo.psedemos.com"
  security_group_id = module.primary_sg.security_group_id
}