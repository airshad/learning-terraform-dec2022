variable "instance_type" {
 description = "Type of EC2 instance to provision"
 default     = "t3.nano"
}

variable "ami_filter" {
  description = "Name and Owner for AMI"

  type = object({
    name  = string
    owner = string
  })

  default = {
    name   = "bitnami-tomcat-*-x86_64-hvm-ebs-nami"
    owner  = "979382823631"
  }
}

variable "environment" {
  description = "Environment Variables for Development Env"

  type = object({
    name            = string
    network_prefix  = string
  })
  default = {
    name            = "dev"
    network_prefix  = "10.0"
  }
}

variable "min_size" {
  description = "Minimum size of instance in ASG"
  default = 1
}

variable "max_size" {
  description = "Maximum size of instance in ASG"
  default     = 2
}

variable "network" {
  description = "Network Port and Protocol"

  type = object({
    port     = number
    protocol = string
  })

  default = {
    port     = 80
    protocol = "HTTP"
  }
}
