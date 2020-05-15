# Client Build
# Build the app container
FROM debian:latest

WORKDIR /app
COPY . /app

# Flutter dependencies
RUN apt-get update 
RUN apt-get install -y curl git wget zip unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

# Flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set up Flutter
RUN /usr/local/flutter/bin/flutter doctor -v
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
ENV PATH="/usr/local/flutter/.pub-cache/bin:${PATH}"
ENV PATH="$HOME/.pub-cache/bin:${PATH}"

# Enable Flutter web and webserve
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web
RUN pub global activate webdev

RUN cd app


# Many thanks to Kevin Williams (https://kevinwilliams.dev/blog/building-a-flutter-web-container)