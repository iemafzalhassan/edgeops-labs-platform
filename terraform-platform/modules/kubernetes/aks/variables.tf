variable "cluster_name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "kubernetes_version" { type = string }
variable "system_subnet_id" { type = string }
variable "workload_subnet_id" { type = string }
variable "identity_id" { type = string }
variable "common_labels" { type = map(string) }
