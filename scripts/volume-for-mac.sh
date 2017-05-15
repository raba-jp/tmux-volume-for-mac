#!/usr/bin/env bash

is_mac_os() {
	[ $(uname) = 'Darwin' ] && echo 'true' || echo 'false'
}

get_volume_info() {
	echo "$(osascript -e 'get volume settings')"
}

get_volume_value() {
	local info=`get_volume_info`
	local volume=$(expr $(echo "${info}" | awk '{print $2}' | sed "s/[^0-9]//g") / 6 )
	local str=""
	for ((i=0; i < ${volume}; i++)); do
		str="${str}■"
	done
	for ((i=${volume}; i <= 16; i++)); do
		str="${str} "
	done
	echo "#[bold][${str}]#[default]"
}

is_muted() {
	local info=`get_volume_info`
	[ $(echo ${info} | awk '{print $8}') = "muted:true" ] && echo 'true' || echo 'false'
}

get_volume() {
	local muted_string="#[bold][      mute      ]#[default] "
	local volume_string=`get_volume_value`
	[ `is_mac_os` = 'false' ] && return 0
#
	[ `is_muted` = 'true' ] && echo ${muted_string} || echo ${volume_string}
}
get_volume
