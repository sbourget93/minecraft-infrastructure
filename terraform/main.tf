provider "aws" {
  region = "us-east-2"
}

terraform {
    backend "s3" {
      bucket = "stephengb-minecraft"
      key = "terraform-state"
      region = "us-east-2"
    }
}

// This module is server agnostic and should exist regardless of server state.
// This should onbe destroyed if no minecraft servers are running.
module "global" {source = "./modules/global"}

module "butt_land" { source = "./modules/minecraft_server"
  server_name = "butt_land"
  branch_name = "butt_land"
  security_group_ids = "${module.global.security_group_ids}"
  associate_address_policy_arn = "${module.global.associate_address_policy_arn}"
}