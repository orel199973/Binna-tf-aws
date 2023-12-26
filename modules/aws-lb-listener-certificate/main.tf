resource "aws_lb_listener_certificate" "this" {
  listener_arn    = var.listener_arn
  certificate_arn = var.certificate_arn
}