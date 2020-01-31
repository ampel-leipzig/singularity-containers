# Singularity

## Local Install

```
apt install singularity-container siftool
```

## Build

```
# needed for user build
# sudo echo 1 > /proc/sys/kernel/unprivileged_userns_clone
SINGULARITY_TMPDIR=$(pwd) singularity --debug build --fakeroot r-base-362-ampel.sif r-base-362-ampel.def
```
