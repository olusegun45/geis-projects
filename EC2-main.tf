# Resource-7: Creat Security Group for Web Server
resource "aws_security_group" "project-SG" {
  name        = "project-SG"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = aws_vpc.Project-1-VPC.id

  ingress    {
      description      = "TLS from Internet"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
          }
          
  ingress    {
      description      = "SSH Connection"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  ingress    {
      description      = "All traffic"
      from_port         = 0
      to_port           = 65535
      protocol          = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  egress     {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  tags = {
    Name = "project-SG"
  }
}

# Resource-8: Creat Linux EC2 for Jenkins Server
resource "aws_instance" "Jenkins-server" {
  ami           = "ami-051dfed8f67f095f5"
  instance_type = "t2.micro"
  key_name      = "OHIO-KP"
  subnet_id     = aws_subnet.Project-1-VPC-Pub-sbn.id
  vpc_security_group_ids = [aws_security_group.project-SG.id]
  user_data = <<-EOF
              #!/bin/bash
              yum install httpd -y
              echo "Welcome to Patara Web Application Server" > /var/www/html/index.html
              yum update -y
              service httpd start
              EOF

  tags = {
    Name = "Jenkins-server"
  }
}

/*
# Resource-9: Creat Ubuntu Server for EKS
resource "aws_instance" "EKS-server" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  key_name      = "Ohio-Bastion-KP"
  subnet_id     = aws_subnet.Project-1-VPC-Pub-sbn.id
  vpc_security_group_ids = [aws_security_group.project-SG.id]

  tags = {
    Name = "EKS-server"
  }
}

# Resource-10: Creat linux Server for Ansible Master Controller
resource "aws_instance" "Ansible-Master-Controller" {
  ami           = "ami-074cce78125f09d61"
  instance_type = "t2.micro"
  key_name      = "Ohio-Bastion-KP"
  subnet_id     = aws_subnet.Project-1-VPC-Pub-sbn.id
  vpc_security_group_ids = [aws_security_group.project-SG.id]

  tags = {
    Name = "Ansible-Master-Controller"
  }
}
*/