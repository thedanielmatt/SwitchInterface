#!/bin/sh

##MODEL=`sysctl hw.model | awk {'print $2'}

MODEL=`sysctl hw.model|sed "s/.*[a-z]//"|sed "s/,.*//"`

echo ${MODEL}

if [ ${MODEL} -ge 11 ]

	then 

	function set_airport {

    new_status=$1

    if [ $new_status = "On" ]; then
	/usr/sbin/networksetup -setairportpower en0 on
	touch /var/tmp/prev_air_on
    else
	/usr/sbin/networksetup -setairportpower en0 off
	if [ -f "/var/tmp/prev_air_on" ]; then
	    rm /var/tmp/prev_air_on
	fi
    fi

}


# Set default values
prev_eth_status="Off"
prev_air_status="Off"

eth_status="Off"

# Determine previous ethernet status
# If file prev_eth_on exists, ethernet was active last time we checked
if [ -f "/var/tmp/prev_eth_on" ]; then
    prev_eth_status="On"
fi

# Determine same for AirPort status
# File is prev_air_on
if [ -f "/var/tmp/prev_air_on" ]; then
    prev_air_status="On"
fi

# Check actual current ethernet status
if [ "`ifconfig en3 2> /dev/null| grep \"status: active\"`" != "" ]; then
    eth_status="On"
fi

# And actual current AirPort status
air_status=`/usr/sbin/networksetup -getairportpower en0 | awk '{ print $4 }'`


# Determine whether ethernet status changed
if [ "$prev_eth_status" != "$eth_status" ]; then

    if [ "$eth_status" = "On" ]; then
	set_airport "Off"
#	growl "Wired network detected. Turning AirPort off."
    else
	set_airport "On"
#	growl "No wired network detected. Turning AirPort on."
    fi

# If ethernet did not change
else

    # Check whether AirPort status changed
    # If so it was done manually by user
    if [ "$prev_air_status" != "$air_status" ]; then
	set_airport $air_status

#	if [ "$air_status" = "On" ]; then
#	    growl "AirPort manually turned on."
#	else
#	    growl "AirPort manually turned off."
#	fi

    fi

fi

# Update ethernet status
if [ "$eth_status" == "On" ]; then
    touch /var/tmp/prev_eth_on
else
    if [ -f "/var/tmp/prev_eth_on" ]; then
	rm /var/tmp/prev_eth_on
    fi
fi


	else
	
	function set_airport {

    new_status=$1

    if [ $new_status = "On" ]; then
	/usr/sbin/networksetup -setairportpower en1 on
	touch /var/tmp/prev_air_on
    else
	/usr/sbin/networksetup -setairportpower en1 off
	if [ -f "/var/tmp/prev_air_on" ]; then
	    rm /var/tmp/prev_air_on
	fi
    fi

}


# Set default values
prev_eth_status="Off"
prev_air_status="Off"

eth_status="Off"

# Determine previous ethernet status
# If file prev_eth_on exists, ethernet was active last time we checked
if [ -f "/var/tmp/prev_eth_on" ]; then
    prev_eth_status="On"
fi

# Determine same for AirPort status
# File is prev_air_on
if [ -f "/var/tmp/prev_air_on" ]; then
    prev_air_status="On"
fi

# Check actual current ethernet status
if [ "`ifconfig en0 | grep \"status: active\"`" != "" ]; then
    eth_status="On"
fi

# And actual current AirPort status
air_status=`/usr/sbin/networksetup -getairportpower en1 | awk '{ print $4 }'`


# Determine whether ethernet status changed
if [ "$prev_eth_status" != "$eth_status" ]; then

    if [ "$eth_status" = "On" ]; then
	set_airport "Off"
#	growl "Wired network detected. Turning AirPort off."
    else
	set_airport "On"
#	growl "No wired network detected. Turning AirPort on."
    fi

# If ethernet did not change
else

    # Check whether AirPort status changed
    # If so it was done manually by user
    if [ "$prev_air_status" != "$air_status" ]; then
	set_airport $air_status

#	if [ "$air_status" = "On" ]; then
#	    growl "AirPort manually turned on."
#	else
#	    growl "AirPort manually turned off."
#	fi

    fi

fi

# Update ethernet status
if [ "$eth_status" == "On" ]; then
    touch /var/tmp/prev_eth_on
else
    if [ -f "/var/tmp/prev_eth_on" ]; then
	rm /var/tmp/prev_eth_on
    fi
fi

fi

exit 0
