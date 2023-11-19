BIN_FILE_NAME := ./bin/bootstrap

GO_BUILD_ENV := GOOS=linux GOARCH=amd64 CGO_ENABLED=0 

.PHONY: build
build:
	${GO_BUILD_ENV} go build -o ${BIN_FILE_NAME}

.PHONY: build-MyFunction
build-MyFunction: build
	cp ./${BIN_FILE_NAME} $(ARTIFACTS_DIR)/.
