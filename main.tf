data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-tomcat-*-x86_64-hvm-ebs-nami"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["979382823631"] # Bitnami
}

// Defining VPC block
data "aws_vpc" "default" {
  default = true
}

//Define instance resource for AWS
resource "aws_instance" "blog" {
  ami              = data.aws_ami.app_ami.id
  instance_type    = var.instance_type
  vpc_security_group_ids = [module.blog.security_group_id]

  tags = {
    Name = "Instance Created From TF"
  }
}

// Define security group resource
module "blog" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.16.2"
  name    = "blog"
  vpc_id  = data.aws_vpc.default.id

  ingress_rules       = ["http_80_tcp","https_443_tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules        = [ "all-all" ]
  egress_cidr_blocks  = ["0.0.0.0/0"]
}