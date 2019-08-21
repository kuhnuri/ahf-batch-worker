FROM golang:1.12.7 AS builder
WORKDIR $GOPATH/src/github.com/kuhnuri/batch-ahf
RUN go get -v -u github.com/kuhnuri/go-worker
COPY docker/main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -o main .

FROM antennahouse/ahfcmd:6
#RUN apk --update --upgrade add bash cairo pango gdk-pixbuf py3-cffi py3-pillow py-lxml font-noto ca-certificates \
#    && pip3 install ahf \
#    && rm -rf /var/cache/apk/*
WORKDIR /opt/app
COPY --from=builder /go/src/github.com/kuhnuri/batch-ahf/main .
COPY AHFormatter.lic /AHFormatter/etc/AHFormatter.lic
ENTRYPOINT ["./main"]
