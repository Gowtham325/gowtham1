resource aws_vpc "vpc2"{
    cidr_block = var.v_vpc_cidr
	tags={
	  "Name" = "vpc2"
	}
}
resource aws_subnet "pub-sub"{
    vpc_id = aws_vpc.vpc2.id
	count = length(var.v_pub_sn_cidrs)
	availability_zone = var.v_azs[count.index]
	cidr_block = var.v_pub_sn_cidrs[count.index]
	tags={
	    "Name" = join("-",["pub","sn",count.index])
	}
}
resource aws_subnet "prv-sub"{
    vpc_id = aws_vpc.vpc2.id
	count = length(var.v_prv_sn_cidrs)
	availability_zone = var.v_azs[count.index]
	cidr_block = var.v_prv_sn_cidrs[count.index]
	tags={
	    "Name" = join("-",["prv","sn",count.index])
	}
}
/*
output "pub_subnet_ids"{
    value = aws_subnet.pub-sub.*.id
}
output "pub_subnet_azs"{
    value = aws_subnet.pub-sub.*.availability_zone
}
*/
resource aws_internet_gateway "igw"{
    vpc_id = aws_vpc.vpc2.id
}
resource aws_route_table "pub_rt"{
    vpc_id = aws_vpc.vpc2.id
	tags={
	 	 "Name" = "rt1"
	}
	route{
	  cidr_block = "0.0.0.0/0"
	  gateway_id = aws_internet_gateway.igw.id
	}
}
resource aws_route_table_association "arta"{
    count = length(var.v_pub_sn_cidrs)
	subnet_id = aws_subnet.pub-sub.*.id[count.index]
    route_table_id = aws_route_table.pub_rt.id
}
resource aws_lb_target_group "tg"{
    count = length(var.v_tg)
	name = var.v_tg[count.index]
	port        = var.v_tg_port[var.v_tg[count.index]]
    protocol    = "HTTP"
    vpc_id      = aws_vpc.vpc2.id
}
/*
output "testmaps"{
    value=var.v_tg_port["PrepaidTg"]
}
*/
resource aws_security_group "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc2.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
}
  egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
}
  egress {
    from_port        = 90
    to_port          = 90
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   }
}
resource aws_lb "test-lb"{
   name               = "test-lb"
   load_balancer_type = "application"
   security_groups    = [aws_security_group.allow_tls.id]
   subnets            = aws_subnet.pub-sub.*.id
}
resource aws_lb_listener "addtg1"{
   load_balancer_arn = aws_lb.test-lb.arn
   port              = "80"
   protocol          = "HTTP"
   default_action {
    type             = "forward"
	target_group_arn = aws_lb_target_group.tg.*.arn[0]
  }
}
resource aws_lb_listener_rule "rule1"{
   listener_arn = aws_lb_listener.addtg1.arn
   condition {
      path_pattern{
	  values = ["*Prepaid*"]
	  }
	}
	action {
	 type             = "forward"
	target_group_arn = aws_lb_target_group.tg.*.arn[0]
    }
}
resource aws_lb_listener_rule "rule2"{
   listener_arn = aws_lb_listener.addtg1.arn
   condition {
      path_pattern{
	  values = ["*Postpaid*"]
	  }
	}
	action {
	  type             = "forward"
	target_group_arn = aws_lb_target_group.tg.*.arn[1]
    }
}