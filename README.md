# Minecraft Infrastructure

### Overview
This is the infrastructure component of running a minecraft server. 
minecraft-infrastructure is responsible for spinning up the environment via terraform which will support a minecraft server, including autoscaling groups, security groups, route 53 records, etc.

The userdata script (which automatically runs) will perform the following actions:
* Send userdata stdout to `/var/log/user-data.log`
* Self assign an Elastic IP to which `[server_name].stephengb.com` sends traffic
* Update `yum` and install `git`
* Clone the `[server_name]` branch of the `sbourget93/minecraft-server` repository to `/home/ec2-user/`
* Run `/home/ec2-user/minecraft-server/bootstrap.sh`

From here, `bootstrap.sh` in the server codebase is responsible for setting everything else up (such as supervisord, crontab, java, and loading backups).

### Prerequisites
The following will not be created by terraform and must be pre-existing (in `us-east-2` where applicable):
* AWS credentials exported as environment variables
    ```
    export AWS_ACCESS_KEY_ID={aws_access_key_id}
    export AWS_SECRET_ACCESS_KEY={aws_secret_access_key}
    ```
* Route 53 hosted zone `stephengb.com`
* SSH key `stephengb.pem`
* S3 bucket `stephen-minecraft`


### Shell Scripts
Since this infrastructure code could be responsible for managing the infrastructure for multiple servers, terraform commands will be run through shell scripts to reduce the likelihood of mistakes.
* `./create.sh [module_name]` - runs terraform apply targeted at the [module_name] module
* `./destroy.sh [module_name]` - runs terraform apply targeted at the [module_name] module