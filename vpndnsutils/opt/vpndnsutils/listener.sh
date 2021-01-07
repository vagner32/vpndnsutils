VPN_FILE=/etc/resolv.conf.vpn
ORIGINAL_FILE=/run/resolvconf/resolv.conf
SLINK=/etc/resolv.conf
if [[ ! -f "$VPN_FILE" ]]; then
	echo "nameserver 8.8.8.8" > $VPN_FILE
	cat $ORIGINAL_FILE >> $VPN_FILE
fi

inotifywait -m /tmp/pritunl/ -e create -e delete |
    while read dir action file; do
	if [[ "$file" =~ .*auth$ ]]; then
        echo "The file '$file' appeared in directory '$dir' via '$action'"
	CURRENT_LINK_TARGET=`readlink -f /etc/resolv.conf`
	if [[ "$CURRENT_LINK_TARGET" == "$ORIGINAL_FILE" ]]; then #IDA
	  rm $SLINK
	  ln -s $VPN_FILE $SLINK
	else #VOLTA
	  rm $SLINK
	  ln -s $ORIGINAL_FILE $SLINK
	fi
	fi
    done
