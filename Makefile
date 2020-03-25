DEFS := $(wildcard *.def)
SIFS := $(DEFS:.def=.sif)
CDIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

.PHONEY: clean

all: $(SIFS)

build:
	mkdir build

%.sif: %.def build
	sudo SINGULARITY_CACHEDIR="$(CDIR)/build" SINGULARITY_TMPDIR="$(CDIR)/build" singularity --debug build --force $@ $<

clean:
	rm -rf build/
