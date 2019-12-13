FROM vgaidarji/docker-android-build:v1.0.1

##################
# Install emulator images
##################
RUN sdkmanager "system-images;android-21;google_apis;armeabi-v7a"

##################
# Set mandatory environment variables
##################
ENV ANDROID_EMULATOR_FORCE_32BIT=true
ENV ANDROID_SDK_HOME=/root/.android/ 

COPY ui-tests-on-emulator.sh /usr/bin/ui-tests-on-emulator
COPY run-ui-tests.sh /usr/bin/run-ui-tests
COPY kill-running-emulators.sh /usr/bin/kill-running-emulators
COPY wait-for-emulator.sh /usr/bin/wait-for-emulator
COPY unlock-emulator-screen.sh /usr/bin/unlock-emulator-screen
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["ui-tests-on-emulator"]
