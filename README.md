# bashloris
A Slowloris implementation in bash, using netcat

This currently onlyworks against HTTP sites.  HTTPS support will come later.

Usage:

<code>
bashloris.sh [target] [port] [interval]
</code>

	
  Target can be supplied as an IP or name. Target and port are mandatory options.
  
  Interval is optional and defaults to five (5) seconds.
  
  Interval defines the time in seconds between sending each header.
