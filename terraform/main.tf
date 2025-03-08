resource "aws_instance" "mongodb_server" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0d43e28166c19ab9d"
  key_name      = "newManjyyot"
  
  # Use security group ID instead of name
  vpc_security_group_ids = ["sg-0f9cc3bcfb3acb772"]   # MongoDB Security Group ID
  
  tags = {
    Name = "MongoDB Server"
  }
}

resource "aws_instance" "frontend_server" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0d43e28166c19ab9d"
  key_name      = "newManjyyot"
  
  # Use security group ID instead of name
  vpc_security_group_ids = ["sg-0f9cc3bcfb3acb772"]   # Frontend Security Group ID
  
  tags = {
    Name = "Frontend Server"
  }
}

resource "aws_instance" "backend_server" {
  ami           = "ami-04b4f1a9cf54c11d0"
  instance_type = "t2.micro"
  subnet_id     = "subnet-0d43e28166c19ab9d"
  key_name      = "newManjyyot"
  
  # Use security group ID instead of name
  vpc_security_group_ids = ["sg-0f9cc3bcfb3acb772"]   # Backend Security Group ID
  
  tags = {
    Name = "Backend Server"
  }
}
