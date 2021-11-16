variable "name" {
  type  = string
  default = "lee"
}

variable "avazone" {
  type  = list
  default = ["a","c"]
}

variable "region" {
  type  = string
  default = "ap-northeast-2"
}

variable "key" {
  type  = string
  default = "lee-key"
}

variable "cidr" {
  type  = string
  default = "0.0.0.0/0"
}
variable "cidr_v6" {
  type  = string
  default = "::/0"
}

variable "cidr_main" {
  type  = string
  default = "10.0.0.0/16"
}

variable "public_s" {
  type  = list
  default = ["10.0.0.0/24", "10.0.2.0/24"]
}

variable "private_s" {
  type  = list
  default = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "private_dbs" {
  type  = list
  default = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "private_ip" {
  type  = string
  default = "10.0.0.11"
}

variable "intance" {
  type  = string
  default = "t2.micro"
}

variable "protocol_tcp" {
  type  = string
  default = "tcp"
}

variable "protocol_udp" {
  type  = string
  default = "udp"
}

variable "protocol_http" {
  type  = string
  default = "http"
}

variable "protocol_http1" {
  type  = string
  default = "HTTP"
}

variable "protocol_icmp" {
  type  = string
  default = "icmp"
}

variable "protocol_ssh" {
  type  = string
  default = "ssh"
}

variable "port_ssh" {
  type  = number
  default = 22
}

variable "port_http" {
  type  = number
  default = 80
}

variable "port_mysql" {
  type  = number
  default = 3306
}

variable "port_zero" {
  type = number
  default = 0
}

variable "port_minus" {
  type = number
  default = -1
}

variable "protocol_minus" {
  type  = number
  default = -1
}

variable "db_name" {
  type  = string
  default = "mysql"
}

variable "load_type" {
  type  = string
  default = "application"
}

variable "strategy" {
  type  = string
  default = "cluster"
}

variable "storage_size" {
  type = number
  default = 20
}

variable "storage_type" {
  type = string
  default = "gp2"
}

variable "mysql_version" {
  type = string
  default = "8.0"
}

variable "sql_engine" {
  type = string
  default = "mysql"
}

variable "username" {
  type = string
  default = "admin"
}

variable "password" {
  type = string
  default = "!Giovanni96123"
}

variable "name_db" {
  type  = string
  default = "mydb"
}

variable "instance_db" {
  type  = string
  default = "db.t2.micro"
}

variable "endpoint" {
  type  = string
  default = "data.aws_db_instance.mydb.endpoint"
}