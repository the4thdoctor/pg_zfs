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
    default = "europe-west4"
    description = "The region to use"
}

variable "gcp_zone" {
    default = "a"
    description = "The availability zone to use"
}
