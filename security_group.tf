module "rds_ec2_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "bitcube_sg"
  description = "Security group for my EC2 with HTTP and SSH ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  /*===Inbound Rules===*/
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow SSH from your IP address"
    },
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow Postgres outbound traffic"
    },
    {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow ICMP inbound traffic to ping instances"
    }
  ]

  /*===Outbound Rules===*/
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]

}

output "rds_group_id" {
  value = module.rds_ec2_sg.security_group_id
}
