# bashloris
A Slowloris implementation in bash for use against HTTPS sites.

Usage:

	bashloris.sh [target] [port] [interval]


	
  Target can be supplied as an IP or name. Target and port are mandatory options.
  
  Interval is optional and defaults to five (5) seconds.
  
  Interval defines the time in seconds between sending each header line.

Example usage:


	$ ./bashloris.sh 127.0.0.1 443
	no interval value supplied, setting it to five (5) seconds.
	Target Server is 127.0.0.1:443
	Adding bashloris stunnel service to /etc/services
	Creating stunnel client on 127.0.0.1:6661
	Created stunnel configuration!
	Launching attack.....Use 'Ctrl c' to stop....


The attack runs until you manually kill it with 'Ctrl c'


## Requirements

* bash
* sudo
* netcat
* stunnel

