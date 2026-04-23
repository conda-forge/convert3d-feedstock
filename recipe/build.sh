#!/usr/bin/env bash

set -ex

export CXXFLAGS="${CXXFLAGS} -I ${PREFIX}/include/eigen3"

# config
cmake ${CMAKE_ARGS} \
	-D CMAKE_BUILD_TYPE:STRING=Release \
    	-D CMAKE_INSTALL_PREFIX:STRING=${PREFIX} \
    	-D CONVERT3D_USE_ITK_REMOTE_MODULES:BOOL=OFF \
    	-G Ninja \
	-B build \
	-S ${SRC_DIR}

# build
cmake --build build --parallel ${CPU_COUNT}

# install
cmake --install build

# test
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" ]]; then
ctest --test-dir build --extra-verbose --output-on-failure
fi
