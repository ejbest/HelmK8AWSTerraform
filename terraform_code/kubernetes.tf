locals {
  cluster_name                 = "course.auto-deploy.net"
  master_autoscaling_group_ids = [aws_autoscaling_group.master-us-east-1a-masters-course-auto-deploy-net.id]
  master_security_group_ids    = [aws_security_group.masters-course-auto-deploy-net.id]
  masters_role_arn             = aws_iam_role.masters-course-auto-deploy-net.arn
  masters_role_name            = aws_iam_role.masters-course-auto-deploy-net.name
  node_autoscaling_group_ids   = [aws_autoscaling_group.nodes-course-auto-deploy-net.id]
  node_security_group_ids      = [aws_security_group.nodes-course-auto-deploy-net.id]
  node_subnet_ids              = [aws_subnet.us-east-1a-course-auto-deploy-net.id]
  nodes_role_arn               = aws_iam_role.nodes-course-auto-deploy-net.arn
  nodes_role_name              = aws_iam_role.nodes-course-auto-deploy-net.name
  region                       = "us-east-1"
  route_table_public_id        = aws_route_table.course-auto-deploy-net.id
  subnet_us-east-1a_id         = aws_subnet.us-east-1a-course-auto-deploy-net.id
  vpc_cidr_block               = aws_vpc.course-auto-deploy-net.cidr_block
  vpc_id                       = aws_vpc.course-auto-deploy-net.id
}

output "cluster_name" {
  value = "course.auto-deploy.net"
}

output "master_autoscaling_group_ids" {
  value = [aws_autoscaling_group.master-us-east-1a-masters-course-auto-deploy-net.id]
}

output "master_security_group_ids" {
  value = [aws_security_group.masters-course-auto-deploy-net.id]
}

output "masters_role_arn" {
  value = aws_iam_role.masters-course-auto-deploy-net.arn
}

output "masters_role_name" {
  value = aws_iam_role.masters-course-auto-deploy-net.name
}

output "node_autoscaling_group_ids" {
  value = [aws_autoscaling_group.nodes-course-auto-deploy-net.id]
}

output "node_security_group_ids" {
  value = [aws_security_group.nodes-course-auto-deploy-net.id]
}

output "node_subnet_ids" {
  value = [aws_subnet.us-east-1a-course-auto-deploy-net.id]
}

output "nodes_role_arn" {
  value = aws_iam_role.nodes-course-auto-deploy-net.arn
}

output "nodes_role_name" {
  value = aws_iam_role.nodes-course-auto-deploy-net.name
}

output "region" {
  value = "us-east-1"
}

output "route_table_public_id" {
  value = aws_route_table.course-auto-deploy-net.id
}

output "subnet_us-east-1a_id" {
  value = aws_subnet.us-east-1a-course-auto-deploy-net.id
}

output "vpc_cidr_block" {
  value = aws_vpc.course-auto-deploy-net.cidr_block
}

output "vpc_id" {
  value = aws_vpc.course-auto-deploy-net.id
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_autoscaling_group" "master-us-east-1a-masters-course-auto-deploy-net" {
  enabled_metrics      = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_configuration = aws_launch_configuration.master-us-east-1a-masters-course-auto-deploy-net.id
  max_size             = 1
  metrics_granularity  = "1Minute"
  min_size             = 1
  name                 = "master-us-east-1a.masters.course.auto-deploy.net"
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "course.auto-deploy.net"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "master-us-east-1a.masters.course.auto-deploy.net"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "master-us-east-1a"
  }
  tag {
    key                 = "k8s.io/role/master"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "master-us-east-1a"
  }
  tag {
    key                 = "kubernetes.io/cluster/course.auto-deploy.net"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.us-east-1a-course-auto-deploy-net.id]
}

resource "aws_autoscaling_group" "nodes-course-auto-deploy-net" {
  enabled_metrics      = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
  launch_configuration = aws_launch_configuration.nodes-course-auto-deploy-net.id
  max_size             = 2
  metrics_granularity  = "1Minute"
  min_size             = 2
  name                 = "nodes.course.auto-deploy.net"
  tag {
    key                 = "KubernetesCluster"
    propagate_at_launch = true
    value               = "course.auto-deploy.net"
  }
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "nodes.course.auto-deploy.net"
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "nodes"
  }
  tag {
    key                 = "k8s.io/role/node"
    propagate_at_launch = true
    value               = "1"
  }
  tag {
    key                 = "kops.k8s.io/instancegroup"
    propagate_at_launch = true
    value               = "nodes"
  }
  tag {
    key                 = "kubernetes.io/cluster/course.auto-deploy.net"
    propagate_at_launch = true
    value               = "owned"
  }
  vpc_zone_identifier = [aws_subnet.us-east-1a-course-auto-deploy-net.id]
}

resource "aws_ebs_volume" "a-etcd-events-course-auto-deploy-net" {
  availability_zone = "us-east-1a"
  encrypted         = false
  size              = 20
  tags = {
    "KubernetesCluster"                            = "course.auto-deploy.net"
    "Name"                                         = "a.etcd-events.course.auto-deploy.net"
    "k8s.io/etcd/events"                           = "a/a"
    "k8s.io/role/master"                           = "1"
    "kubernetes.io/cluster/course.auto-deploy.net" = "owned"
  }
  type = "gp2"
}

resource "aws_ebs_volume" "a-etcd-main-course-auto-deploy-net" {
  availability_zone = "us-east-1a"
  encrypted         = false
  size              = 20
  tags = {
    "KubernetesCluster"                            = "course.auto-deploy.net"
    "Name"                                         = "a.etcd-main.course.auto-deploy.net"
    "k8s.io/etcd/main"                             = "a/a"
    "k8s.io/role/master"                           = "1"
    "kubernetes.io/cluster/course.auto-deploy.net" = "owned"
  }
  type = "gp2"
}

resource "aws_iam_instance_profile" "masters-course-auto-deploy-net" {
  name = "masters.course.auto-deploy.net"
  role = aws_iam_role.masters-course-auto-deploy-net.name
}

resource "aws_iam_instance_profile" "nodes-course-auto-deploy-net" {
  name = "nodes.course.auto-deploy.net"
  role = aws_iam_role.nodes-course-auto-deploy-net.name
}

resource "aws_iam_role_policy" "masters-course-auto-deploy-net" {
  name   = "masters.course.auto-deploy.net"
  policy = file("${path.module}/data/aws_iam_role_policy_masters.course.auto-deploy.net_policy")
  role   = aws_iam_role.masters-course-auto-deploy-net.name
}

resource "aws_iam_role_policy" "nodes-course-auto-deploy-net" {
  name   = "nodes.course.auto-deploy.net"
  policy = file("${path.module}/data/aws_iam_role_policy_nodes.course.auto-deploy.net_policy")
  role   = aws_iam_role.nodes-course-auto-deploy-net.name
}

resource "aws_iam_role" "masters-course-auto-deploy-net" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_masters.course.auto-deploy.net_policy")
  name               = "masters.course.auto-deploy.net"
}

resource "aws_iam_role" "nodes-course-auto-deploy-net" {
  assume_role_policy = file("${path.module}/data/aws_iam_role_nodes.course.auto-deploy.net_policy")
  name               = "nodes.course.auto-deploy.net"
}

resource "aws_internet_gateway" "course-auto-deploy-net" {
  tags = {
    "KubernetesCluster"                            = "course.auto-deploy.net"
    "Name"                                         = "course.auto-deploy.net"
    "kubernetes.io/cluster/course.auto-deploy.net" = "owned"
  }
  vpc_id = aws_vpc.course-auto-deploy-net.id
}

resource "aws_key_pair" "kubernetes-course-auto-deploy-net-777b39902056d4fcf9c69c03c6a834af" {
  key_name   = "kubernetes.course.auto-deploy.net-77:7b:39:90:20:56:d4:fc:f9:c6:9c:03:c6:a8:34:af"
  public_key = file("${path.module}/data/aws_key_pair_kubernetes.course.auto-deploy.net-777b39902056d4fcf9c69c03c6a834af_public_key")
}

resource "aws_launch_configuration" "master-us-east-1a-masters-course-auto-deploy-net" {
  associate_public_ip_address = true
  enable_monitoring           = false
  iam_instance_profile        = aws_iam_instance_profile.masters-course-auto-deploy-net.id
  image_id                    = "ami-0074ee617a234808d"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.kubernetes-course-auto-deploy-net-777b39902056d4fcf9c69c03c6a834af.id
  lifecycle {
    create_before_destroy = true
  }
  name_prefix = "master-us-east-1a.masters.course.auto-deploy.net-"
  root_block_device {
    delete_on_termination = true
    volume_size           = 64
    volume_type           = "gp2"
  }
  security_groups = [aws_security_group.masters-course-auto-deploy-net.id]
  user_data       = file("${path.module}/data/aws_launch_configuration_master-us-east-1a.masters.course.auto-deploy.net_user_data")
}

resource "aws_launch_configuration" "nodes-course-auto-deploy-net" {
  associate_public_ip_address = true
  enable_monitoring           = false
  iam_instance_profile        = aws_iam_instance_profile.nodes-course-auto-deploy-net.id
  image_id                    = "ami-0074ee617a234808d"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.kubernetes-course-auto-deploy-net-777b39902056d4fcf9c69c03c6a834af.id
  lifecycle {
    create_before_destroy = true
  }
  name_prefix = "nodes.course.auto-deploy.net-"
  root_block_device {
    delete_on_termination = true
    volume_size           = 128
    volume_type           = "gp2"
  }
  security_groups = [aws_security_group.nodes-course-auto-deploy-net.id]
  user_data       = file("${path.module}/data/aws_launch_configuration_nodes.course.auto-deploy.net_user_data")
}

resource "aws_route_table_association" "us-east-1a-course-auto-deploy-net" {
  route_table_id = aws_route_table.course-auto-deploy-net.id
  subnet_id      = aws_subnet.us-east-1a-course-auto-deploy-net.id
}

resource "aws_route_table" "course-auto-deploy-net" {
  tags = {
    "KubernetesCluster"                            = "course.auto-deploy.net"
    "Name"                                         = "course.auto-deploy.net"
    "kubernetes.io/cluster/course.auto-deploy.net" = "owned"
    "kubernetes.io/kops/role"                      = "public"
  }
  vpc_id = aws_vpc.course-auto-deploy-net.id
}

resource "aws_route" "route-0-0-0-0--0" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.course-auto-deploy-net.id
  route_table_id         = aws_route_table.course-auto-deploy-net.id
}

resource "aws_security_group_rule" "all-master-to-master" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.masters-course-auto-deploy-net.id
  source_security_group_id = aws_security_group.masters-course-auto-deploy-net.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "all-master-to-node" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-course-auto-deploy-net.id
  source_security_group_id = aws_security_group.masters-course-auto-deploy-net.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "all-node-to-node" {
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.nodes-course-auto-deploy-net.id
  source_security_group_id = aws_security_group.nodes-course-auto-deploy-net.id
  to_port                  = 0
  type                     = "ingress"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.masters-course-auto-deploy-net.id
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "master-egress" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.masters-course-auto-deploy-net.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "node-egress" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.nodes-course-auto-deploy-net.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  from_port                = 1
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-course-auto-deploy-net.id
  source_security_group_id = aws_security_group.nodes-course-auto-deploy-net.id
  to_port                  = 2379
  type                     = "ingress"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  from_port                = 2382
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-course-auto-deploy-net.id
  source_security_group_id = aws_security_group.nodes-course-auto-deploy-net.id
  to_port                  = 4000
  type                     = "ingress"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  from_port                = 4003
  protocol                 = "tcp"
  security_group_id        = aws_security_group.masters-course-auto-deploy-net.id
  source_security_group_id = aws_security_group.nodes-course-auto-deploy-net.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  from_port                = 1
  protocol                 = "udp"
  security_group_id        = aws_security_group.masters-course-auto-deploy-net.id
  source_security_group_id = aws_security_group.nodes-course-auto-deploy-net.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.masters-course-auto-deploy-net.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.nodes-course-auto-deploy-net.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group" "masters-course-auto-deploy-net" {
  description = "Security group for masters"
  name        = "masters.course.auto-deploy.net"
  tags = {
    "KubernetesCluster"                            = "course.auto-deploy.net"
    "Name"                                         = "masters.course.auto-deploy.net"
    "kubernetes.io/cluster/course.auto-deploy.net" = "owned"
  }
  vpc_id = aws_vpc.course-auto-deploy-net.id
}

resource "aws_security_group" "nodes-course-auto-deploy-net" {
  description = "Security group for nodes"
  name        = "nodes.course.auto-deploy.net"
  tags = {
    "KubernetesCluster"                            = "course.auto-deploy.net"
    "Name"                                         = "nodes.course.auto-deploy.net"
    "kubernetes.io/cluster/course.auto-deploy.net" = "owned"
  }
  vpc_id = aws_vpc.course-auto-deploy-net.id
}

resource "aws_subnet" "us-east-1a-course-auto-deploy-net" {
  availability_zone = "us-east-1a"
  cidr_block        = "172.20.32.0/19"
  tags = {
    "KubernetesCluster"                            = "course.auto-deploy.net"
    "Name"                                         = "us-east-1a.course.auto-deploy.net"
    "SubnetType"                                   = "Public"
    "kubernetes.io/cluster/course.auto-deploy.net" = "owned"
    "kubernetes.io/role/elb"                       = "1"
  }
  vpc_id = aws_vpc.course-auto-deploy-net.id
}

resource "aws_vpc_dhcp_options_association" "course-auto-deploy-net" {
  dhcp_options_id = aws_vpc_dhcp_options.course-auto-deploy-net.id
  vpc_id          = aws_vpc.course-auto-deploy-net.id
}

resource "aws_vpc_dhcp_options" "course-auto-deploy-net" {
  domain_name         = "ec2.internal"
  domain_name_servers = ["AmazonProvidedDNS"]
  tags = {
    "KubernetesCluster"                            = "course.auto-deploy.net"
    "Name"                                         = "course.auto-deploy.net"
    "kubernetes.io/cluster/course.auto-deploy.net" = "owned"
  }
}

resource "aws_vpc" "course-auto-deploy-net" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "KubernetesCluster"                            = "course.auto-deploy.net"
    "Name"                                         = "course.auto-deploy.net"
    "kubernetes.io/cluster/course.auto-deploy.net" = "owned"
  }
}

terraform {
  required_version = ">= 0.12.0"
}
