#!/usr/bin/env bash

set -eu

# run Android UI tests
./gradlew connectedAndroidTest
