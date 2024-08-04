variable "name"{
    type = string
    description = "This name of RG"
}

variable "location"{
    type = string
    description = "This name of Region"
}

variable "env" {
  type = string
  description = "This name of ENV"
}
variable "vnet-name" {
  description = "Value of the Name tag for the RG"
  type        = string
}

#variable "VM_name" {
#  description = "Value of the Name tag for the VM"
#  type        = string
#}

variable "address_space" {
  description = "Value of vent CIDR"
  type        = string
}

#subnet 
variable subnet_name  {
    type        = list(string)
    default     = ["appgetwaysubnet", "solrsubnet","gatewaysubnet","appsubnet","reportsvcsubnet","mediasvcsubnet","storgaesubnet","dbsubnet"]
}

variable subnet_prefix  {
    type        = list(string)
    default     = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/29","10.0.4.0/24","10.0.5.0/24","10.0.6.0/24","10.0.7.0/24","10.0.8.0/24"]
    
}

variable "nameVMs" {}

variable "public_key"{}


variable "nicname"{
    type        = list(string)
}

variable "pubip"{
    type        = list(string)
}