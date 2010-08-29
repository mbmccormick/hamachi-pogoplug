#!/bin/sh

RETVAL=0

start()
{
    echo -n "Making the file system writable: "
    mount -o rw,remount /
    if [ $? ]; then
        echo "Success"
    else
        echo "Failure"
    fi

    echo -n "Creating lock directory: "
    mkdir /var/run/
    if [ $? ]; then
        echo "Success"
    else
        echo "Failure"
    fi

    echo -n "Configuring tun: "
    cd /sbin
    ./tuncfg
    if [ $? ]; then
        echo "Success"
    else
        echo "Failure"
    fi

    echo -n "Starting Hamachi: "
    /bin/su - root -c "hamachi start"
    if [ $? ]; then
        echo "Success"
    else
        echo "Failure"
    fi

    return $RETVAL
}

stop() {
    echo -n "Shutting down Hamachi: "
    /bin/su - root -c "hamachi stop"
    if [ $? ]; then
        echo "Success"
    else
        echo "Failure"
    fi

    return $RETVAL
}

restart() {
    stop
    start
}

#
# Usage statement.
#

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    *)
        echo "usage: $0 {start|stop|restart}"
        exit 1
        ;;
esac
