#!/bin/bash

set -e

export http_proxy=http://proxy.wdf.sap.corp:8080
export https_proxy=http://proxy.wdf.sap.corp:8080

BOARD="amd64-usr"
GROUP="alpha"
FORM="prod"
FORMAT="monsoon"

../../build_packages
../../build_image --board=$BOARD --group=$GROUP $FORM
../../image_to_vm.sh --board=$BOARD --prod_image --format=$FORMAT

scp coreos_production_monsoon_image.bin.bz2 upload@moo-repo.wdf.sap.corp:/monsoon/repo/static/monsoon/coreos/alpha/amd64-usr/current/coreos_production_monsoon_image.bin.bz2
