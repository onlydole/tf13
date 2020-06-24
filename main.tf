data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["137112412989"] # Amazon
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-*"]
  }
}

module "ec2_cluster" {
  # Step 1 (default)
  subnet_id = tolist(data.aws_subnet_ids.all.ids)[0]

  # Step 2 - for_each example
  # for_each = data.aws_subnet_ids.all.ids
  # subnet_id     = each.value

  # Step 3 - depends_on example
  # depends_on = [aws_s3_bucket.top_secret_data]

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name = var.cluster_name
  ami  = data.aws_ami.amazon_linux_2.id

  instance_type = "t3.micro"
  monitoring    = true

  tags = {
    Terraform = "true"
  }
}

# Step 3 - depends_on example
# resource "aws_s3_bucket" "top_secret_data" {
#   bucket_prefix = "top-secret-data"
#   acl    = "private"

#   tags = {
#     Terraform        = "true"
#   }
# }
