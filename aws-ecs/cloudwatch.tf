data "template_file" "event_pattern" {
  template = file("${path.module}/files/deploy-notification.json")

  vars = {
    cluster_arn = aws_ecs_cluster.ecs_cluster.id
  }
}

resource "aws_cloudwatch_event_rule" "failed-deploy" {
  name          = "failed-deploy-${var.application}-${var.environment}"
  description   = "Deploy failure notificatioon ${var.application}-${var.environment}"
  event_pattern = data.template_file.event_pattern.rendered
}
