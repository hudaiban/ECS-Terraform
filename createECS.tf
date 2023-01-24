


#  choose your service provider in this case is Alibaba
provider "alicloud" {
  # Access and secret key is a must, it can be found within your account (check README on how to find it)  
  access_key = "USE YOUR OWN"
  secret_key = "USE YOUR OWN"

  #   Choose a region (this is for sydney)
  region = "ap-southeast-2"
}

# Creating instance Type 

data "alicloud_instance_types" "instanceType" {
  # Choosing a cpu and memory count in which is desired 
  cpu_core_count = 8
  memory_size    = 16
}



# Create an Image 

data "alicloud_images" "ubuntu" {
  most_recent = true
  name_regex  = "^ubuntu_18.*64"
  owners      = "system"
}

# Creating an ECS

resource "alicloud_instance" "ubuntu-Terrafrom" {
  # resoucrs  "calling alicloud instance" | any name you can choose (ops)

  # image ID
  image_id = "ubuntu_18_04_64_20G_alibase_20190624.vhd"
  # Charging type (pay as you go)
  internet_charge_type = "PayByBandwidth"
  instance_type        = data.alicloud_instance_types.instanceType.instance_types.0.id
  #(line above is calling all the lines within bracket in line 29 to 33 above)
  vswitch_id      = "vsw-p0wj291l5dqk4hrrav75y"
  security_groups = ["${alicloud_security_group.secGroup.id}"]




}

# Security Group in which is must to have when creating an ECS


resource "alicloud_security_group" "secGroup" {
  name        = "default"
  description = "default"
  vpc_id      = "vpc-p0w9vposytkswvwgiucy0"
}


