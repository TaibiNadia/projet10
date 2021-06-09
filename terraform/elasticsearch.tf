resource "aws_iam_service_linked_role" "es" {
  aws_service_name = "es.amazonaws.com"
}
output "iam_service_linked_role" {
  value       = aws_iam_service_linked_role.es.id
  description = "IAM ARN"
}
resource "aws_elasticsearch_domain" "es" {
  domain_name           = var.domain_name
  elasticsearch_version = var.elasticsearch_version

  cluster_config {
    instance_count           = var.instance_count
    instance_type            = var.instance_type
    zone_awareness_enabled   = var.zone_awareness_enabled

    zone_awareness_config {
      availability_zone_count = var.availability_zone_count
    }
  }

  ebs_options {
    ebs_enabled = true
    volume_size = var.ebs_volume_size
  }

  snapshot_options {
    automated_snapshot_start_hour = var.automated_snapshot_start_hour
  }

  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = var.db_user_name
      master_user_password = var.db_user_password
    }
  }
  node_to_node_encryption {
    enabled      = true
  }
  encrypt_at_rest {
    enabled      = true
  }
  domain_endpoint_options {
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-0-2019-07"
  }

//  log_publishing_options {
//    enabled                  = var.log_publishing_index_enabled
//    log_type                 = "INDEX_SLOW_LOGS"
//    cloudwatch_log_group_arn = var.log_publishing_index_cloudwatch_log_group_arn
//  }

//  log_publishing_options {
//    enabled                  = var.log_publishing_search_enabled
//    log_type                 = "SEARCH_SLOW_LOGS"
//    cloudwatch_log_group_arn = var.log_publishing_search_cloudwatch_log_group_arn
//  }

//  log_publishing_options {
//    enabled                  = var.log_publishing_application_enabled
//    log_type                 = "ES_APPLICATION_LOGS"
//    cloudwatch_log_group_arn = var.log_publishing_application_cloudwatch_log_group_arn
//  }

  tags = {
    Domain = "ESDomain"
  }

//  depends_on = [aws_iam_service_linked_role.es]
}

  output "elk_endpoint" {
    value = aws_elasticsearch_domain.es.endpoint
  }

  output "elk_kibana_endpoint" {
    value = aws_elasticsearch_domain.es.kibana_endpoint
  }

  resource "aws_elasticsearch_domain_policy" "esap" {
    domain_name = aws_elasticsearch_domain.es.domain_name

    access_policies = <<CONFIG
    {
       "Version": "2012-10-17",
       "Statement": [
          {
            "Action": 
                "es:*",
            "Principal": {
              "AWS": "*"
             },
            "Effect": "Allow",
            "Resource": "arn:aws:es:${var.aws_region}:${data.aws_caller_identity.current.account_id}:domain/${var.domain_name}/*"
          }
          ]
    }
    CONFIG
  }
