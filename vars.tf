variable "vpc" {
  type        = string
  default     = "vpc-a2bd41c4"
}

variable "region" {
  type    = string
  default = "us-west-1"
}

variable "domain_name" {
  type        = string
  default     = "elk-sl-mon"
  description = "name of Elasticsearch Domain"
}

variable "elasticsearch_version" {
  type        = string
  default     = "7.10"
  description = "Version of Elasticsearch to deploy"
}

variable "instance_type" {
  type        = string
  default     = "r5.4xlarge.elasticsearch"
  description = "Elasticsearch instance type for data nodes in the cluster"
}

variable "instance_count" {
  type        = number
  description = "Number of data nodes in the cluster"
  default     = 3
}

variable "dedicated_master_enabled" {
  type        = bool
  default     = true
  description = "Indicates whether dedicated master nodes are enabled for the cluster"
}

variable "dedicated_master_count" {
  type        = number
  description = "Number of dedicated master nodes in the cluster"
  default     = 3
}

variable "dedicated_master_type" {
  type        = string
  default     = "r5.2xlarge.elasticsearch"
  description = "Elasticsearch dedicated master type for data nodes in the cluster"
}

variable "warm_enabled" {
  type        = bool
  default     = true
  description = "Indicates warm indices are enabled for the cluster"
}

variable "warm_count" {
  type        = number
  description = "Number of warm indices nodes in the cluster"
  default     = 2
}

variable "warm_type" {
  type        = string
  default     = "ultrawarm1.large.elasticsearch"
  description = "Elasticsearch warm indices node type for data nodes in the cluster"
}

variable "zone_awareness_enabled" {
  type        = bool
  default     = true
  description = "Enable zone awareness for Elasticsearch cluster"
}

variable "availability_zone_count" {
  type        = number
  default     = 3
  description = "Number of Availability Zones for the domain to use."
}

variable "tag_domain" {
  type    = string
  default = "elk-sl-mon"
}

variable "ebs_volume_size" {
  type        = number
  description = "EBS volumes for data storage in GB"
  default     = 40
}

variable "ebs_volume_type" {
  type        = string
  default     = "gp2"
  description = "Storage type of EBS volumes"
}

variable "enable" {
  type    = bool
  default = true
}

variable "enabled" {
  type    = bool
  default = true
}

variable "internal_user_database_enabled" {
  type    = bool
  default = true
}

variable "master_user_name" {
  type    = string
  default = "slmon"
}

variable "master_user_password" {
  type  = string
default = "Slmon@123"
}

variable "aws_caller_identity" {
  type  = string
default = "694702677705"
}

