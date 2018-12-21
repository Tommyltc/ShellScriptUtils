#!/bin/sh
# echo Print logcat start
# deviceName=$(adb devices)
# for name in $deviceName; do
# 	if [ $name != "List" ] && [ $name != 'of' ] && [ $name != "devices" ] && [ $name != "attached" ] && [ $name != "device" ]; then
# 		if [ -f "$name.log" ]; then
# 			ts=$(date +"%s")
# 			mv "$name.log" "$name-$ts.log"
# 		fi
# 		adb -s $name logcat -d > "$name.log"
#   		echo "Log created $name"
# 	fi
# done
# echo Print logcat end

# adb -s $name logcat -c
while [ "$#" -gt "0" ]
do
  case $1 in
  	-s)
		echo Print logcat start
		deviceName=$(adb devices)
		for name in $deviceName; do
			if [ $name != "List" ] && [ $name != 'of' ] && [ $name != "devices" ] && [ $name != "attached" ] && [ $name != "device" ]; then
				if [ -f "$name.log" ]; then
					ts=$(date +"%Y%m%d%H%M%S")
					mv "$name.log" "$name-$ts.log"
					echo "move $name.log $name-$ts.log"
				fi
				adb -s $name logcat -d > "$name.log"
		  		echo "Log created $name"
			fi
		done
		echo Print logcat end;;
	-c)
		echo Clean logcat start
		deviceName=$(adb devices)
		for name in $deviceName; do
			if [ $name != "List" ] && [ $name != 'of' ] && [ $name != "devices" ] && [ $name != "attached" ] && [ $name != "device" ]; then
				adb -s $name logcat -c
		  		echo "Log clean $name"
			fi
		done
		;;
	esac
  shift
done
