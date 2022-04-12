/*
resource aws_vpc "vpc1"{
   cidr_block = "10.0.0.0/16"
   tags={
      "Name" = "myvpc1"
   }
} 
resource aws_subnet "sn1"{
   vpc_id = aws_vpc.vpc1.id
   cidr_block = "10.0.0.0/24"
   availability_zone = "ap-southeast-1a"
   map_public_ip_on_launch = "true"
   tags ={
      "Name" = "sn1-vpc1"
    }
}
resource aws_subnet "sn2"{
   vpc_id = aws_vpc.vpc1.id
   cidr_block = "10.0.1.0/24"
   availability_zone = "ap-southeast-1b"
   tags ={
      "Name" = "sn2-vpc1"
    }
}
resource aws_subnet "sn3"{
   vpc_id = aws_vpc.vpc1.id
   cidr_block = "10.0.2.0/24"
   availability_zone = "ap-southeast-1c"
   map_public_ip_on_launch = "true"
   tags ={
      "Name" = "sn3-vpc1"
    }
}
resource aws_subnet "sn4"{
   vpc_id = aws_vpc.vpc1.id
   cidr_block = "10.0.3.0/24"
   availability_zone = "ap-southeast-1a"
   tags ={
      "Name" = "sn4-vpc1"
    }
}
resource aws_subnet "sn5"{
   vpc_id = aws_vpc.vpc1.id
   cidr_block = "10.0.4.0/24"
   availability_zone = "ap-southeast-1b"
   tags ={
      "Name" = "sn5-vpc1"
    }
}
resource aws_subnet "sn6"{
   vpc_id = aws_vpc.vpc1.id
   cidr_block = "10.0.5.0/24"
   availability_zone = "ap-southeast-1c"
   tags ={
      "Name" = "sn6-vpc1"
    }
}
resource aws_internet_gateway "igw"{
   vpc_id = aws_vpc.vpc1.id
   tags={
      "Name" = "igw"
	}
}
resource aws_route_table "rt1-vpc1"{
    vpc_id = aws_vpc.vpc1.id
	route{
	       cidr_block     = "0.0.0.0/0"
	       gateway_id = aws_internet_gateway.igw.id
	}
	tags={ 
	     "Name" = "rt1=pub"
	}
}
resource aws_route_table_association "a"{
    route_table_id = aws_route_table.rt1-vpc1.id
	subnet_id = aws_subnet.sn1.id
}
resource aws_route_table_association "b"{
    route_table_id = aws_route_table.rt1-vpc1.id
	subnet_id = aws_subnet.sn2.id
}
resource aws_route_table_association "c"{
    route_table_id = aws_route_table.rt1-vpc1.id
	subnet_id = aws_subnet.sn3.id
}
resource aws_eip "nateip"{
}
resource aws_nat_gateway "nat1"{
    allocation_id = aws_eip.nateip.id
    subnet_id     = aws_subnet.sn1.id
    tags = {
       Name = "nat-gw"
    }
}
resource aws_route_table "rt2-vpc1"{
    vpc_id = aws_vpc.vpc1.id
	route{
	       cidr_block     = "0.0.0.0/0"
	       nat_gateway_id = aws_nat_gateway.nat1.id
	}
	tags={ 
	     "Name" = "rt2=pri"
	}
}
resource aws_route_table_association "aa"{
    route_table_id = aws_route_table.rt2-vpc1.id
	subnet_id = aws_subnet.sn4.id
}

resource aws_route_table_association "bb"{
    route_table_id = aws_route_table.rt2-vpc1.id
	subnet_id = aws_subnet.sn5.id
}
resource aws_route_table_association "cc"{
    route_table_id = aws_route_table.rt2-vpc1.id
	subnet_id = aws_subnet.sn6.id
}
*/