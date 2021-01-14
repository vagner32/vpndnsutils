RESOLV_CONF=/etc/resolv.conf
RESOLV_CONF_BCKP="$RESOLV_CONF.vpnbckp"

inotifywait -m /tmp/pritunl/ -e create -e delete |while read dir action file; do
  if [[ "$file" =~ .*auth$ ]]; then
    echo "The file '$file' appeared in directory '$dir' via '$action'"
    # Connecting to VPN
    if [ $action == "CREATE" ]; then
      # Backup current resolv.conf
      if test -f $RESOLV_CONF; then
        mv $RESOLV_CONF $RESOLV_CONF_BCKP
      fi
      # Create fresh resolv.conf and add nameservers defined in VPN conf
      echo -n > $RESOLV_CONF
      echo "# Printunl VPN nameservers" >> $RESOLV_CONF
      echo "# Original resolv.conf file is backed up in $RESOLV_CONF_BCKP" >> $RESOLV_CONF
      echo "" >> $RESOLV_CONF
      grep -i -R 'dhcp-option DNS' /tmp/pritunl/* |awk '{print $3}' |sed -e 's/^/nameserver /' >> $RESOLV_CONF
    # Disconnecting from VPN and change resolv.conf back to what it was
    elif [ $action == "DELETE" ]; then
      if test -f $RESOLV_CONF_BCKP; then
        rm -rf $RESOLV_CONF
        mv $RESOLV_CONF_BCKP $RESOLV_CONF
        systemctl restart systemd-resolved
      fi
    fi
  fi
done