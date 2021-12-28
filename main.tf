/*
resource "aws_vpc" "dev-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "dev-vpc"
    }
}

resource "aws_security_group" "ec2-sg" {
    name = "ec2-sg"
    vpc_id = aws_vpc.dev-vpc.id

   dynamic "ingress" {

       for_each = var.ports

       content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
       }
   }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}
*/

resource "aws_instance" "myec2" {
    
    ami = var.ami_ids["us-east-2"]
    instance_type = "t2.micro"
    count = 3
    tags = {
        Name = var.developer_names["${count.index}"]
    }
}

output "ec2-instance-arns" {
    value = zipmap(aws_instance.myec2[*].tags.Name, aws_instance.myec2[*].public_ip)
}

resource "aws_db_instance" "mydb" {
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mysql-instance"
  username             = "root"
  password             = file("../dbpassword.txt")
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
