FROM dart:stable AS build
WORKDIR /app
COPY pubspec.yaml analysis_options.yaml ./
RUN dart pub get
COPY bin ./bin
COPY lib ./lib
COPY test ./test
RUN dart format --set-exit-if-changed .
RUN dart analyze
RUN dart test
RUN dart compile exe bin/stakeholder.dart -o /tmp/stakeholder

FROM debian:bookworm-slim
WORKDIR /app
COPY --from=build /tmp/stakeholder /usr/local/bin/stakeholder
ENTRYPOINT ["/usr/local/bin/stakeholder"]
