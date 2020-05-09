FROM docker-android-build-local:latest

RUN yes | sdkmanager "build-tools;29.0.3"
RUN sdkmanager "platform-tools"
RUN yes | sdkmanager "platforms;android-29"

##################
# Install emulator images
##################

# v29.3.0.0
RUN curl -fo emulator.zip https://dl.google.com/android/repository/emulator-linux-6061023.zip
RUN rm -rf ${ANDROID_HOME}/emulator
RUN unzip -q emulator.zip -d ${ANDROID_HOME}
RUN rm -f emulator.zip

RUN sdkmanager "system-images;android-29;default;x86"

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
