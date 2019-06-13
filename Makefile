BINARY=robberlang
GOARCH=amd64
VERSION=1.0.0
COMMIT=$(shell git rev-parse HEAD)
BRANCH=$(shell git rev-parse --abbrev-ref HEAD)
GOVERSION=$(shell go version | awk -F\go '{print $$3}' | awk '{print $$1}')
GITHUB_USERNAME=amimof
BUILD_DIR=${GOPATH}/src/github.com/${GITHUB_USERNAME}/${BINARY}
PKG_LIST=$$(go list ./... | grep -v /vendor/)
# Setup the -ldflags option for go build here, interpolate the variable values
LDFLAGS = -ldflags "-X main.VERSION=${VERSION} -X main.COMMIT=${COMMIT} -X main.BRANCH=${BRANCH} -X main.GOVERSION=${GOVERSION}"

# Build the project
all: build

dep:
	go get -v -d ./cmd/... ;

test:
	cd ${BUILD_DIR}; \
	go test ${PKG_LIST} ; \
	cd - >/dev/null

fmt:
	cd ${BUILD_DIR}; \
	go fmt ${PKG_LIST} ; \
	cd - >/dev/null

vet:
	cd ${BUILD_DIR}; \
	go vet ${PKG_LIST}; \

gocyclo:
	go get -u github.com/fzipp/gocyclo; \
	cd ${BUILD_DIR}; \
	${GOPATH}/bin/gocyclo .; \

golint:
	go get -u golang.org/x/lint/golint; \
	cd ${BUILD_DIR}; \
	${GOPATH}/bin/golint -set_exit_status ${PKG_LIST}; \

ineffassign:
	go get github.com/gordonklaus/ineffassign; \
	cd ${BUILD_DIR}; \
	${GOPATH}/bin/ineffassign .; \

misspell:
	go get -u github.com/client9/misspell/cmd/misspell; \
	cd ${BUILD_DIR}; \
	find . -type f -not -path "./vendor/*" -not -path "./.git/*" -print0 | xargs -0 ${GOPATH}/bin/misspell; \

checkfmt:
	cd ${BUILD_DIR}
	if [ "`gofmt -l .`" != "" ]; then \
		echo "Code not formatted, please run 'make fmt'"; \
		exit 1; \
	fi

ci: fmt vet gocyclo golint ineffassign misspell 

linux: dep
	CGO_ENABLED=0 GOOS=linux GOARCH=${GOARCH} go build ${LDFLAGS} -o ${BUILD_DIR}/bin/${BINARY}-linux-${GOARCH} cmd/main.go

rpi: dep
	CGO_ENABLED=0 GOOS=linux GOARCH=arm go build ${LDFLAGS} -o ${BUILD_DIR}/bin/${BINARY}-linux-arm cmd/main.go

darwin: dep
	CGO_ENABLED=0 GOOS=darwin GOARCH=${GOARCH} go build ${LDFLAGS} -o ${BUILD_DIR}/bin/${BINARY}-darwin-${GOARCH} cmd/main.go

windows: dep
	CGO_ENABLED=0 GOOS=windows GOARCH=${GOARCH} go build ${LDFLAGS} -o ${BUILD_DIR}/bin/${BINARY}-windows-${GOARCH}.exe cmd/main.go

docker:
	docker run --rm -v "${PWD}":/go/src/github.com/amimof/robberlang -w /go/src/github.com/amimof/robberlang golang:${GOVERSION} make fmt test
	docker build -t amimof/robberlang:${VERSION} .

build: linux darwin rpi windows

clean:
	-rm -rf ${BUILD_DIR}/bin/

.PHONY: linux darwin windows test fmt clean