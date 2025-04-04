# Introduction

This project illustrates how to use gRPC with Golang and Flutter.

## Installation

-   You need to install [protobuf](https://github.com/protocolbuffers/protobuf/releases/tag/v30.2)
    to your local machine first.

-   Go's protobuf:

```bash
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

-   Dart's protobuf:

```bash
dart pub global activate protoc_plugin

```

## Run

-   In order to run the project, you need to execute the command so that go is able to get all the
    dependencies.

```bash
go mod tidy
```

-   The same as Flutter.

```bash
flutter pub get
```
