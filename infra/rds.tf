###############################################################
# RDS PostgreSQL + Secrets Manager Configuration
###############################################################

# Create a separate security group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow PostgreSQL inbound from EC2"

  ingress {
    description = "PostgreSQL access from EC2"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.nextjs_sg.id] # allow EC2 SG to access
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-rds-sg"
  }
}

# Create PostgreSQL RDS Instance
resource "aws_db_instance" "nextjs_rds" {
  identifier              = "${var.project_name}-rds"
  engine                  = "postgres"
  engine_version          = "15"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  db_name                 = "nextjsdb"
  username                = "dbadmin"
  password                = random_password.db_password.result
  skip_final_snapshot     = true
  publicly_accessible     = false
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  deletion_protection     = false

  tags = {
    Name = "${var.project_name}-rds"
  }
}

# Generate random password for the DB
resource "random_password" "db_password" {
  length  = 16
  special = true
}

# Store database credentials in Secrets Manager
resource "aws_secretsmanager_secret" "db_secret" {
  name        = "${var.project_name}-db-secret"
  description = "PostgreSQL credentials for Next.js app"
}

resource "aws_secretsmanager_secret_version" "db_secret_value" {
  secret_id     = aws_secretsmanager_secret.db_secret.id
  secret_string = jsonencode({
    username = aws_db_instance.nextjs_rds.username
    password = random_password.db_password.result
    host     = aws_db_instance.nextjs_rds.address
    port     = aws_db_instance.nextjs_rds.port
    dbname   = aws_db_instance.nextjs_rds.db_name
  })
}
