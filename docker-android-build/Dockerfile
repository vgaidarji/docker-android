FROM phusion/baseimage:0.11

LABEL maintainer="Veaceslav Gaidarji <veaceslav.gaidarji@gmail.com>"

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    ANDROID_HOME=/opt/android-sdk \
    PATH="$PATH:/usr/lib/jvm/java-8-openjdk-amd64/bin:/opt/android-sdk/tools:/opt/android-sdk/tools/bin:/opt/android-sdk/platform-tools"

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends wget lib32stdc++6 libqt5widgets5 lib32z1 unzip
RUN apt-get install -y awscli
RUN apt-get install -y expect

###################
# JDK8
###################
RUN apt-get install -y openjdk-8-jdk && \
    apt-get clean
RUN java -version

###################
# Android SDK
###################
RUN mkdir /opt/android-sdk/
RUN wget -O android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip -q android-sdk.zip -d ${ANDROID_HOME}
RUN rm android-sdk.zip

RUN sdkmanager "emulator" "tools" "platform-tools"
RUN yes | sdkmanager \
	"build-tools;25.0.2" \
	"build-tools;24.0.3"
RUN yes | sdkmanager \
    "extras;android;m2repository" \
    "extras;google;m2repository" \
    "extras;google;google_play_services" 

RUN yes | sdkmanager \
    "platforms;android-25" \
    "platforms;android-22" \
    "platforms;android-21" \
    "platforms;android-15"

##################
# Android licenses
##################
RUN yes | sdkmanager --licenses

##################
# Speeding up android builds
# Gradle will pick these properties when running
##################
RUN mkdir ~/.gradle
RUN echo "org.gradle.daemon=true" >> ~/.gradle/gradle.properties
RUN echo "org.gradle.jvmargs=-Xmx4096m -XX:MaxPermSize=512m -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8" >> ~/.gradle/gradle.properties
RUN echo "org.gradle.parallel=true" >> ~/.gradle/gradle.properties
RUN echo "org.gradle.configureondemand=true" >> ~/.gradle/gradle.properties
RUN echo "android.builder.sdkDownload=true" >> ~/.gradle/gradle.properties
RUN rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
