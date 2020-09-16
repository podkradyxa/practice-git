/*
Terraform template for AWS cloud
Made by Dmitrii Nadein
*/


/*
Setting up cloud provider
This section needs AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY from AWS account as env variable
Do NOT hardcode credentials here! Use "export" command to assign variables.
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
$ export AWS_DEFAULT_REGION="us-west-2"
*/
provider = "aws" {}

#Creating ec2 instance
resource "aws_instance" "WebServer" {
    ami_id        = "1234567890"
    instance_type = "t2.micro"
}

#Creating SecurityGroup
resource "aws_security_group" "MySecurityGroup1" {
  name = "SG-WebServer"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks     = ["0.0.0.0/0"]
  }


  tags ={
    Name = "SG-for-Terraform"
  }
}
#Outputs public IP after creating instance
output "public_ip" {
  value = "${aws_instance.WebServer.public_ip}"
}
