data "aws_iam_policy_document" "this" {
  dynamic "statement" {
    for_each = var.statement_principals
    content {
      sid     = lookup(statement.value, "sid", null)
      actions = lookup(statement.value, "actions", null)
      effect  = lookup(statement.value, "effect", "Allow")

      principals {
        type        = lookup(statement.value.principals, "type", null)
        identifiers = lookup(statement.value.principals, "identifiers", null)
      }
      dynamic "condition" {
        for_each = lookup(statement.value, "condition", {})
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
  dynamic "statement" {
    for_each = var.statement
    content {
      sid     = lookup(statement.value, "sid", null)
      actions = lookup(statement.value, "actions", null)
      effect  = lookup(statement.value, "effect", "Allow")
      resources  = lookup(statement.value, "resources", [])
      dynamic "condition" {
        for_each = lookup(statement.value, "condition", {})
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}
