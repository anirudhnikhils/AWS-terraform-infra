resource "aws_db_subnet_group" "this" {
  name       = "${var.env_name}-db-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "${var.env_name}-db-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier             = "${var.env_name}-db"
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids
  multi_az               = var.multi_az
  skip_final_snapshot    = true

  tags = {
    Name = "${var.env_name}-db"
  }
}
