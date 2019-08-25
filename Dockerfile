FROM golang:1.12.7 AS builder
WORKDIR $GOPATH/src/github.com/kuhnuri/batch-ahf
RUN go get -v -u github.com/kuhnuri/go-worker
COPY docker/main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -o main .

FROM antennahouse/ahfcmd:6
USER root
RUN apt-get -y update \
    && apt-get -y install --no-install-recommends fonts-noto \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*
USER ahf
WORKDIR /opt/app
COPY --from=builder /go/src/github.com/kuhnuri/batch-ahf/main .
ENTRYPOINT ["./main"]
