FROM golang:alpine AS build-env
RUN  apk add --no-cache git make
LABEL maintaner="@amimof (amir.mofasser@gmail.com)"
COPY . /go/src/github.com/amimof/robberlang
WORKDIR /go/src/github.com/amimof/robberlang
RUN make linux

FROM scratch
COPY --from=build-env /go/src/github.com/amimof/robberlang/bin/robberlang-linux-amd64 /go/bin/robberlang
ENTRYPOINT ["/go/bin/robberlang"]