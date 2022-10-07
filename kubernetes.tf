locals {
  bastion_autoscaling_group_ids     = [aws_autoscaling_group.bastions-fr-amaury13-prod-k8s-local.id]
  bastion_security_group_ids        = [aws_security_group.bastion-fr-amaury13-prod-k8s-local.id]
  bastions_role_arn                 = aws_iam_role.bastions-fr-amaury13-prod-k8s-local.arn
  bastions_role_name                = aws_iam_role.bastions-fr-amaury13-prod-k8s-local.name
  cluster_name                      = "fr.amaury13.prod.k8s.local"
  master_autoscaling_group_ids      = [aws_autoscaling_group.master-eu-west-3a-masters-fr-amaury13-prod-k8s-local.id]
  master_security_group_ids         = [aws_security_group.masters-fr-amaury13-prod-k8s-local.id]
  masters_role_arn                  = aws_iam_role.masters-fr-amaury13-prod-k8s-local.arn
  masters_role_name                 = aws_iam_role.masters-fr-amaury13-prod-k8s-local.name
  node_autoscaling_group_ids        = [aws_autoscaling_group.nodes-eu-west-3a-fr-amaury13-prod-k8s-local.id]
  node_security_group_ids           = [aws_security_group.nodes-fr-amaury13-prod-k8s-local.id]
  node_subnet_ids                   = [aws_subnet.eu-west-3a-fr-amaury13-prod-k8s-local.id]
  nodes_role_arn                    = aws_iam_role.nodes-fr-amaury13-prod-k8s-local.arn
  nodes_role_name                   = aws_iam_role.nodes-fr-amaury13-prod-k8s-local.name
  region                            = "eu-west-3"
  route_table_private-eu-west-3a_id = aws_route_table.private-eu-west-3a-fr-amaury13-prod-k8s-local.id
  route_table_public_id             = aws_route_table.fr-amaury13-prod-k8s-local.id
  subnet_eu-west-3a_id              = aws_subnet.eu-west-3a-fr-amaury13-prod-k8s-local.id
  subnet_utility-eu-west-3a_id      = aws_subnet.utility-eu-west-3a-fr-amaury13-prod-k8s-local.id
  vpc_cidr_block                    = aws_vpc.fr-amaury13-prod-k8s-local.cidr_block
  vpc_id                            = aws_vpc.fr-amaury13-prod-k8s-local.id
}

output "bastion_autoscaling_group_ids" {
  value = [aws_autoscaling_group.bastions-fr-amaury13-prod-k8s-local.id]
}

output "bastion_security_group_ids" {
  value = [aws_security_group.bastion-fr-amaury13-prod-k8s-local.id]
}

output "bastions_role_arn" {
  value = aws_iam_role.bastions-fr-amaury13-prod-k8s-local.arn
}

output "bastions_role_name" {
  value = aws_iam_role.bastions-fr-amaury13-prod-k8s-local.name
}

output "cluster_name" {
  value = "fr.amaury13.prod.k8s.local"
}

output "master_autoscaling_group_ids" {
  value = [aws_autoscaling_group.master-eu-west-3a-masters-fr-amaury13-prod-k8s-local.id]
}

output "master_security_group_ids" {
  value = [aws_security_group.masters-fr-amaury13-prod-k8s-local.id]
}

output "masters_role_arn" {
  value = aws_iam_role.masters-fr-amaury13-prod-k8s-local.arn
}

output "masters_role_name" {
  value = aws_iam_role.masters-fr-amaury13-prod-k8s-local.name
}

output "node_autoscaling_group_ids" {
  value = [aws_autoscaling_group.nodes-eu-west-3a-fr-amaury13-prod-k8s-local.id]
}

output "node_security_group_ids" {
  value = [aws_security_group.nodes-fr-amaury13-prod-k8s-local.id]
}

output "node_subnet_ids" {
  value = [aws_subnet.eu-west-3a-fr-amaury13-prod-k8s-local.id]
}

output "nodes_role_arn" {
  value = aws_iam_role.nodes-fr-amaury13-prod-k8s-local.arn
}

output "nodes_role_name" {
  value = aws_iam_role.nodes-fr-amaury13-prod-k8s-local.name
}

output "region" {
  value = "eu-west-3"
}

output "route_table_private-eu-west-3a_id" {
  value = aws_route_table.private-eu-west-3a-fr-amaury13-prod-k8s-local.id
}

output "route_table_public_id" {
  value = aws_route_table.fr-amaury13-prod-k8s-local.id
}

output "subnet_eu-west-3a_id" {
  value = aws_subnet.eu-west-3a-fr-amaury13-prod-k8s-local.id
}

output "subnet_utility-eu-west-3a_id" {
  value = aws_subnet.utility-eu-west-3a-fr-amaury13-prod-k8s-local.id
}

output "vpc_cidr_block" {
  value = aws_vpc.fr-amaury13-prod-k8s-local.cidr_block
}

output "vpc_id" {
  value = aws_vpc.fr-amaury13-prod-k8s-local.id
}

provider "aws" {
  region = "eu-west-3"
}

provider "aws" {
  alias  = "files"
  region = "eu-west-3"
}

resource "aws_autoscaling_group" "bastions-fr-amaury13-prod-k8s-local" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.bastions-fr-amaury13-prod-k8s-local.id
    version = aws_launch_template.bastions-fr-amaury13-prod-k8s-local.latest_version
  }
  load_balancers        = [aws_elb.bastion-fr-amaury13-prod-k8s-local.id]
  max_instance_lifetime = 0
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "bastions.fr.amaury13.prod.k8s.local"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "fr.amaury13.prod.k8s.local"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "bastions.fr.amaury13.prod.k8s.local"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/bastion"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "bastions"
  }
  tag {
    key                 = "kubernetes.io/cluster/fr.amaury13.prod.k8s.local"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.eu-west-3a-fr-amaury13-prod-k8s-local.id]
}

resource "aws_autoscaling_group" "master-eu-west-3a-masters-fr-amaury13-prod-k8s-local" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.master-eu-west-3a-masters-fr-amaury13-prod-k8s-local.id
    version = aws_launch_template.master-eu-west-3a-masters-fr-amaury13-prod-k8s-local.latest_version
  }
  load_balancers        = [aws_elb.api-fr-amaury13-prod-k8s-local.id]
  max_instance_lifetime = 0
  max_size              = 1
  metrics_granularity   = "1Minute"
  min_size              = 1
  name                  = "master-eu-west-3a.masters.fr.amaury13.prod.k8s.local"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "fr.amaury13.prod.k8s.local"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "master-eu-west-3a.masters.fr.amaury13.prod.k8s.local"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/master"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "master-eu-west-3a"
  }
  tag {
    key                 = "kubernetes.io/cluster/fr.amaury13.prod.k8s.local"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.eu-west-3a-fr-amaury13-prod-k8s-local.id]
}

resource "aws_autoscaling_group" "nodes-eu-west-3a-fr-amaury13-prod-k8s-local" {
  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_template {
    id      = aws_launch_template.nodes-eu-west-3a-fr-amaury13-prod-k8s-local.id
    version = aws_launch_template.nodes-eu-west-3a-fr-amaury13-prod-k8s-local.latest_version
  }
  max_instance_lifetime = 0
  max_size              = 3
  metrics_granularity   = "1Minute"
  min_size              = 3
  name                  = "nodes-eu-west-3a.fr.amaury13.prod.k8s.local"
  protect_from_scale_in = false
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "fr.amaury13.prod.k8s.local"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "nodes-eu-west-3a.fr.amaury13.prod.k8s.local"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node"
    propagate_at_launch = true
    value               = ""
  }
  tag {
    key                 = "k8s.io/role/node"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "nodes-eu-west-3a"
  }
  tag {
    key                 = "kubernetes.io/cluster/fr.amaury13.prod.k8s.local"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.eu-west-3a-fr-amaury13-prod-k8s-local.id]
}

resource "aws_ebs_volume" "a-etcd-events-fr-amaury13-prod-k8s-local" {
  availability_zone = "eu-west-3a"
  encrypted         = true
  iops              = 3000
  size              = 20
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "a.etcd-events.fr.amaury13.prod.k8s.local"
    "k8s.io/etcd/events"                               = "a/a"
    "k8s.io/role/master"                               = "1"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
  throughput = 125
  type       = "gp3"
}

resource "aws_ebs_volume" "a-etcd-main-fr-amaury13-prod-k8s-local" {
  availability_zone = "eu-west-3a"
  encrypted         = true
  iops              = 3000
  size              = 20
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "a.etcd-main.fr.amaury13.prod.k8s.local"
    "k8s.io/etcd/main"                                 = "a/a"
    "k8s.io/role/master"                               = "1"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
  throughput = 125
  type       = "gp3"
}

resource "aws_eip" "eu-west-3a-fr-amaury13-prod-k8s-local" {
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "eu-west-3a.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
  vpc = true
}

resource "aws_elb" "api-fr-amaury13-prod-k8s-local" {
  connection_draining         = true
  connection_draining_timeout = 300
  cross_zone_load_balancing   = false
  health_check {
    healthy_threshold   = 2
    interval            = 10
    target              = "SSL:443"
    timeout             = 5
    unhealthy_threshold = 2
  }
  idle_timeout = 300
  listener {
    instance_port     = 443
    instance_protocol = "TCP"
    lb_port           = 443
    lb_protocol       = "TCP"
  }
  name            = "api-fr-amaury13-prod-k8s--tvgrgn"
  security_groups = [aws_security_group.api-elb-fr-amaury13-prod-k8s-local.id]
  subnets         = [aws_subnet.utility-eu-west-3a-fr-amaury13-prod-k8s-local.id]
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "api.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
}

resource "aws_elb" "bastion-fr-amaury13-prod-k8s-local" {
  health_check {
    healthy_threshold   = 2
    interval            = 10
    target              = "TCP:22"
    timeout             = 5
    unhealthy_threshold = 2
  }
  idle_timeout = 300
  listener {
    instance_port     = 22
    instance_protocol = "TCP"
    lb_port           = 22
    lb_protocol       = "TCP"
  }
  name            = "bastion-fr-amaury13-prod--pbtdd1"
  security_groups = [aws_security_group.bastion-elb-fr-amaury13-prod-k8s-local.id]
  subnets         = [aws_subnet.utility-eu-west-3a-fr-amaury13-prod-k8s-local.id]
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "bastion.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
}

resource "aws_iam_instance_profile" "bastions-fr-amaury13-prod-k8s-local" {
  name = "bastions.fr.amaury13.prod.k8s.local"
  role = aws_iam_role.bastions-fr-amaury13-prod-k8s-local.name
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "bastions.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-fr-amaury13-prod-k8s-local" {
  name = "masters.fr.amaury13.prod.k8s.local"
  role = aws_iam_role.masters-fr-amaury13-prod-k8s-local.name
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "masters.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
}

resource "aws_iam_instance_profile" "nodes-fr-amaury13-prod-k8s-local" {
  name = "nodes.fr.amaury13.prod.k8s.local"
  role = aws_iam_role.nodes-fr-amaury13-prod-k8s-local.name
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "nodes.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
}

resource "aws_iam_role" "bastions-fr-amaury13-prod-k8s-local" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_bastions.fr.amaury13.prod.k8s.local_policy")
  name               = "bastions.fr.amaury13.prod.k8s.local"
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "bastions.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
}

resource "aws_iam_role" "masters-fr-amaury13-prod-k8s-local" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_masters.fr.amaury13.prod.k8s.local_policy")
  name               = "masters.fr.amaury13.prod.k8s.local"
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "masters.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
}

resource "aws_iam_role" "nodes-fr-amaury13-prod-k8s-local" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_nodes.fr.amaury13.prod.k8s.local_policy")
  name               = "nodes.fr.amaury13.prod.k8s.local"
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "nodes.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
}

resource "aws_iam_role_policy" "bastions-fr-amaury13-prod-k8s-local" {
  name   = "bastions.fr.amaury13.prod.k8s.local"
  policy = file("${path.module}/data/aws_iam_role_policy_bastions.fr.amaury13.prod.k8s.local_policy")
  role   = aws_iam_role.bastions-fr-amaury13-prod-k8s-local.name
}

resource "aws_iam_role_policy" "masters-fr-amaury13-prod-k8s-local" {
  name   = "masters.fr.amaury13.prod.k8s.local"
  policy = file("${path.module}/data/aws_iam_role_policy_masters.fr.amaury13.prod.k8s.local_policy")
  role   = aws_iam_role.masters-fr-amaury13-prod-k8s-local.name
}

resource "aws_iam_role_policy" "nodes-fr-amaury13-prod-k8s-local" {
  name   = "nodes.fr.amaury13.prod.k8s.local"
  policy = file("${path.module}/data/aws_iam_role_policy_nodes.fr.amaury13.prod.k8s.local_policy")
  role   = aws_iam_role.nodes-fr-amaury13-prod-k8s-local.name
}

resource "aws_internet_gateway" "fr-amaury13-prod-k8s-local" {
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
  vpc_id = aws_vpc.fr-amaury13-prod-k8s-local.id
}

resource "aws_launch_template" "bastions-fr-amaury13-prod-k8s-local" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 32
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.bastions-fr-amaury13-prod-k8s-local.id
  }
  image_id      = "ami-05d91095ca9ecd4b8"
  instance_type = "t3.micro"
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }
  monitoring {
    enabled = false
  }
  name = "bastions.fr.amaury13.prod.k8s.local"
  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.bastion-fr-amaury13-prod-k8s-local.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                          = "fr.amaury13.prod.k8s.local"
      "Name"                                                                       = "bastions.fr.amaury13.prod.k8s.local"
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/bastion"                                                        = "1"
      "kops.k8s.io/instancegroup"                                                  = "bastions"
      "kubernetes.io/cluster/fr.amaury13.prod.k8s.local"                           = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                          = "fr.amaury13.prod.k8s.local"
      "Name"                                                                       = "bastions.fr.amaury13.prod.k8s.local"
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/bastion"                                                        = "1"
      "kops.k8s.io/instancegroup"                                                  = "bastions"
      "kubernetes.io/cluster/fr.amaury13.prod.k8s.local"                           = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                          = "fr.amaury13.prod.k8s.local"
    "Name"                                                                       = "bastions.fr.amaury13.prod.k8s.local"
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
    "k8s.io/role/bastion"                                                        = "1"
    "kops.k8s.io/instancegroup"                                                  = "bastions"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local"                           = "owned"
  }
}

resource "aws_launch_template" "master-eu-west-3a-masters-fr-amaury13-prod-k8s-local" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 64
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.masters-fr-amaury13-prod-k8s-local.id
  }
  image_id      = "ami-05d91095ca9ecd4b8"
  instance_type = "t3.medium"
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 3
    http_tokens                 = "required"
  }
  monitoring {
    enabled = false
  }
  name = "master-eu-west-3a.masters.fr.amaury13.prod.k8s.local"
  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.masters-fr-amaury13-prod-k8s-local.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                                                     = "fr.amaury13.prod.k8s.local"
      "Name"                                                                                                  = "master-eu-west-3a.masters.fr.amaury13.prod.k8s.local"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
      "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
      "k8s.io/role/master"                                                                                    = "1"
      "kops.k8s.io/instancegroup"                                                                             = "master-eu-west-3a"
      "kubernetes.io/cluster/fr.amaury13.prod.k8s.local"                                                      = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                                                     = "fr.amaury13.prod.k8s.local"
      "Name"                                                                                                  = "master-eu-west-3a.masters.fr.amaury13.prod.k8s.local"
      "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
      "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
      "k8s.io/role/master"                                                                                    = "1"
      "kops.k8s.io/instancegroup"                                                                             = "master-eu-west-3a"
      "kubernetes.io/cluster/fr.amaury13.prod.k8s.local"                                                      = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                                                     = "fr.amaury13.prod.k8s.local"
    "Name"                                                                                                  = "master-eu-west-3a.masters.fr.amaury13.prod.k8s.local"
    "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/kops-controller-pki"                         = ""
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/control-plane"                   = ""
    "k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/exclude-from-external-load-balancers" = ""
    "k8s.io/role/master"                                                                                    = "1"
    "kops.k8s.io/instancegroup"                                                                             = "master-eu-west-3a"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local"                                                      = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_master-eu-west-3a.masters.fr.amaury13.prod.k8s.local_user_data")
}

resource "aws_launch_template" "nodes-eu-west-3a-fr-amaury13-prod-k8s-local" {
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      encrypted             = true
      iops                  = 3000
      throughput            = 125
      volume_size           = 128
      volume_type           = "gp3"
    }
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.nodes-fr-amaury13-prod-k8s-local.id
  }
  image_id      = "ami-05d91095ca9ecd4b8"
  instance_type = "t3.medium"
  lifecycle {
    create_before_destroy = true
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }
  monitoring {
    enabled = false
  }
  name = "nodes-eu-west-3a.fr.amaury13.prod.k8s.local"
  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.nodes-fr-amaury13-prod-k8s-local.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      "KubernetesCluster"                                                          = "fr.amaury13.prod.k8s.local"
      "Name"                                                                       = "nodes-eu-west-3a.fr.amaury13.prod.k8s.local"
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-eu-west-3a"
      "kubernetes.io/cluster/fr.amaury13.prod.k8s.local"                           = "owned"
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      "KubernetesCluster"                                                          = "fr.amaury13.prod.k8s.local"
      "Name"                                                                       = "nodes-eu-west-3a.fr.amaury13.prod.k8s.local"
      "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
      "k8s.io/role/node"                                                           = "1"
      "kops.k8s.io/instancegroup"                                                  = "nodes-eu-west-3a"
      "kubernetes.io/cluster/fr.amaury13.prod.k8s.local"                           = "owned"
    }
  }
  tags = {
    "KubernetesCluster"                                                          = "fr.amaury13.prod.k8s.local"
    "Name"                                                                       = "nodes-eu-west-3a.fr.amaury13.prod.k8s.local"
    "k8s.io/cluster-autoscaler/node-template/label/node-role.kubernetes.io/node" = ""
    "k8s.io/role/node"                                                           = "1"
    "kops.k8s.io/instancegroup"                                                  = "nodes-eu-west-3a"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local"                           = "owned"
  }
  user_data = filebase64("${path.module}/data/aws_launch_template_nodes-eu-west-3a.fr.amaury13.prod.k8s.local_user_data")
}

resource "aws_nat_gateway" "eu-west-3a-fr-amaury13-prod-k8s-local" {
  allocation_id = aws_eip.eu-west-3a-fr-amaury13-prod-k8s-local.id
  subnet_id     = aws_subnet.utility-eu-west-3a-fr-amaury13-prod-k8s-local.id
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "eu-west-3a.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
}

resource "aws_route" "route-0-0-0-0--0" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.fr-amaury13-prod-k8s-local.id
  route_table_id         = aws_route_table.fr-amaury13-prod-k8s-local.id
}

resource "aws_route" "route-__--0" {
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.fr-amaury13-prod-k8s-local.id
  route_table_id              = aws_route_table.fr-amaury13-prod-k8s-local.id
}

resource "aws_route" "route-private-eu-west-3a-0-0-0-0--0" {
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.eu-west-3a-fr-amaury13-prod-k8s-local.id
  route_table_id         = aws_route_table.private-eu-west-3a-fr-amaury13-prod-k8s-local.id
}

resource "aws_route_table" "fr-amaury13-prod-k8s-local" {
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
    "kubernetes.io/kops/role"                          = "public"
  }
  vpc_id = aws_vpc.fr-amaury13-prod-k8s-local.id
}

resource "aws_route_table" "private-eu-west-3a-fr-amaury13-prod-k8s-local" {
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "private-eu-west-3a.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
    "kubernetes.io/kops/role"                          = "private-eu-west-3a"
  }
  vpc_id = aws_vpc.fr-amaury13-prod-k8s-local.id
}

resource "aws_route_table_association" "private-eu-west-3a-fr-amaury13-prod-k8s-local" {
  route_table_id = aws_route_table.private-eu-west-3a-fr-amaury13-prod-k8s-local.id
  subnet_id      = aws_subnet.eu-west-3a-fr-amaury13-prod-k8s-local.id
}

resource "aws_route_table_association" "utility-eu-west-3a-fr-amaury13-prod-k8s-local" {
  route_table_id = aws_route_table.fr-amaury13-prod-k8s-local.id
  subnet_id      = aws_subnet.utility-eu-west-3a-fr-amaury13-prod-k8s-local.id
}

resource "aws_s3_object" "cluster-completed-spec" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_cluster-completed.spec_content")
  key      = "fr.amaury13.prod.k8s.local/cluster-completed.spec"
  provider = aws.files
}

resource "aws_s3_object" "etcd-cluster-spec-events" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_etcd-cluster-spec-events_content")
  key      = "fr.amaury13.prod.k8s.local/backups/etcd/events/control/etcd-cluster-spec"
  provider = aws.files
}

resource "aws_s3_object" "etcd-cluster-spec-main" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_etcd-cluster-spec-main_content")
  key      = "fr.amaury13.prod.k8s.local/backups/etcd/main/control/etcd-cluster-spec"
  provider = aws.files
}

resource "aws_s3_object" "fr-amaury13-prod-k8s-local-addons-aws-cloud-controller-addons-k8s-io-k8s-1-18" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_fr.amaury13.prod.k8s.local-addons-aws-cloud-controller.addons.k8s.io-k8s-1.18_content")
  key      = "fr.amaury13.prod.k8s.local/addons/aws-cloud-controller.addons.k8s.io/k8s-1.18.yaml"
  provider = aws.files
}

resource "aws_s3_object" "fr-amaury13-prod-k8s-local-addons-aws-ebs-csi-driver-addons-k8s-io-k8s-1-17" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_fr.amaury13.prod.k8s.local-addons-aws-ebs-csi-driver.addons.k8s.io-k8s-1.17_content")
  key      = "fr.amaury13.prod.k8s.local/addons/aws-ebs-csi-driver.addons.k8s.io/k8s-1.17.yaml"
  provider = aws.files
}

resource "aws_s3_object" "fr-amaury13-prod-k8s-local-addons-bootstrap" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_fr.amaury13.prod.k8s.local-addons-bootstrap_content")
  key      = "fr.amaury13.prod.k8s.local/addons/bootstrap-channel.yaml"
  provider = aws.files
}

resource "aws_s3_object" "fr-amaury13-prod-k8s-local-addons-coredns-addons-k8s-io-k8s-1-12" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_fr.amaury13.prod.k8s.local-addons-coredns.addons.k8s.io-k8s-1.12_content")
  key      = "fr.amaury13.prod.k8s.local/addons/coredns.addons.k8s.io/k8s-1.12.yaml"
  provider = aws.files
}

resource "aws_s3_object" "fr-amaury13-prod-k8s-local-addons-dns-controller-addons-k8s-io-k8s-1-12" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_fr.amaury13.prod.k8s.local-addons-dns-controller.addons.k8s.io-k8s-1.12_content")
  key      = "fr.amaury13.prod.k8s.local/addons/dns-controller.addons.k8s.io/k8s-1.12.yaml"
  provider = aws.files
}

resource "aws_s3_object" "fr-amaury13-prod-k8s-local-addons-kops-controller-addons-k8s-io-k8s-1-16" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_fr.amaury13.prod.k8s.local-addons-kops-controller.addons.k8s.io-k8s-1.16_content")
  key      = "fr.amaury13.prod.k8s.local/addons/kops-controller.addons.k8s.io/k8s-1.16.yaml"
  provider = aws.files
}

resource "aws_s3_object" "fr-amaury13-prod-k8s-local-addons-kubelet-api-rbac-addons-k8s-io-k8s-1-9" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_fr.amaury13.prod.k8s.local-addons-kubelet-api.rbac.addons.k8s.io-k8s-1.9_content")
  key      = "fr.amaury13.prod.k8s.local/addons/kubelet-api.rbac.addons.k8s.io/k8s-1.9.yaml"
  provider = aws.files
}

resource "aws_s3_object" "fr-amaury13-prod-k8s-local-addons-leader-migration-rbac-addons-k8s-io-k8s-1-23" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_fr.amaury13.prod.k8s.local-addons-leader-migration.rbac.addons.k8s.io-k8s-1.23_content")
  key      = "fr.amaury13.prod.k8s.local/addons/leader-migration.rbac.addons.k8s.io/k8s-1.23.yaml"
  provider = aws.files
}

resource "aws_s3_object" "fr-amaury13-prod-k8s-local-addons-limit-range-addons-k8s-io" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_fr.amaury13.prod.k8s.local-addons-limit-range.addons.k8s.io_content")
  key      = "fr.amaury13.prod.k8s.local/addons/limit-range.addons.k8s.io/v1.5.0.yaml"
  provider = aws.files
}

resource "aws_s3_object" "fr-amaury13-prod-k8s-local-addons-networking-projectcalico-org-canal-k8s-1-25" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_fr.amaury13.prod.k8s.local-addons-networking.projectcalico.org.canal-k8s-1.25_content")
  key      = "fr.amaury13.prod.k8s.local/addons/networking.projectcalico.org.canal/k8s-1.25.yaml"
  provider = aws.files
}

resource "aws_s3_object" "fr-amaury13-prod-k8s-local-addons-storage-aws-addons-k8s-io-v1-15-0" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_fr.amaury13.prod.k8s.local-addons-storage-aws.addons.k8s.io-v1.15.0_content")
  key      = "fr.amaury13.prod.k8s.local/addons/storage-aws.addons.k8s.io/v1.15.0.yaml"
  provider = aws.files
}

resource "aws_s3_object" "kops-version-txt" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_kops-version.txt_content")
  key      = "fr.amaury13.prod.k8s.local/kops-version.txt"
  provider = aws.files
}

resource "aws_s3_object" "manifests-etcdmanager-events-master-eu-west-3a" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_manifests-etcdmanager-events-master-eu-west-3a_content")
  key      = "fr.amaury13.prod.k8s.local/manifests/etcd/events-master-eu-west-3a.yaml"
  provider = aws.files
}

resource "aws_s3_object" "manifests-etcdmanager-main-master-eu-west-3a" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_manifests-etcdmanager-main-master-eu-west-3a_content")
  key      = "fr.amaury13.prod.k8s.local/manifests/etcd/main-master-eu-west-3a.yaml"
  provider = aws.files
}

resource "aws_s3_object" "manifests-static-kube-apiserver-healthcheck" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_manifests-static-kube-apiserver-healthcheck_content")
  key      = "fr.amaury13.prod.k8s.local/manifests/static/kube-apiserver-healthcheck.yaml"
  provider = aws.files
}

resource "aws_s3_object" "nodeupconfig-master-eu-west-3a" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_nodeupconfig-master-eu-west-3a_content")
  key      = "fr.amaury13.prod.k8s.local/igconfig/master/master-eu-west-3a/nodeupconfig.yaml"
  provider = aws.files
}

resource "aws_s3_object" "nodeupconfig-nodes-eu-west-3a" {
  bucket   = "amauryg13.cluster.prod.state"
  content  = file("${path.module}/data/aws_s3_object_nodeupconfig-nodes-eu-west-3a_content")
  key      = "fr.amaury13.prod.k8s.local/igconfig/node/nodes-eu-west-3a/nodeupconfig.yaml"
  provider = aws.files
}

resource "aws_security_group" "api-elb-fr-amaury13-prod-k8s-local" {
  description = "Security group for api ELB"
  name        = "api-elb.fr.amaury13.prod.k8s.local"
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "api-elb.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
  vpc_id = aws_vpc.fr-amaury13-prod-k8s-local.id
}

resource "aws_security_group" "bastion-elb-fr-amaury13-prod-k8s-local" {
  description = "Security group for bastion ELB"
  name        = "bastion-elb.fr.amaury13.prod.k8s.local"
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "bastion-elb.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
  vpc_id = aws_vpc.fr-amaury13-prod-k8s-local.id
}

resource "aws_security_group" "bastion-fr-amaury13-prod-k8s-local" {
  description = "Security group for bastion"
  name        = "bastion.fr.amaury13.prod.k8s.local"
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "bastion.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
  vpc_id = aws_vpc.fr-amaury13-prod-k8s-local.id
}

resource "aws_security_group" "masters-fr-amaury13-prod-k8s-local" {
  description = "Security group for masters"
  name        = "masters.fr.amaury13.prod.k8s.local"
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "masters.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
  vpc_id = aws_vpc.fr-amaury13-prod-k8s-local.id
}

resource "aws_security_group" "nodes-fr-amaury13-prod-k8s-local" {
  description = "Security group for nodes"
  name        = "nodes.fr.amaury13.prod.k8s.local"
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "nodes.fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
  vpc_id = aws_vpc.fr-amaury13-prod-k8s-local.id
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-22to22-bastion-elb-fr-amaury13-prod-k8s-local" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion-elb-fr-amaury13-prod-k8s-local.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-0-0-0-0--0-ingress-tcp-443to443-api-elb-fr-amaury13-prod-k8s-local" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.api-elb-fr-amaury13-prod-k8s-local.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "from-__--0-ingress-tcp-22to22-bastion-elb-fr-amaury13-prod-k8s-local" {
  from_port         = 22
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion-elb-fr-amaury13-prod-k8s-local.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "from-__--0-ingress-tcp-443to443-api-elb-fr-amaury13-prod-k8s-local" {
  from_port         = 443
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "tcp"
  security_group_id = aws_security_group.api-elb-fr-amaury13-prod-k8s-local.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "from-api-elb-fr-amaury13-prod-k8s-local-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.api-elb-fr-amaury13-prod-k8s-local.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-api-elb-fr-amaury13-prod-k8s-local-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.api-elb-fr-amaury13-prod-k8s-local.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-elb-fr-amaury13-prod-k8s-local-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-elb-fr-amaury13-prod-k8s-local.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-elb-fr-amaury13-prod-k8s-local-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-elb-fr-amaury13-prod-k8s-local.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-elb-fr-amaury13-prod-k8s-local-ingress-tcp-22to22-bastion-fr-amaury13-prod-k8s-local" {
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.bastion-fr-amaury13-prod-k8s-local.id
  source_security_group_id = aws_security_group.bastion-elb-fr-amaury13-prod-k8s-local.id
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-bastion-fr-amaury13-prod-k8s-local-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-fr-amaury13-prod-k8s-local.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-fr-amaury13-prod-k8s-local-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.bastion-fr-amaury13-prod-k8s-local.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-bastion-fr-amaury13-prod-k8s-local-ingress-tcp-22to22-masters-fr-amaury13-prod-k8s-local" {
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-fr-amaury13-prod-k8s-local.id
  source_security_group_id = aws_security_group.bastion-fr-amaury13-prod-k8s-local.id
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-bastion-fr-amaury13-prod-k8s-local-ingress-tcp-22to22-nodes-fr-amaury13-prod-k8s-local" {
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.nodes-fr-amaury13-prod-k8s-local.id
  source_security_group_id = aws_security_group.bastion-fr-amaury13-prod-k8s-local.id
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-masters-fr-amaury13-prod-k8s-local-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.masters-fr-amaury13-prod-k8s-local.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-masters-fr-amaury13-prod-k8s-local-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.masters-fr-amaury13-prod-k8s-local.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-masters-fr-amaury13-prod-k8s-local-ingress-all-0to0-masters-fr-amaury13-prod-k8s-local" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.masters-fr-amaury13-prod-k8s-local.id
  source_security_group_id = aws_security_group.masters-fr-amaury13-prod-k8s-local.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-masters-fr-amaury13-prod-k8s-local-ingress-all-0to0-nodes-fr-amaury13-prod-k8s-local" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-fr-amaury13-prod-k8s-local.id
  source_security_group_id = aws_security_group.masters-fr-amaury13-prod-k8s-local.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-fr-amaury13-prod-k8s-local-egress-all-0to0-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.nodes-fr-amaury13-prod-k8s-local.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-nodes-fr-amaury13-prod-k8s-local-egress-all-0to0-__--0" {
  from_port         = 0
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "-1"
  security_group_id = aws_security_group.nodes-fr-amaury13-prod-k8s-local.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "from-nodes-fr-amaury13-prod-k8s-local-ingress-all-0to0-nodes-fr-amaury13-prod-k8s-local" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-fr-amaury13-prod-k8s-local.id
  source_security_group_id = aws_security_group.nodes-fr-amaury13-prod-k8s-local.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-fr-amaury13-prod-k8s-local-ingress-tcp-1to2379-masters-fr-amaury13-prod-k8s-local" {
  from_port                = 1
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-fr-amaury13-prod-k8s-local.id
  source_security_group_id = aws_security_group.nodes-fr-amaury13-prod-k8s-local.id
  to_port                  = 2379
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-fr-amaury13-prod-k8s-local-ingress-tcp-2382to4000-masters-fr-amaury13-prod-k8s-local" {
  from_port                = 2382
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-fr-amaury13-prod-k8s-local.id
  source_security_group_id = aws_security_group.nodes-fr-amaury13-prod-k8s-local.id
  to_port                  = 4000
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-fr-amaury13-prod-k8s-local-ingress-tcp-4003to65535-masters-fr-amaury13-prod-k8s-local" {
  from_port                = 4003
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-fr-amaury13-prod-k8s-local.id
  source_security_group_id = aws_security_group.nodes-fr-amaury13-prod-k8s-local.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "from-nodes-fr-amaury13-prod-k8s-local-ingress-udp-1to65535-masters-fr-amaury13-prod-k8s-local" {
  from_port                = 1
  protocol                 = "udp"
  security_group_id        = aws_security_group.masters-fr-amaury13-prod-k8s-local.id
  source_security_group_id = aws_security_group.nodes-fr-amaury13-prod-k8s-local.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "https-elb-to-master" {
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-fr-amaury13-prod-k8s-local.id
  source_security_group_id = aws_security_group.api-elb-fr-amaury13-prod-k8s-local.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "icmp-pmtu-api-elb-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 3
  protocol          = "icmp"
  security_group_id = aws_security_group.api-elb-fr-amaury13-prod-k8s-local.id
  to_port           = 4
  type              = "ingress"
}

resource "aws_security_group_rule" "icmpv6-pmtu-api-elb-__--0" {
  from_port         = -1
  ipv6_cidr_blocks  = ["::/0"]
  protocol          = "icmpv6"
  security_group_id = aws_security_group.api-elb-fr-amaury13-prod-k8s-local.id
  to_port           = -1
  type              = "ingress"
}

resource "aws_subnet" "eu-west-3a-fr-amaury13-prod-k8s-local" {
  availability_zone                           = "eu-west-3a"
  cidr_block                                  = "172.20.32.0/19"
  enable_resource_name_dns_a_record_on_launch = true
  private_dns_hostname_type_on_launch         = "resource-name"
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "eu-west-3a.fr.amaury13.prod.k8s.local"
    "SubnetType"                                       = "Private"
    "kops.k8s.io/instance-group/bastions"              = "true"
    "kops.k8s.io/instance-group/master-eu-west-3a"     = "true"
    "kops.k8s.io/instance-group/nodes-eu-west-3a"      = "true"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
    "kubernetes.io/role/internal-elb"                  = "1"
  }
  vpc_id = aws_vpc.fr-amaury13-prod-k8s-local.id
}

resource "aws_subnet" "utility-eu-west-3a-fr-amaury13-prod-k8s-local" {
  availability_zone                           = "eu-west-3a"
  cidr_block                                  = "172.20.0.0/22"
  enable_resource_name_dns_a_record_on_launch = true
  private_dns_hostname_type_on_launch         = "resource-name"
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "utility-eu-west-3a.fr.amaury13.prod.k8s.local"
    "SubnetType"                                       = "Utility"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
    "kubernetes.io/role/elb"                           = "1"
  }
  vpc_id = aws_vpc.fr-amaury13-prod-k8s-local.id
}

resource "aws_vpc" "fr-amaury13-prod-k8s-local" {
  assign_generated_ipv6_cidr_block = true
  cidr_block                       = "172.20.0.0/16"
  enable_dns_hostnames             = true
  enable_dns_support               = true
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "fr-amaury13-prod-k8s-local" {
  domain_name         = "eu-west-3.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]
  tags = {
    "KubernetesCluster"                                = "fr.amaury13.prod.k8s.local"
    "Name"                                             = "fr.amaury13.prod.k8s.local"
    "kubernetes.io/cluster/fr.amaury13.prod.k8s.local" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "fr-amaury13-prod-k8s-local" {
  dhcp_options_id = aws_vpc_dhcp_options.fr-amaury13-prod-k8s-local.id
  vpc_id          = aws_vpc.fr-amaury13-prod-k8s-local.id
}

terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = {
      "configuration_aliases" = [aws.files]
      "source"                = "hashicorp/aws"
      "version"               = ">= 4.0.0"
    }
  }
}
