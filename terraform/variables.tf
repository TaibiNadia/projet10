variable "name" {
  default = "test"
}

variable "environment" {
  default = "test"
}
variable "azs" {
  description = "AZ for subnets"
  default     = "eu-west-3a,eu-west-3b"
}

variable "aws_access_key" {
  default = "XXXXXXXXXXXXXXXXXXXXX"
}

variable "aws_secret_key" {
  default = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

variable "aws_key_path" {
  default = "/home/vagrant/"
}

variable "aws_key_name" {
  default = "key_pair"
}

variable "aws_region" {
  description = "EC2 Region for the VPC"
  default     = "eu-west-3"
}

variable "amis" {
  description = "AMIs by region"
  default = {
    eu-west-3 = "ami-00373688fb7818d45"
  }
}
variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default     = "10.0.0.0/16"
}
variable "public_subnets_cidr" {
  description = "CIDR for the Public Subnets"
  default     = "10.0.10.0/24,10.0.11.0/24"
}
variable "private_subnet_a_cidr" {
  description = "CIDR for the Private Subnet A"
  default     = "10.0.1.0/24"
}
variable "private_subnet_b_cidr" {
  description = "CIDR for Private Subnet B"
  default     = "10.0.2.0/24"
}

variable "private_subnets_cidr" {
  description = "CIDR for private subnets"
  default     = "10.0.1.0/24,10.0.2.0/24"
}


data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

variable "domain_name" {
  type        = string
  default     = "es-domain"
  description = "name of Elasticsearch Domain"
}
variable "elasticsearch_version" {
  type        = string
  default     = "7.10"
  description = "Version of Elasticsearch to deploy"
}
variable "instance_type" {
  type        = string
  default     = "t3.medium.elasticsearch"
  description = "Elasticsearch instance type for data nodes in the cluster"
}

variable "instance_count" {
  type        = number
  description = "Number of data nodes in the cluster"
  default     = 2
}

variable "zone_awareness_enabled" {
  type        = bool
  default     = true
  description = "Enable zone awareness for Elasticsearch cluster"
}
variable "availability_zone_count" {
  type        = number
  default     = 2
  description = "Number of Availability Zones for the domain to use."
}
variable "ebs_volume_size" {
  type        = number
  description = "EBS volumes for data storage in GB"
  default     = 10
}
variable "automated_snapshot_start_hour" {
  type        = number
  description = "Hour at which automated snapshots are taken, in UTC"
  default     = 23     
}
variable "log_publishing_index_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether log publishing option for INDEX_SLOW_LOGS is enabled or not"
}

variable "log_publishing_search_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether log publishing option for SEARCH_SLOW_LOGS is enabled or not"
}

variable "log_publishing_application_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether log publishing option for ES_APPLICATION_LOGS is enabled or not"
}
variable "log_publishing_index_cloudwatch_log_group_arn" {
  type        = string
  default     = ""
  description = "ARN of the CloudWatch log group to which log for INDEX_SLOW_LOGS needs to be published"
}

variable "log_publishing_search_cloudwatch_log_group_arn" {
  type        = string
  default     = ""
  description = "ARN of the CloudWatch log group to which log for SEARCH_SLOW_LOGS needs to be published"
}

variable "log_publishing_application_cloudwatch_log_group_arn" {
  type        = string
  default     = ""
  description = "ARN of the CloudWatch log group to which log for ES_APPLICATION_LOGS needs to be published"
}

variable "db_user_name" {
   type        = string
   default     = "elastic"
   description = "Internal Database User Name"
}

variable "db_user_password" {
   type       = string
   default    = "Winner@3841"
   description = "Internal Database User Password"
}
