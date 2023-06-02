resource "aws_launch_template" "this" {
  name = "${var.name}-launch-template"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = var.root_disk_size
    }
  }

  ebs_optimized = true

  instance_type = var.node_instance_type

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      {
        Name = "${var.name}-node-group-instance"
      },
      var.tags,
    )
  }

}