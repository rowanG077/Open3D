# TBB build scripts.
#
# - STATIC_TBB_INCLUDE_DIR
# - STATIC_TBB_LIB_DIR
# - STATIC_TBB_LIBRARIES
#
# Notes:
# The name "STATIC" is used to avoid naming collisions for other 3rdparty CMake
# files (e.g. PyTorch) that also depends on MKL.

include(ExternalProject)

# Where MKL and TBB headers and libs will be installed.
# This needs to be consistent with mkl.cmake.
set(MKL_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/mkl_install)
set(STATIC_MKL_INCLUDE_DIR "${MKL_INSTALL_PREFIX}/include/")
set(STATIC_MKL_LIB_DIR "${MKL_INSTALL_PREFIX}/lib")

# TBB variables exported for PyTorch Ops and TensorFlow Ops
set(STATIC_TBB_INCLUDE_DIR "${STATIC_MKL_INCLUDE_DIR}")
set(STATIC_TBB_LIB_DIR "${STATIC_MKL_LIB_DIR}")
set(STATIC_TBB_LIBRARIES tbb_static tbbmalloc_static)

set_local_or_remote_url(
    TBB_GIT_URL
    LOCAL_URL   "${THIRD_PARTY_DOWNLOAD_DIR}/tbb"
    REMOTE_URLS "https://anaconda.org/intel/mkl-include/2020.1/download/linux-64/mkl-include-2020.1-intel_217.tar.bz2"
)

# To generate a new patch, go inside TBB source folder:
# 1. Checkout to a new branch
# 2. Make changes, commit
# 3. git format-patch master
# 4. Copy the new patch file back to Open3d.
ExternalProject_Add(
    ext_tbb
    PREFIX tbb
    URL ${TBB_GIT_URL}
    UPDATE_COMMAND ""
    COMMAND git apply ${Open3D_3RDPARTY_DIR}/mkl/0001-Allow-selecttion-of-static-dynamic-MSVC-runtime.patch
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${MKL_INSTALL_PREFIX}
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        -DSTATIC_WINDOWS_RUNTIME=${STATIC_WINDOWS_RUNTIME}
        -DTBB_BUILD_TBBMALLOC=ON
        -DTBB_BUILD_TBBMALLOC_PROXYC=OFF
        -DTBB_BUILD_SHARED=OFF
        -DTBB_BUILD_STATIC=ON
        -DTBB_BUILD_TESTS=OFF
        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
)
