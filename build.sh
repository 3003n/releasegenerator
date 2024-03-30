#!/bin/bash
id -u
whoami

sleep 20
if [[ "$1" =~ "dev" ]]; then
    POSTCOPY_CLONE=$(echo $1 | sed 's/.*dev/dev/g')
else
    POSTCOPY_CLONE=$1
fi

pacman-key --init 
pacman --noconfirm -Syu btrfs-progs archiso git reflector
git clone https://github.com/3003n/buildroot buildroot -b sk
git clone https://github.com/3003n/postcopy -b ${POSTCOPY_CLONE} buildroot/postcopy_$1 
# mkdir -p $(pwd)/output $(pwd)/workdir 
bash buildroot/build.sh --flavor $1 --deployment_rel $1 --snapshot_ver "${GITHUB_REF_NAME}" --workdir /holoiso/workdir --output-dir /holoiso/output/holoiso-images --add-release