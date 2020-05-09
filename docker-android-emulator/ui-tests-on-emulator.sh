#!/usr/bin/env bash

set -eu

# start android emulator
START=`date +%s` > /dev/null

echo no | $ANDROID_HOME/tools/bin/avdmanager create avd --force -n test --abi default/x86 --package 'system-images;android-29;default;x86' 
$ANDROID_HOME/tools/android list avd
$ANDROID_HOME/emulator/emulator -avd test -accel off -gpu off -no-window -no-boot-anim -no-snapshot -no-audio -verbose &
wait-for-emulator
unlock-emulator-screen

DURATION=$(( `date +%s` - START )) > /dev/null
echo "Android Emulator started after $DURATION seconds."

# emulator isn't ready yet, wait 1 min more
# prevents APK installation error
sleep 60

run-ui-tests

kill-running-emulators
