# Fail2ban
### Run
```
docker run -d --name fail2ban --restart always \
  --network host \
  --cap-add NET_ADMIN \
  --cap-add NET_RAW \
  -v $(pwd)/data:/data \
  -v /var/log:/var/log:ro \
  glats/fail2ban:latest
```

### Volume

You can attach /data to save the config created by fail2ban


### Environment variables

`TZ`: The timezone assigned to the container (default `UTC`)  
`F2B_LOG_TARGET`: Set the log target. This could be a file, SYSLOG, STDERR or STDOUT (default `STDOUT`)  
`F2B_LOG_LEVEL`: Log level output (default `INFO`)  
`F2B_DB_PURGE_AGE`: Age at which bans should be purged from the database (default `1d`)  
`F2B_IPTABLES_CHAIN`: Specifies the iptables chain to which the Fail2Ban rules should be added (default `DOCKER-USER`)  
`SSMTP_HOST`: SMTP server host  
`SSMTP_PORT`: SMTP server port (default `25`)  
`SSMTP_HOSTNAME`: Full hostname (default `$(hostname -f)`)  
`SSMTP_USER`: SMTP username  
`SSMTP_PASSWORD`: SMTP password  
`SSMTP_TLS`: SSL/TLS (default `NO`)  