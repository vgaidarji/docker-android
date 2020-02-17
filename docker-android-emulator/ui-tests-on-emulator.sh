#!/usr/bin/env bash

set -eu

# start android emulator
START=`date +%s` > /dev/null

# AVD name that will be used to start the image
AVD_NAME="android-29"

# AVD image identifier, use "sdkmanager --list" to check all available
ANDROID_IMAGE="system-images;$AVD_NAME;google_apis;x86_64"

# install avd image, in case it's missing
echo no | $ANDROID_HOME/tools/bin/sdkmanager --install "$ANDROID_IMAGE"

# create AVD
echo no | $ANDROID_HOME/tools/android create avd -f -n "$AVD_NAME" -k "$ANDROID_IMAGE"
$ANDROID_HOME/tools/android list avd

# start emulator
$ANDROID_HOME/tools/emulator -avd $AVD_NAME -no-window -no-boot-anim -no-audio -verbose &

wait-for-emulator
unlock-emulator-screen

DURATION=$(( `date +%s` - START )) > /dev/null
echo "Android Emulator started after $DURATION seconds."

# emulator isn't ready yet, wait 1 min more
# prevents APK installation error
sleep 60

run-ui-tests

kill-running-emulators
