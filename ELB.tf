resource aws_elb "myelb"{
    name = "myelb"
	subnets = [aws_subnet.sn1.id,aws_subnet.sn2.id,aws_subnet.sn3.id]
	listener{
	   instance_port = "80"
	   instance_protocol = "http"
	   lb_port = "80"
	   lb_protocol = "http"
	}
}
resource aws_security_group "sg1" {
    vpc_id = aws_vpc.vpc1.id
	name = "sg"
	description = "sg"
}
resource aws_security_group_rule "rule1"{
    security_group_id = aws_security_group.sg1.id
	type = "ingress"
	from_port = "80"
	to_port = "80"
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
}
resource aws_security_group_rule "rule2"{
    security_group_id = aws_security_group.sg1.id
	type = "egress"
	from_port = "80"
	to_port = "80"
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
}
resource aws_security_group_rule "all-traffic"{
    security_group_id = aws_security_group.sg1.id
	type = "egress"
	from_port = "0"
	to_port = "0"
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
}
resource aws_security_group_rule "rule3"{
    security_group_id = aws_security_group.sg1.id
	type = "egress"
	from_port = "443"
	to_port = "443"
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
}
/*
 in list, when we using dynamically dont use double quotes [""] like in line no 162
*/ 
resource aws_instance "i1"{
    ami = "ami-055d15d9cfddf7bd3"
	instance_type = "t2.micro"
	subnet_id = aws_subnet.sn4.id
	vpc_security_group_ids = [aws_security_group.sg1.id]
    user_data = <<-EOF
    #!/bin/bash
	apt-get update
	apt-get install apache2 -y
	EOF
}
resource aws_instance "i2"{
    ami = "ami-055d15d9cfddf7bd3"
	instance_type = "t2.micro"
	subnet_id = aws_subnet.sn5.id
	vpc_security_group_ids = [aws_security_group.sg1.id]
    user_data = <<-EOF
    #!/bin/bash
	apt-get update
	apt-get install apache2 -y
	EOF	
}
resource aws_instance "i3"{
    ami = "ami-055d15d9cfddf7bd3"
	instance_type = "t2.micro"
	subnet_id = aws_subnet.sn6.id
	vpc_security_group_ids = [aws_security_group.sg1.id]
    user_data = <<-EOF
    #!/bin/bash
	apt-get update
	apt-get install apache2 -y
	EOF	
}
resource aws_elb_attachment "elb-attch1"{
    elb = aws_elb.myelb.id
	instance = aws_instance.i1.id
}
resource aws_elb_attachment "elb-attch2"{
    elb = aws_elb.myelb.id
	instance = aws_instance.i2.id
}
resource aws_elb_attachment "elb-attch3"{
    elb = aws_elb.myelb.id
	instance = aws_instance.i3.id
}