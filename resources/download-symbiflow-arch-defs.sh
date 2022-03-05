#!/bin/sh

if [[ -z "${DEPLOY_ENV}" ]]; then
    echo "SYMBIFLOW_INSTALL_DIR is not defined, this is only for hw-ci:full containers with Symbiflow environments installed"
else
    mkdir -p $SYMBIFLOW_INSTALL_DIR/{xc7,eos-s3}/install
    curl -sSL https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/535/20220128-000432/symbiflow-arch-defs-install-5fa5e715.tar.xz | tar -xJC ${SYMBIFLOW_INSTALL_DIR}/xc7/install
    curl -sSL https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/535/20220128-000432/symbiflow-arch-defs-xc7a50t_test-5fa5e715.tar.xz | tar -xJC ${SYMBIFLOW_INSTALL_DIR}/xc7/install
    curl -sSL https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/535/20220128-000432/symbiflow-arch-defs-xc7a100t_test-5fa5e715.tar.xz | tar -xJC ${SYMBIFLOW_INSTALL_DIR}/xc7/install
    curl -sSL https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/535/20220128-000432/symbiflow-arch-defs-xc7a200t_test-5fa5e715.tar.xz | tar -xJC ${SYMBIFLOW_INSTALL_DIR}/xc7/install
    curl -sSL https://storage.googleapis.com/symbiflow-arch-defs/artifacts/prod/foss-fpga-tools/symbiflow-arch-defs/continuous/install/535/20220128-000432/symbiflow-arch-defs-xc7z010_test-5fa5e715.tar.xz | tar -xJC ${SYMBIFLOW_INSTALL_DIR}/xc7/install
    curl -sSL https://storage.googleapis.com/symbiflow-arch-defs-install/quicklogic-arch-defs-63c3d8f9.tar.gz | tar -xzC ${SYMBIFLOW_INSTALL_DIR}/eos-s3/install
fi


