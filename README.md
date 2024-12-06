# mon-services.sh
get status service: active - sent GET to https, inactive - nothing<br>
if service reload and restart - writing log<br>
if host not available - writing log<br>

# mon-services.service
autostart for script mon-services.sh<br>

# install mon-services.service #
change path to directory script mon-services.sh in ExecStart<br>
copy mon-services.service to /etc/systemd/system/<br>
start service systemctl enable --now mon-services.service<br>
