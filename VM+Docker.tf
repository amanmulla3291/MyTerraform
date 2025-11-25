provider "aws" {
    region = "ap-south-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical owner ID
}

resource "aws_instance" "ubuntu_ec2" {
    count = 2
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "Linux-K1" # Uncomment and replace with your key pair name
  vpc_security_group_ids = ["sg-079ad479466eb7ea6"] # Replace with your security group ID
  availability_zone      = element(["ap-south-1a", "ap-south-1b"], count.index)
  user_data = file("${path.module}/userdata.sh")


  tags = {
    Name = "VM${count.index + 1}"
  }
}