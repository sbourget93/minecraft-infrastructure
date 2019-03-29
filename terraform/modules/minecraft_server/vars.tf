// The server name will be used to give unique names to AWS resources, and will be the subdomain of stephengb.com
// which players will connect to to join the server.
variable "server_name" {
  type = "string"
}

// The branch name only fetermines which branch to pull from the minecraft-server respository.
variable "branch_name" {
  type = "string"
}

// Global security groups ids to allow inbound/outbound traffic required by all servers.
variable "security_group_ids" {
  type = "list"
}

// Global policy arn that allow the servers to self assign an Elastic IP address.
variable "associate_address_policy_arn" {
  type = "string"
}
