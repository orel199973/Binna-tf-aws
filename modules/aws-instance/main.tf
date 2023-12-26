resource "aws_instance" "ec2_instance" {
  ami = var.ami
  instance_type = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address 
  availability_zone = var.availability_zone
  disable_api_stop = var.disable_api_stop 
  disable_api_termination = var.disable_api_termination
  ebs_optimized = var.ebs_optimized
  get_password_data = var.get_password_data
  hibernation = var.hibernation 
  host_id = var.host_id
  host_resource_group_arn  = var.host_resource_group_arn 
  iam_instance_profile = var.iam_instance_profile 
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  ipv6_address_count = var.ipv6_address_count
  ipv6_addresses = var.ipv6_addresses
  key_name = var.key_name
  monitoring = var.monitoring
  placement_group = var.placement_group
  placement_partition_number = var.placement_partition_number 
  private_ip  = var.private_ip 
  secondary_private_ips  = var.secondary_private_ips 
  security_groups = var.security_groups
  source_dest_check = var.source_dest_check
  subnet_id = var.subnet_id
  tenancy  = var.tenancy 
  user_data = var.user_data
  user_data_base64 = var.user_data_base64
  user_data_replace_on_change =var.user_data_replace_on_change
  volume_tags = var.volume_tags
  vpc_security_group_ids =var.vpc_security_group_ids

  dynamic "instance_market_options" {
    for_each = var.instance_market_options
    content {
      dynamic "spot_options" {
        for_each = var.spot_options
        content {
          max_price = lookup(spot_options.value, "max_price", null)
          
        }
      }  
    }
  }


  dynamic "network_interface" {
    for_each = var.network_interface
    content {
      delete_on_termination = lookup(network_interface.value, "delete_on_termination", null)
      device_index = lookup(network_interface.value, "device_index", null)
      network_card_index = lookup(network_interface.value, "network_card_index", null)
      network_interface_id = lookup(network_interface.value, "network_interface_id", null)

    }
  }

  dynamic "private_dns_name_options" {
    for_each = var.private_dns_name_options
    content {
      enable_resource_name_dns_aaaa_record = lookup(private_dns_name_options.value, "enable_resource_name_dns_aaaa_record", null)
      enable_resource_name_dns_a_record = lookup(private_dns_name_options.value, "enable_resource_name_dns_a_record", null)
      hostname_type  = lookup(private_dns_name_options.value, "hostname_type ", null)
    }
  }

  dynamic "capacity_reservation_specification" {
    for_each = var.capacity_reservation_specification
    content {
      capacity_reservation_preference = lookup(capacity_reservation_specification.value, "capacity_reservation_preference", null)
      dynamic "capacity_reservation_target" {
        for_each = var.capacity_reservation_target
        content {
          capacity_reservation_id  = lookup(capacity_reservation_target.value, "capacity_reservation_id ", null)
          capacity_reservation_resource_group_arn  = lookup(capacity_reservation_target.value, "capacity_reservation_resource_group_arn ", null)
        }
      } 
    }
  }

  # dynamic "spot_options" {
  #   for_each = var.spot_options 
  #   content {
  #     instance_interruption_behavior = lookup(spot_options.value, "instance_interruption_behavior", null)
  #     max_price = lookup(spot_options.value, "max_price", null)
  #     spot_instance_type  = lookup(spot_options.value, "spot_instance_type", null)
  #     valid_until = lookup(spot_options.value, "valid_until", null)
  #   }
  # }

  dynamic "cpu_options" {
    for_each = var.private_dns_name_options
    content {
      amd_sev_snp = lookup(cpu_options.value, "amd_sev_snp", null)
      core_count = lookup(cpu_options.value, "core_count", null)
      threads_per_core  = lookup(cpu_options.value, "threads_per_core", null)
    }
  }

  dynamic "credit_specification" {
    for_each = var.credit_specification
    content {
      cpu_credits = lookup(credit_specification.value, "cpu_credits", null)
    }
  }

  dynamic "root_block_device" {
    for_each = var.credit_specification
    content {
      delete_on_termination  = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted = lookup(root_block_device.value, "encrypted", null)
      iops = lookup(root_block_device.value, "iops", null)
      kms_key_id  = lookup(root_block_device.value, "kms_key_id", null)
      tags = lookup(root_block_device.value, "tags", null)
      throughput = lookup(root_block_device.value, "throughput", null)
      volume_size  = lookup(root_block_device.value, "volume_size ", null)
      volume_type  = lookup(root_block_device.value, "volume_type ", null)
    }
  }


 dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination  = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name = lookup(ebs_block_device.value, "device_name", null)
      encrypted = lookup(ebs_block_device.value, "encrypted", null)
      snapshot_id  = lookup(ebs_block_device.value, "snapshot_id", null)
      tags = lookup(ebs_block_device.value, "tags", null)
      throughput = lookup(ebs_block_device.value, "throughput", null)
      volume_size  = lookup(ebs_block_device.value, "volume_size ", null)
      volume_type  = lookup(ebs_block_device.value, "volume_type ", null)
    }
  }


  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral_block_device
    content {
      device_name      = lookup(ephemeral_block_device.value, "device_name", null)
      no_device    = lookup(ephemeral_block_device.value, "no_device", null)
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name", null)
    }
  } 

  dynamic "enclave_options" {
    for_each = var.enclave_options
    content {
      enabled      = lookup(enclave_options.value, "enabled", null)
    }
  } 

  dynamic "maintenance_options" {
    for_each = var.maintenance_options
    content {
      auto_recovery      = lookup(maintenance_options.value, "auto_recovery", null)
    }
  } 

  # dynamic "instance_market_options" {
  #   for_each = var.instance_market_options
  #   content {
  #     instance_lifecycle      = lookup(instance_market_options.value, "instance_lifecycle", null)
  #     spot_instance_request_id    = lookup(instance_market_options.value, "spot_instance_request_id", null)
  #   }
  # } 

 dynamic "metadata_options" {
    for_each = var.metadata_options
    content {
      http_endpoint  = lookup(metadata_options.value, "http_endpoint", null)
      http_protocol_ipv6 = lookup(metadata_options.value, "http_protocol_ipv6", null)
      http_put_response_hop_limit = lookup(metadata_options.value, "http_put_response_hop_limit", null)
      http_tokens = lookup(metadata_options.value, "http_tokens", null)
      instance_metadata_tags = lookup(metadata_options.value, "instance_metadata_tags", null)
    }
 }

 dynamic "network_interface" {
    for_each = var.network_interface
    content {
      delete_on_termination  = lookup(network_interface.value, "delete_on_termination", null)
      device_index = lookup(network_interface.value, "device_index", null)
      network_card_index  = lookup(network_interface.value, "network_card_index ", null)
      network_interface_id = lookup(network_interface.value, "network_interface_id", null)
  }
 }

  dynamic "launch_template" {
    for_each = var.launch_template
    content {
      id      = lookup(launch_template.value, "id",  null)
      name    = lookup(launch_template.value, "name",  null)
      version = lookup(launch_template.value, "idversion",  null)
    }
  } 

 dynamic "cpu_options" {
    for_each = var.cpu_options
    content {
      core_count       = lookup(cpu_options.value, "core_count",  null)
      threads_per_core = lookup(cpu_options.value, "threads_per_core",  null)
    }
  }

  tags = merge(
    { "Name" = "${var.name}" },
    var.tags,
  )

}
