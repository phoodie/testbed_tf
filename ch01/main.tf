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
# creating a security profile to allow inbound and outbount traffic of ec2
resource "aws_security_group" "instance" {
	name = "terraform-example-instance"

	ingress {
		from_port		= 8080
		to_port			= 8080
		protocol		= "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

# Deploying a config web server: creating variables

variable "object_example_with_error" {
	description 	= "An example of a structural type in Terraform with an error"
	type					= object({
		name			= string
		age				= number
		tags			= list(string)
		enabled		= bool
})

# populate variable with value
default = {
	name		  = "value1"
	age			  = "42"
	tags		  =	["a", "b", "c"]
	enabled 	= "invalid"
	}

}
