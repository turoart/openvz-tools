openvz-tools
============

Some tools to monitor openvz servers

Beancounter usage
-----------------

Failcount values are useful to know what thinks could be causing troubles in a container, but this value show pass events if the server has not been restart.

scripts/beancounter_usage.sh show the actual percent of usage of some beancounters for every container in the host server. Values greater than 90% are show in red.

Usage: `$bash beancounter_usage.sh`
