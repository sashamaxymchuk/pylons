SHELL := /bin/bash

all: install

install: go.sum
	GO111MODULE=on go install -tags "$(build_tags)" ./cmd/pylonsd
	GO111MODULE=on go install -tags "$(build_tags)" ./cmd/pylonscli

go.sum: go.mod
	GO111MODULE=on go mod verify

init_accounts:
	bash ./init_accounts.sh

int_tests:
	rm ./cmd/test/nonce.json || true
	go test -v ./cmd/test/

fixture_tests:
	rm ./cmd/fixtures_test/nonce.json || true
	go test -v ./cmd/fixtures_test/

unit_tests:
	go test -v ./x/...
