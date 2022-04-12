/*
// instance subnet_id had given wrong so to avoid eip creation we use (depends on) 
resource aws_instance "i1-eip"{
   ami = "ami-055d15d9cfddf7bd3"
   instance_type = "t2.micro"
   subnet_id = "subnet-00ee15bf52a3850fa"
}
resource aws_eip "eip1"{
   depends_on = [aws_instance.i1]
}
resource aws_eip_association "eip1i1" {
   instance_id = aws_instance.i1-eip.id
   allocation_id = aws_eip.eip1.id
}
*/