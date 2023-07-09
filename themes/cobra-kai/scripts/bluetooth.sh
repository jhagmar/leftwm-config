#!/bin/sh
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]; then
	echo -e "%{F#7f7f7f} \Uf00b2 %{F-}"
else
	if [ $(echo info | bluetoothctl | grep 'DeviceSet (null) not available' | wc -c) -eq 0 ]; then
		echo -e "%{F#ffffff} \Uf00af %{F-}"
	else
		echo -e "%{F#7f7f7f} \Uf00af %{F-}"
	fi
fi
