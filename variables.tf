variable "location" {
    description = "Location on Azure where resoruces are created"
    default = "eastus"
}

variable "prefix" {
    description = "Every resource will have this prefix"
    default = "abc"
}


variable "vnet_cidr" {
    description = "CIDR block for your VNET ex: ['10.0.0.0/16'] "

}
