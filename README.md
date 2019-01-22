# Awscli-tiny

Simple tool to install [awscli](https://docs.aws.amazon.com/en_us/cli/latest/userguide/cli-chap-install.html) to non-root user

## Attributes
Required:
* default['awscli']['user']          = 'user' // System user to install.
* default['awscli']['region']        = 'eu-central-1'        
* default['awscli']['key_id']        = 'AWS_ACCESS_KEY' 
* default['awscli']['secret key']    = 'AWS_SECRET_KEY'