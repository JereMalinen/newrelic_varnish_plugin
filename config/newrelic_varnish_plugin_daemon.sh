#! /bin/sh
### BEGIN INIT INFO
# Provides:          newrelic-varnish
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Script to start and stop newrelic-varnish plugin agent
# Description:       The config and pid file should be set in this script
### END INIT INFO

# Author: Ilon Sjögrens

# Do NOT "set -e"

PATH=/sbin:/usr/sbin:/bin:/usr/bin
DESC="Newrelic Varnish plugin daemon"
NAME=newrelic-varnish
DAEMON=/usr/local/bin/newrelic-varnish-plugin
CONFIG=/etc/newrelic/newrelic_varnish_plugin.yml
PIDFILE=/var/run/newrelic_varnish_plugin.pid
PID=`cat $PIDFILE`
SCRIPTNAME=/etc/init.d/$NAME

# Exit if the package is not installed
[ -x "$DAEMON" ] || exit 0

# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME

# Load the VERBOSE setting and other rcS variables
. /lib/init/vars.sh

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.2-14) to ensure that this file is present
# and status_of_proc is working.
. /lib/lsb/init-functions

#
# Function that starts the daemon/service
#
do_start()
{
        exec $DAEMON -c $CONFIG -p $PIDFILE &
}

#
# Function that stops the daemon/service
#
do_stop()
{
        start-stop-daemon --stop --retry=TERM/30/KILL/5 --pidfile $PIDFILE
}

case "$1" in
  start)
        # Check the process isn't already started
        if ps --pid $PID >/dev/null 2>&1; then
                echo "$NAME is already running at $PID"
                exit 4
        fi
        [ "$VERBOSE" != no ] && log_daemon_msg "Starting $DESC" "$NAME"
        do_start
        case "$?" in
                0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
                2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
        esac
        ;;
  stop)
        [ "$VERBOSE" != no ] && log_daemon_msg "Stopping $DESC" "$NAME"
        do_stop
        case "$?" in
                0|1) [ "$VERBOSE" != no ] && log_end_msg 0 ;;
                2) [ "$VERBOSE" != no ] && log_end_msg 1 ;;
        esac
        ;;
  status)
        status_of_proc -p $PIDFILE "$DAEMON" "$NAME" && exit 0 || exit $?
        ;;
  restart|force-reload)
        log_daemon_msg "Restarting $DESC" "$NAME"
        do_stop
        case "$?" in
          0|1)
                do_start
                case "$?" in
                        0) log_end_msg 0 ;;
                        1) log_end_msg 1 ;; # Old process is still running
                        *) log_end_msg 1 ;; # Failed to start
                esac
                ;;
          *)
                # Failed to stop
                log_end_msg 1
                ;;
        esac
        ;;
  *)
        echo "Usage: $SCRIPTNAME {start|stop|status|restart|force-reload}" >&2
        exit 3
        ;;
esac
