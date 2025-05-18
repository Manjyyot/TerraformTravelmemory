provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "frontend_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true

  tags = {
    Name = "Frontend Server"
  }

  provisioner "file" {
    source      = "../frontend"
    destination = "/home/ubuntu/frontend"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/keys/newManjyyot.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y docker.io",
      "cd /home/ubuntu/frontend",
      "sudo docker build -t travel-frontend .",
      "sudo docker run -d -p 80:80 travel-frontend"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/keys/newManjyyot.pem")
      host        = self.public_ip
    }
  }
}

resource "aws_instance" "backend_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true

  tags = {
    Name = "Backend Server"
  }

  provisioner "file" {
    source      = "../backend"
    destination = "/home/ubuntu/backend"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/keys/newManjyyot.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y docker.io",
      "cd /home/ubuntu/backend",
      "sudo docker build -t travel-backend .",
      "sudo docker run -d -p 5000:5000 travel-backend"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/keys/newManjyyot.pem")
      host        = self.public_ip
    }
  }
}

resource "aws_instance" "mongodb_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true

  tags = {
    Name = "MongoDB Server"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y docker.io",
      "sudo docker run -d -p 27017:27017 --name mongo mongo"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${path.module}/keys/newManjyyot.pem")
      host        = self.public_ip
    }
  }
}
