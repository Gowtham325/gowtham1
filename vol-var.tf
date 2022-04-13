variable "volumesize"{
}
resource  aws_ebs_volume "v1"{
    count = 2
    availability_zone = "ap-southeast-1a"
	size = var.volumesize
	type = "gp2"
}