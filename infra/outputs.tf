###############################################################
# Outputs for convenient reference
###############################################################

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.nextjs_ec2.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.nextjs_ec2.public_ip
}

output "public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.nextjs_ec2.public_dns
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.nextjs_sg.id
}

output "rds_endpoint" {
  description = "The RDS endpoint"
  value       = aws_db_instance.nextjs_rds.address
}

output "db_secret_arn" {
  description = "Secret ARN storing DB credentials"
  value       = aws_secretsmanager_secret.db_secret.arn
}
