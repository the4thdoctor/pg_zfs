variable "HOME" {
    type        = string
    description = "This is local user HOME DIR, if not recognised you will need to export the variable TF_VAR_HOME set to your home dir "
}

variable "credential_file" {
    type        = string
    description = "The credential file with full path specs. Set the variable TF_VAR_credential_file before using it"
}

variable "gcp_project" {
    type        = string
    description = "The gcp project's name. Set the variable TF_VAR_gcp_project before using it"
}


variable "gcp_region" {
    default = "europe-west10"
    description = "The region to use"
}

variable "gcp_zone" {
    default = "c"
    description = "The availability zone to use"
}

variable "ssh_user" {
  default = "ansible"
  description = "ssh ansible user"
}

variable "postgresql_node_count" {
  default = "1"
  description = "Number of postgresql nodes"
  }

variable "postgresql_node_prefix" {
    default = "postgresql-"
    description = "The node name prefix"
}


variable "pg_ext4_hdd" {
    default = "pg-ext4-hdd-"
    description = "The prefix for ext4 persistent disks "
}

variable "ssh_key" {
  default = ".ssh/kd-testing"
  description = "ssh key for login"
}

variable "bastion_name" {
    default = "bastion-kd-testing"
    description = "the bastion name for the pgbackrest setup. the name is set in ssh config auto generated. "
}

variable "ssh_bastion_conf" {
  default = ".ssh/config.d/kd-testing-bastion.conf"
  description = "ssh configuration file for the bastion connection"
}

variable "ssh_nodes_conf" {
  default = ".ssh/config.d/kd-testing-nodes.conf"
  description = "ssh configuration file for the database nodes connection"
}


