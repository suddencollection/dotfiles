#/usr/bin/env bash

if [[ `pgrep glava` == '' ]]; then 
	glava --desktop --entry='custom/top_rc.glsl' 1>/dev/null &
	glava --desktop --entry='custom/bottom_rc.glsl' 1>/dev/null &
fi
