#!/bin/bash
if synclient -l | egrep -i -q 'touchpadoff\s*=\s*0$' ; then
	synclient TouchpadOff=1
else
	synclient TouchpadOff=0
fi
