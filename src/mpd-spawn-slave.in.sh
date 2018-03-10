#!/bin/bash -e
appname=${0##*/}


CONFDIR=${XDG_CONFIG_HOME:-$HOME/.config}/mpd
baseconfig=$CONFDIR/mpd-slave.conf
CONFDIR_SLAVES=$CONFDIR/slaves
cachedir=${XDG_CACHE_HOME:-$HOME/.cache}/mpd/
cachedir_slaves=$cachedir/slaves


error()
{
    echo "$@" >&2
}

case $1 in
    create-instance)
        create_instance=y
        shift
        ;;
    start-instance)
        shift
        ;;
esac
optspec=v # b:dp #-: # short options
optspec_long=base-config:,http-port:,mpd-port:,instance-name:
PROCESSED_OPTSPEC=$( getopt -qo $optspec --long $optspec_long \
		            -n $appname -- "$@" ) || __error error "Wrong option or no parameter for option given!" ||  exit 1
eval set -- "$PROCESSED_OPTSPEC";

http_port=
mpd_port=




while [ !  $#  =  0  ]  ; do
    echo $1
    case $1 in
        --base-config) baseconfig=$2; shift 2;;
        --http-port) http_port=$2; shift 2;;
        --mpd-port) mpd_port=$2; shift 2;;
        --instance-name) instance_name=$2; shift 2;;
        --) shift ; break;;
    esac
done


if [ ! $instance_name ] ; then
   instance_name=$http_port
fi



mkdir -p $CONFDIR/spawn/ports/stream
mkdir -p $CONFDIR/spawn/ports/mpd

mkdir -p $CONFDIR_SLAVES
mkdir -p $cachedir_slaves

create_instance()
{
    if [ -e $CONFDIR_SLAVES/slaves/$instance_name ] ; then
        error "instance already exists"
        exit 1
    fi
    
    if [ -e $CONFDIR/spawn/ports/stream/$http_port ] ; then
        error "instance whith port $http_port already exists"
        exit 1
    fi
    
    if [ -e $CONFDIR/spawn/ports/mpd/$mpd_port ] ; then
        error "instance whith port $mpd_port already exists"
        exit
    fi

    touch $CONFDIR/spawn/ports/mpd/$mpd_port
    touch $CONFDIR/spawn/ports/stream/$http_port
    
    mkdir $CONFDIR_SLAVES/$instance_name
    cp $baseconfig $CONFDIR_SLAVES/$instance_name/$instance_name.conf
    
    cat >> $CONFDIR_SLAVES/$instance_name/$instance_name.conf<<EOF
pid_file "$cachedir_slaves/$instance_name/pid"
state_file "$cachedir_slaves/$instance_name/state"
log_file "$cachedir_slaves/$instance_name/log"
port "$mpd_port"
EOF

    sed -e "s|@stream_port@|$http_port|" -i \
        $CONFDIR_SLAVES/$instance_name/$instance_name.conf

    mkdir -p $cachedir_slaves/$instance_name
}

if [ ! -e $CONFDIR_SLAVES/$instance_name ] ; then
    create_instance
fi
if [ ! $create_instance ] ; then
    exec mpd --no-daemon $CONFDIR_SLAVES/$instance_name/$instance_name.conf
fi
