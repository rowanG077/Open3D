include(ExternalProject)

set(OPENBLAS_INSTALL_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/openblas)

if(LINUX_AARCH64)
    set(OPENBLAS_TARGET "ARMV8")
else()
    set(OPENBLAS_TARGET "NEHALEM")
endif()

set(OPENBLAS_INCLUDE_DIR "${OPENBLAS_INSTALL_PREFIX}/include/") # The "/"" is critical, see import_3rdparty_library.
set(OPENBLAS_LIB_DIR "${OPENBLAS_INSTALL_PREFIX}/lib")
set(OPENBLAS_LIBRARIES openblas)  # Extends to libopenblas.a automatically.

set_local_or_remote_url(
    OPENBLAS_GIT_URL
    LOCAL_URL   "${THIRD_PARTY_DOWNLOAD_DIR}/openblas"
    REMOTE_URLS "https://anaconda.org/intel/mkl-include/2020.1/download/linux-64/mkl-include-2020.1-intel_217.tar.bz2"
)

ExternalProject_Add(
    ext_openblas
    PREFIX openblas
    URL ${OPENBLAS_GIT_URL}
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ""
    BUILD_COMMAND $(MAKE) TARGET=${OPENBLAS_TARGET} NO_SHARED=1 LIBNAME=CUSTOM_LIB_NAME
    BUILD_IN_SOURCE True
    INSTALL_COMMAND $(MAKE) install PREFIX=${OPENBLAS_INSTALL_PREFIX} NO_SHARED=1 LIBNAME=CUSTOM_LIB_NAME
    COMMAND ${CMAKE_COMMAND} -E rename ${OPENBLAS_LIB_DIR}/CUSTOM_LIB_NAME ${OPENBLAS_LIB_DIR}/libopenblas.a
)

message(STATUS "OPENBLAS_INCLUDE_DIR: ${OPENBLAS_INCLUDE_DIR}")
message(STATUS "OPENBLAS_LIB_DIR ${OPENBLAS_LIB_DIR}")
message(STATUS "OPENBLAS_LIBRARIES: ${OPENBLAS_LIBRARIES}")
