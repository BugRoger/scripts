#!/bin/bash

set -o errexit  # abort after the first command that fails

./build_packages
./build_image --group=stable prod
./image_to_vm.sh --from=../build/images/amd64-usr/stable-latest --board=amd64-usr --prod_image --format=sap_monsoon
chmod 0600 upload.key
cd ../build/images/amd64-usr/stable-latest
bzip2 coreos_production_sap_monsoon_image.bin
scp -i ../../../../scripts/oem/sap/upload.key coreos_production_sap_monsoon_image.bin.bz2 upload@moo-repo.wdf.sap.corp:/monsoon/repo/static/monsoon/coreos/stable/amd64-usr/current/coreos_production_sap_monsoon_image.bin.bz2
