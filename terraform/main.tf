provider "aws" {
  region     = var.aws_region
}

resource "aws_instance" "mongodb_server" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0d43e28166c19ab9d"
  key_name      = "newManjyyot"

  vpc_security_group_ids = ["sg-0f9cc3bcfb3acb772"]

  tags = {
    Name = "MongoDB Server"
  }
}

resource "aws_instance" "frontend_server" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0d43e28166c19ab9d"
  key_name      = "newManjyyot"

  vpc_security_group_ids = ["sg-0f9cc3bcfb3acb772"]

  tags = {
    Name = "Frontend Server"
  }
}

resource "aws_instance" "backend_server" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0d43e28166c19ab9d"
  key_name      = "newManjyyot"

  vpc_security_group_ids = ["sg-0f9cc3bcfb3acb772"]

  tags = {
    Name = "Backend Server"
  }
}
