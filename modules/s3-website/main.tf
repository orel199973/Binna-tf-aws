resource "aws_s3_bucket_website_configuration" "s3_website" {
  bucket                = var.bucket
  routing_rules         = var.routing_rule
  expected_bucket_owner = var.expected_bucket_owner

  dynamic "index_document" {
    for_each = var.index_document
    content {
      suffix = lookup(index_document.value, "suffix", "index.html")
    }
  }

  dynamic "error_document" {
    for_each = var.error_document
    content {
      key = lookup(error_document.value, "key", "error.html")
    }
  }

  # dynamic "redirect_all_requests_to"{
  #   for_each = var.redirect_all_requests_to 
  #   content {
  #     host_name = lookup(redirect_all_requests_to.value, "host_name", null)
  #     protocol = lookup(redirect_all_requests_to.value, "protocol", null)
  #   }
  # }

}





