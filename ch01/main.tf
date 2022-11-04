provider "aws" {
	region = "us-east-2"
}

resource "aws_instance" "example" {
	ami		 				= "ami-0fb653ca2d3203ac1"
	instance_type = "t2.micro"
	vpc_security_group_ids = [aws_security_group.instance.id]


# adding custom bash script
	user_data			= <<-EOF
									#!/bin/bash
									echo "Hello world from phoodie" > index.html
									
									# execute native nohub cmmand to enable web server on ubuntu
									nohup busybox httpd -f -p 8080 &
									EOF
	# this will destroy the orig ec2 to create this new one
	user_data_replace_on_change = true

# Adding name below. Remember capital Name
	tags					= {
		Name				= "terraform-example"
	}
}

resource "aws_security_group" "instance" {
	name = "terraform-example-instance"

	ingress {
		from_port		= 8080
		to_port			= 8080
		protocol		= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}
