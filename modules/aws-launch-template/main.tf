resource "aws_launch_template" "launch_template" {
  name_prefix            = var.name_prefix
  description            = var.description
  key_name               = var.key_name
  user_data              = var.user_data
  image_id               = var.image_id
  instance_type          = var.instance_type
  kernel_id              = var.kernel_id
  ram_disk_id            = var.ram_disk_id
  security_group_names   = var.security_group_names
  vpc_security_group_ids = var.vpc_security_group_ids
  update_default_version = var.update_default_version

  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name  = lookup(block_device_mappings.value, "device_name", null)
      no_device    = lookup(block_device_mappings.value, "no_device", null)
      virtual_name = lookup(block_device_mappings.value, "virtual_name", null)

      dynamic "ebs" {
        for_each = lookup(block_device_mappings.value, "ebs", [])
        content {
          delete_on_termination = lookup(ebs.value, "delete_on_termination", null)
          encrypted             = lookup(ebs.value, "encrypted", null)
          iops                  = lookup(ebs.value, "iops", null)
          kms_key_id            = lookup(ebs.value, "kms_key_id", null)
          snapshot_id           = lookup(ebs.value, "snapshot_id", null)
          throughput            = lookup(ebs.value, "throughput", null)
          volume_size           = lookup(ebs.value, "volume_size", null)
          volume_type           = lookup(ebs.value, "volume_type", null)
        }
      }

    }
  }

  dynamic "capacity_reservation_specification" {
    for_each = var.capacity_reservation_specification
    content {
      capacity_reservation_preference = lookup(capacity_reservation_specification.value, "capacity_reservation_preference", null)

      dynamic "capacity_reservation_target" {
        for_each = lookup(capacity_reservation_specification.value, "capacity_reservation_target", [])
        content {
          capacity_reservation_id = lookup(capacity_reservation_target.value, "capacity_reservation_id", null)
        }
      }
    }
  }

  dynamic "cpu_options" {
    for_each = var.cpu_options
    content {
      core_count       = lookup(cpu_options.value, "core_count", null)
      threads_per_core = lookup(cpu_options.value, "threads_per_core", null)
    }
  }

  dynamic "credit_specification" {
    for_each = var.credit_specification
    content {
      cpu_credits = lookup(credit_specification.value, "cpu_credits", null)
    }
  }

  dynamic "elastic_gpu_specifications" {
    for_each = var.elastic_gpu_specifications
    content {
      type = lookup(elastic_gpu_specifications.value, "type", null)
    }
  }

  dynamic "elastic_inference_accelerator" {
    for_each = var.elastic_inference_accelerator
    content {
      type = lookup(elastic_inference_accelerator.value, "type", null)
    }
  }

  dynamic "enclave_options" {
    for_each = var.enclave_options
    content {
      enabled = lookup(enclave_options.value, "enabled", null)
    }
  }

  dynamic "hibernation_options" {
    for_each = var.hibernation_options
    content {
      configured = lookup(hibernation_options.value, "configured", null)
    }
  }

  dynamic "iam_instance_profile" {
    for_each = var.iam_instance_profile
    content {
      name = lookup(iam_instance_profile.value, "name", null)
      arn  = lookup(iam_instance_profile.value, "arn", null)
    }
  }

  dynamic "instance_market_options" {
    for_each = var.instance_market_options
    content {
      market_type = lookup(instance_market_options.value, "market_type", null)

      dynamic "spot_options" {
        for_each = var.spot_options
        content {
          block_duration_minutes         = lookup(spot_options.value, "block_duration_minutes", null)
          instance_interruption_behavior = lookup(spot_options.value, "instance_interruption_behavior", null)
          max_price                      = lookup(spot_options.value, "max_price", null)
          spot_instance_type             = lookup(spot_options.value, "spot_instance_type", null)
          valid_until                    = lookup(spot_options.value, "valid_until", null)
        }
      }
    }
  }

  dynamic "license_specification" {
    for_each = var.license_specification
    content {
      license_configuration_arn = lookup(license_specification.value, "license_configuration_arn", null)
    }
  }

  dynamic "metadata_options" {
    for_each = var.metadata_options
    content {
      http_endpoint               = lookup(metadata_options.value, "http_endpoint", null)
      http_put_response_hop_limit = lookup(metadata_options.value, "http_put_response_hop_limit", null)
      http_tokens                 = lookup(metadata_options.value, "http_tokens", null)
      instance_metadata_tags      = lookup(metadata_options.value, "instance_metadata_tags", null)
    }
  }

  dynamic "monitoring" {
    for_each = var.monitoring
    content {
      enabled = lookup(monitoring.value, "enabled", null)
    }
  }

  dynamic "network_interfaces" {
    for_each = var.network_interfaces
    content {
      associate_carrier_ip_address = lookup(network_interfaces.value, "associate_carrier_ip_address", null)
      associate_public_ip_address  = lookup(network_interfaces.value, "associate_public_ip_address", null)
      delete_on_termination        = lookup(network_interfaces.value, "delete_on_termination", null)
      description                  = lookup(network_interfaces.value, "description", null)
      device_index                 = lookup(network_interfaces.value, "device_index", null)
      network_interface_id         = lookup(network_interfaces.value, "network_interface_id", null)
      private_ip_address           = lookup(network_interfaces.value, "private_ip_address", null)
      security_groups              = lookup(network_interfaces.value, "security_groups", null)
      subnet_id                    = lookup(network_interfaces.value, "subnet_id", null)
    }
  }

  dynamic "placement" {
    for_each = var.placement
    content {
      affinity          = lookup(placement.value, "affinity", null)
      availability_zone = lookup(placement.value, "availability_zone", null)
      group_name        = lookup(placement.value, "group_name", null)
      host_id           = lookup(placement.value, "host_id", null)
      tenancy           = lookup(placement.value, "tenancy", null)
      spread_domain     = lookup(placement.value, "spread_domain", null)
      partition_number  = lookup(placement.value, "partition_number", null)
    }
  }

  dynamic "tag_specifications" {
    for_each = var.tag_specifications
    content {
      resource_type = lookup(tag_specifications.value, "resource_type", null)
      tags          = lookup(tag_specifications.value, "tags", null)
    }
  }

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    },
  )
}