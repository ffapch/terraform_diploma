resource "aws_db_instance" "db-instance" {
  name                   = "dev1db"
  instance_class         = "db.t2.micro"
  allocated_storage      = 20
  availability_zone      = data.aws_availability_zones.available.names[0]
  db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
  vpc_security_group_ids = [aws_security_group.main.id]
  deletion_protection    = false
  engine                 = "postgres"
  engine_version         = "10.6"
  username               = "postgres"
  password               = "rootroot"
  port                   = "5432"
  storage_type           = "standard"
  publicly_accessible    = true
}

resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "dev1-db-subnet-group"
  subnet_ids = [module.subnet1.subnet_id, module.subnet2.subnet_id]
  tags       = var.tags
}