module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "ecs-instance"

  instance_type               = "t2.micro"
  key_name                    = data.aws_key_pair.key_name.key_name
  monitoring                  = false
  vpc_security_group_ids      = [module.rds_ec2_sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  ami                         = var.ami
  iam_instance_profile        = data.aws_iam_role.ec2_s3_role.name
  user_data                   = file("user_data.sh")

}