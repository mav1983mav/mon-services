# mon-services.sh
get status service: active - sent GET to https, inactive - nothing
if service reload and restart - writing log
if host not available - writing log


# mon-services.service
autostart for script mon-services.sh

# install mon-services.service #
change path to directory script mon-services.sh in ExecStart
copy mon-services.service to /etc/systemd/system/
start service systemctl enable --now mon-services.service
