# ##############################################
# Security group
# ##############################################

resource "aws_security_group" "ecs_service" {
  vpc_id      = var.vpc_id
  name        = "${var.application}-ecs-service-sg"
  description = "Allow egress from container"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.application}-ecs-service-sg"
    Environment = var.environment
  }
}

# ECS Security Group
resource "aws_security_group" "ecs_tasks" {
  name        = "${var.application}-ecs-tasks-sg"
  description = "Allow inbound traffic over HTTP(S)"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = var.port
    to_port          = var.port
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.application}-ecs-sg"
    Environment = var.environment
  }
}

# ##############################################
# ECS task
# ##############################################


data "template_file" "task_template" {
  template = file("${path.module}/tasks/dummy.json")

  vars = {
    name = var.application

    cpu    = var.cpu
    memory = var.memory

    host_port      = var.port
    container_port = var.port
  }
}

resource "aws_ecs_task_definition" "task" {
  family                   = "${var.application}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  container_definitions = data.template_file.task_template.rendered
  cpu                   = var.cpu
  memory                = var.memory

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_execution_role.arn

  tags = {
    Name        = "${var.application}-task"
    Environment = var.environment
  }
}

data "aws_ecs_task_definition" "task" {
  depends_on = [aws_ecs_task_definition.task]
  task_definition = aws_ecs_task_definition.task.family
}

# ##############################################
# ECS cluster and service
# ##############################################

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.application}-cluster"

  tags = {
    Name        = "${var.application}-cluster"
    Environment = var.environment
  }
}

resource "aws_ecs_service" "ecs_service" {
  name       = "${var.application}-service"
  cluster    = aws_ecs_cluster.ecs_cluster.id
  depends_on = [aws_lb_target_group.lb-target-group]

  task_definition = "${aws_ecs_task_definition.task.family}:${max(
    aws_ecs_task_definition.task.revision,
    data.aws_ecs_task_definition.task.revision,
  )}"
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = concat([
      aws_security_group.ecs_tasks.id,
      aws_security_group.ecs_service.id,
    ], var.security_groups)
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.lb-target-group.arn
    container_name   = var.application
    container_port   = var.container_port
  }

  lifecycle {
    ignore_changes = ["task_definition"]
  }
}

