resource "aws_autoscaling_group" "autoscaling_group" {
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = var.vpc_zone_identifier
  force_delete              = var.force_delete
  health_check_type         = var.health_check_type
  health_check_grace_period = var.health_check_grace_period
  availability_zones        = var.availability_zones
  launch_configuration      = var.launch_configuration
  target_group_arns         = var.target_group_arns
  service_linked_role_arn   = var.service_linked_role_arn
  termination_policies      = var.termination_policies
  enabled_metrics           = var.enabled_metrics
  load_balancers            = var.load_balancers
  suspended_processes       = var.suspended_processes
  placement_group           = var.placement_group
  min_elb_capacity          = var.min_elb_capacity
  max_instance_lifetime     = var.max_instance_lifetime
  dynamic "launch_template" {
    for_each = var.launch_template
    content {
      id = lookup(launch_template.value, "id", null)
      version = lookup(launch_template.value, "version", null)
    }
  }
  dynamic "mixed_instances_policy" {
    for_each = var.mixed_instances_policy
    content {
      dynamic "launch_template" {
        for_each = var.launch_template
        content {
          dynamic "launch_template_specification" {
            for_each = var.launch_template_specification
            content {
              launch_template_id   = lookup(launch_template_specification.value, "launch_template_id", null)
              launch_template_name = lookup(launch_template_specification.value, "launch_template_name", null)
              version              = lookup(launch_template_specification.value, "version", null)
            }
          }

          dynamic "override" {
            for_each = var.override
            content {
              instance_type     = lookup(override.value, "instance_type", null)
              weighted_capacity = lookup(override.value, "weighted_capacity", null)
            }
          }
        }
      }

      dynamic "instances_distribution" {
        for_each = var.instances_distribution
        content {
          on_demand_allocation_strategy            = lookup(mixed_instances_policy.value, "on_demand_allocation_strategy", null)
          on_demand_base_capacity                  = lookup(mixed_instances_policy.value, "on_demand_base_capacity", null)
          on_demand_percentage_above_base_capacity = lookup(mixed_instances_policy.value, "on_demand_percentage_above_base_capacity", null)
          spot_allocation_strategy                 = lookup(mixed_instances_policy.value, "spot_allocation_strategy", null)
          spot_instance_pools                      = lookup(mixed_instances_policy.value, "spot_instance_pools", null)
          spot_max_price                           = lookup(mixed_instances_policy.value, "spot_max_price", null)
        }
      }
    }
  }

  dynamic "tag" {
    for_each = var.tag
    content {
      key                 = lookup(tag.value, "key", null)
      value               = lookup(tag.value, "value", null)
      propagate_at_launch = lookup(tag.value, "propagate_at_launch", null)
    }
  }

  dynamic "instance_refresh" {
    for_each = var.instance_refresh
    content {
      strategy = lookup(instance_refresh.value, "strategy", null)
      triggers = lookup(instance_refresh.value, "triggers", null)

      dynamic "preferences" {
        for_each = var.preferences
        content {
          min_healthy_percentage = lookup(preferences.value, "min_healthy_percentage", null)

        }
      }
    }
  }

  # lifecycle {
  #   create_before_destroy = true
  # }
}