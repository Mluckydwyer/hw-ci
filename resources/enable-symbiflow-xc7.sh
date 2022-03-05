#!/bin/sh

if [[ -z "${DEPLOY_ENV}" ]]; then
    echo "SYMBIFLOW_INSTALL_DIR is not defined, this is only for hw-ci:full containers with Symbiflow environments installed"
else
    export FPGA_FAM=xc7
    conda activate ${FPGA_FAM}
fi


