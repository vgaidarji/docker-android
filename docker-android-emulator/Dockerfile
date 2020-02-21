FROM vgaidarji/docker-android-build:v1.0.2

##################
# Install emulator images
##################
RUN sdkmanager "system-images;android-21;google_apis;armeabi-v7a"

RUN sdkmanager "emulator"
RUN yes | sdkmanager \
	"build-tools;24.0.3" \
	"build-tools;25.0.2"
RUN yes | sdkmanager \
    "extras;android;m2repository" \
    "extras;google;m2repository" \
    "extras;google;google_play_services" 

RUN yes | sdkmanager "platforms;android-21" \
    "platforms;android-22" \
    "platforms;android-25"

##################
# Set mandatory environment variables
##################
ENV ANDROID_EMULATOR_FORCE_32BIT=true
#ENV ANDROID_SDK_HOME=/root/.android/ 

COPY ui-tests-on-emulator.sh /usr/bin/ui-tests-on-emulator
COPY run-ui-tests.sh /usr/bin/run-ui-tests
COPY kill-running-emulators.sh /usr/bin/kill-running-emulators
COPY wait-for-emulator.sh /usr/bin/wait-for-emulator
COPY unlock-emulator-screen.sh /usr/bin/unlock-emulator-screen
COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["ui-tests-on-emulator"]
