# Datadog ECS module

# ECS service
resource "aws_ecs_service" "datadog-service" {
  name                = "datadog-service"
  cluster             = "${var.ecs_cluster_id}"
  task_definition     = "${aws_ecs_task_definition.datadog-task.arn}"
  scheduling_strategy = "DAEMON"
  launch_type         = "FARGATE"
}

# ECS task definition
resource "aws_ecs_task_definition" "datadog-task" {
  family                   = "datadog-task"
  container_definitions    = "${data.template_file.datadog-task-template.rendered}"
  task_role_arn            = "${var.ecs_task_role}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
}

# ECS task template
data "template_file" "datadog-task-template" {
  template = "${file("${path.module}/datadog.json")}"

  vars {
    dd_api_key = "${var.dd_api_key}"
  }
}