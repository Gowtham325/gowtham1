variable "a"{
   type = string
   default = "gowtham"
}
variable "b"{
   type = list
   default = [10,20,30,40]
}
variable "c"{
    default={
       "Name" = "gowthamnaik"
       "age" = 24
	}
}
output "avalue"{
   value = var.a
}
output "bvalue"{
   value = var.b[0]
}
output "noel"{
   value = length(var.b)
}
output "cvalue"{
   value = var.c["age"]
}
output "noelm"{
   value = length(var.c)
}