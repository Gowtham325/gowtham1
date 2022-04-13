variable "vpc_cidr"{
   type = string
   default = "10.0.0.0/24"
}
variable "sub_cidrs"{
   type = list
   default = ["10.0.0.0/25","10.0.0.128/25"]
resource aws_vpc "vpc1"{
    cidr_block = var.vpc_cidr
}
resource aws_subnet "subnets"{
    count = length(var.sub_cidrs)
    vpc_id = aws_vpc.vpc1.id
	cidr_block = var.sub_cidrs[count.index]
}