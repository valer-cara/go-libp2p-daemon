## Stage 1: Build
FROM golang:1.12 AS build

ENV GO111MODULE=on

WORKDIR $GOPATH/src/github.com/libp2p/go-libp2p-daemon

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go install ./...


## Stage 2: Production build
FROM debian:stable

COPY --from=0 /go/bin/p2pd /usr/bin/

ENTRYPOINT ["/usr/bin/p2pd"]

