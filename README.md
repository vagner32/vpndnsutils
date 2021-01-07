# vpndnsutils
Developed for update resolv.conf link when connected to pritunl vpn client

# for build [from a same level directory of the vpndnsutils]
sudo dpkg-deb --build vpndnsutils

# check service status
sudo systemctl status vpndnsutils.service

# stop service
sudo systemctl stop vpndnsutils.service

# start service
sudo systemctl start vpndnsutils.service

# restart service
sudo systemctl restart vpndnsutils.service

# config file
/etc/vpndnsutils.conf

# exec file
/opt/vpndnsutils/listener.sh
