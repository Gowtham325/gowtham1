variable "v_azs"{
    type = list
	default = ["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"]
}
variable "v_vpc_cidr"{
    type = string 
	default = "10.0.0.0/16"
}
variable "v_pub_sn_cidrs"{
    default = ["10.0.0.0/24","10.0.1.0/24","10.0.2.0/24"]
}
variable "v_prv_sn_cidrs"{
    default = ["10.0.3.0/24","10.0.4.0/24","10.0.5.0/24"]
}
variable "v_tg"{
    default = ["PrepaidTg","PostpaidTg"]
}
variable "v_tg_port"{
    default={
	   PrepaidTg=80
	   PostpaidTg=90
	}
}