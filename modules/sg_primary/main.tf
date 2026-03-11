resource "aws_security_group" "PrimarySG" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = var.vpc_id
}

locals {
  effective_ingress_rules = concat(var.ingress_rules, var.additional_ingress_rules)
  effective_egress_rules  = concat(var.egress_rules, var.additional_egress_rules)
}

# Ingress rules
resource "aws_security_group_rule" "ingress_rules" {
  for_each          = { for idx, rule in local.effective_ingress_rules : idx => rule }
  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  ipv6_cidr_blocks  = each.value.ipv6_cidr_blocks
  security_group_id = aws_security_group.PrimarySG.id
  description       = each.value.description
}

# Egress rules
resource "aws_security_group_rule" "egress_rules" {
  for_each          = { for idx, rule in local.effective_egress_rules : idx => rule }
  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  ipv6_cidr_blocks  = each.value.ipv6_cidr_blocks
  security_group_id = aws_security_group.PrimarySG.id
  description       = each.value.description
}