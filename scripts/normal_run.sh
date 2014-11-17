pre_start_action() {
  # Cleanup previous sockets
  rm -f /data/mysql.sock
  bin/phd start
  cd /srv/www/phabricator/phabricator
  if ! [ -z "$MYSQL_PORT_3306_TCP_ADDR" ]; then 
  bin/config set mysql.host $MYSQL_PORT_3306_TCP_ADDR
  bin/config set mysql.port $MYSQL_PORT_3306_TCP_PORT
  bin/config set mysql.user $MYSQL_ENV_DB_USER
  bin/config set mysql.pass $MYSQL_ENV_DB_PASS
  fi
}

post_start_action() {
  : # No-op
}
