#!/bin/bash
# Starts up the Phabricator stack within the container.

# Stop on error
set -e

DATA_DIR=/srv/www/phabricator
LOG_DIR=/var/log

if [[ -e /first_run ]]; then
  source /scripts/first_run.sh
else
  source /scripts/normal_run.sh
fi

pre_start_action
post_start_action


service sshd start
service nginx start
/usr/sbin/php-fpm
