resource aws_instance "ins1"{
   ami = "ami-055d15d9cfddf7bd3"
   instance_type = "t2.micro"
   subnet_id = "subnet-00ee15bf52a3850fa"
}
resource aws_ebs_volume "v1"{
    size = 5
	availability_zone = aws_instance.ins1.availability_zone
	type = "gp2"
}
resource aws_volume_attachment "i1v1"{
    instance_id = aws_instance.ins1.id
	volume_id = aws_ebs_volume.v1.id
	device_name = "/dev/sdf"
}
output "sn1"{
  value= aws_instance.ins1.subnet_id
}
output "azs"{
   value = aws_instance.ins1.availability_zone
}