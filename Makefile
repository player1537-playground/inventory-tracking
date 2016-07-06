MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

ifndef SERVER
SERVER := python3 -m http.server 8888
endif

all: index.html

.PHONY: server
server:
	$(SERVER)

.PHONY: watcher
watcher:
	while true; do ls -d src/*[^~] | entr -d make index.html; done

index.html: $(wildcard src/*[^~])
	cat $^ > $@
