resource "aws_db_instance" "db-instance" {
  name = "dev1-db-instance"
  instance_class = "db.t2.micro"
  allocated_storage = 1
  availability_zone = data.aws_availability_zones.available.names[0]
  db_subnet_group_name = aws_db_subnet_group.db-subnet-group.name
  deletion_protection = false
  engine            = "postgres"
  engine_version    = "10.6"
  username    = "postgres"
  password    = "root"
  port     = "5432"
  storage_type = "standard"
}

resource "aws_db_subnet_group" "db-subnet-group" {
  name = "dev1-db-subnet-group"
  subnet_ids = [module.subnet1.subnet_id, module.subnet2.subnet_id]
  tags = var.tags
}

//resource "aws_rds_cluster_instance" "rds-instance" {
//  identifier = "dev1-rds-instance"
//  cluster_identifier = aws_rds_cluster.rds-cluster.id
//  instance_class = "db.t2.micro"
//  db_subnet_group_name = aws_db_subnet_group.db-subnet-group
//  tags = var.tags
//}
//
//resource "aws_rds_cluster" "rds-cluster" {
//  cluster_identifier = "dev1-rds-cluster"
//  engine            = "postgres"
//  engine_version    = "10.6"
//  vpc_security_group_ids = [aws_vpc.main.id]
//  port     = "5432"
//  availability_zones = data.aws_availability_zones.available.names
//  database_name      = "dev1"
//  master_username    = "postgres"
//  master_password    = "root"
//  backup_retention_period = 1
//  preferred_backup_window = "00:00-01:00"
//  tags = var.tags
//}