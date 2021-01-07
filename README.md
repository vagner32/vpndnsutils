# Description
Developed for update resolv.conf link when connected to pritunl vpn client

# Building package [from git root directory]
sudo dpkg-deb --build vpndnsutils

# Installing package
sudo apt install -f ./vpndnsutils.deb -y

# Checking service status
sudo systemctl status vpndnsutils.service

# Stopping service
sudo systemctl stop vpndnsutils.service

# Starting service
sudo systemctl start vpndnsutils.service

# Restarting service
sudo systemctl restart vpndnsutils.service

# config file
/etc/vpndnsutils.conf

# exec file
/opt/vpndnsutils/listener.sh

# Removing service
sudo dpkg --remove vpndnsutils

# Notes
The service will start automatically after operational system boot
