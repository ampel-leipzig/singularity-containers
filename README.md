# Singularity Containers

## Local Install

```sh
apt install singularity-container siftool
```

## Build

```sh
# needed for user build
# sudo echo 1 > /proc/sys/kernel/unprivileged_userns_clone
SINGULARITY_TMPDIR=$(pwd) singularity --debug build --fakeroot r-ver-362-pandoc-ampel.sif r-ver-362-pandoc-ampel.def

# or
sudo SINGULARITY_TMPDIR=$(pwd) singularity --debug build --force r-ver-362-pandoc-ampel.sif r-ver-362-pandoc-ampel.def

# or
make
```

## Run

```sh
## run R
singularity exec r-ver-362-pandoc-ampel.sif

## shell access
singularity shell r-ver-362-pandoc-ampel.sif
```
