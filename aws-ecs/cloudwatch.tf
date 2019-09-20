data "template_file" "event_pattern_stopped" {
  template = file("${path.module}/files/deploy-notification.json")

  vars = {
    cluster_arn = aws_ecs_cluster.ecs_cluster.id
    last_status = "STOPPED"
  }
}

resource "aws_cloudwatch_event_rule" "failed-deploy" {
  name          = "failed-deploy-${var.application}-${var.environment}"
  description   = "Deploy failure notification ${var.application}-${var.environment}"
  event_pattern = data.template_file.event_pattern_stopped.rendered
}

data "template_file" "event_pattern_running" {
  template = file("${path.module}/files/deploy-notification.json")

  vars = {
    cluster_arn = aws_ecs_cluster.ecs_cluster.id
    last_status = "RUNNING"
  }
}

resource "aws_cloudwatch_event_rule" "running-deploy" {
  name          = "running-${var.application}-${var.environment}"
  description   = "Deploy running notification ${var.application}-${var.environment}"
  event_pattern = data.template_file.event_pattern_stopped.rendered
}
