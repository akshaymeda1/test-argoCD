resource "aws_security_group" "es" {
  name        = "test-sl-mon-elasticsearch"
  description = "Managed by Terraform"
  vpc_id      = var.vpc

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0" ]
  }
}

resource "aws_elasticsearch_domain" "es" {
  domain_name           = var.domain_name
  elasticsearch_version = var.elasticsearch_version

  cluster_config {
    instance_type            = var.instance_type
    instance_count           = var.instance_count
    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_count   = var.dedicated_master_count
    dedicated_master_type    = var.dedicated_master_type
    warm_enabled	     = var.warm_enabled
    warm_count               = var.warm_count
    warm_type		     = var.warm_type 
    zone_awareness_enabled   = var.zone_awareness_enabled

    zone_awareness_config {
      availability_zone_count  =var.availability_zone_count
    }
  }
  vpc_options {
    subnet_ids         = ["subnet-5a6fc301", "subnet-3669507e", "subnet-0dac8501726d2548d", "subnet-6994ad20" ]
    security_group_ids = [aws_security_group.es.id]
  }
  node_to_node_encryption {
    enabled      = var.enabled
  }
  encrypt_at_rest {
    enabled      = var.enabled
  }
  advanced_security_options {
    enabled                        = var.enable
    internal_user_database_enabled = var.internal_user_database_enabled
    master_user_options {
      master_user_name        = var.master_user_name
      master_user_password    = var.master_user_password
    }
  }
  domain_endpoint_options {
    enforce_https       = var.enabled
    tls_security_policy = "Policy-Min-TLS-1-0-2019-07"
  }
  snapshot_options {
    automated_snapshot_start_hour = 23
  }
  ebs_options {
    ebs_enabled = var.ebs_volume_size > 0 ? true : false
    volume_size = var.ebs_volume_size
    volume_type = var.ebs_volume_type
  }
  tags = {
    Domain = var.tag_domain
  }

access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
              "AWS": "*"
            },
            "Action": "es:*",
            "Resource": "arn:aws:es:${var.region}:${var.aws_caller_identity}:domain/${var.domain_name}/*"
        }
    ]
}
CONFIG

}

resource "null_resource" "cold-storage" {
  provisioner "local-exec" {
    command = "aws es update-elasticsearch-domain-config --domain-name ${var.domain_name} --region ${var.region} --elasticsearch-cluster-config ColdStorageOptions={Enabled=true}"
  }
}
