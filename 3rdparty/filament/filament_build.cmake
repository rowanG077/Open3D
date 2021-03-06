include(ExternalProject)

set(FILAMENT_ROOT "${CMAKE_BINARY_DIR}/filament-binaries")

set_local_or_remote_url(
    FILAMENT_GIT_URL
    LOCAL_URL   "${THIRD_PARTY_DOWNLOAD_DIR}/filament"
    REMOTE_URLS "https://anaconda.org/intel/mkl-include/2020.1/download/linux-64/mkl-include-2020.1-intel_217.tar.bz2"
)

ExternalProject_Add(
    ext_filament
    PREFIX filament
    URL ${FILAMENT_GIT_URL}
    UPDATE_COMMAND ""
    CMAKE_ARGS
        -DCMAKE_BUILD_TYPE=Release
        -DCCACHE_PROGRAM=OFF  # Enables ccache, "launch-cxx" is not working.
        -DFILAMENT_ENABLE_JAVA=OFF
        -DCMAKE_C_COMPILER=${FILAMENT_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${FILAMENT_CXX_COMPILER}
        -DCMAKE_CXX_FLAGS="-fno-builtin"  # Issue Open3D#1909, filament#2146
        -DCMAKE_INSTALL_PREFIX=${FILAMENT_ROOT}
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        -DUSE_STATIC_CRT=${STATIC_WINDOWS_RUNTIME}
        -DUSE_STATIC_LIBCXX=ON
        -DFILAMENT_SUPPORTS_VULKAN=OFF
        -DFILAMENT_SKIP_SAMPLES=ON
        -DFILAMENT_OPENGL_HANDLE_ARENA_SIZE_IN_MB=20 # to support many small entities
)

set(filament_LIBRARIES
    filameshio
    filament
    filamat_lite
    filamat
    filaflat
    filabridge
    geometry
    backend
    bluegl
    ibl
    image
    meshoptimizer
    smol-v
    utils
)
