# This file is part of the Stomper project.
#
# Licensed under the BSD 3-Clause License (the "License"); a copy of the License
# is included with this project. You may also obtain a copy of the License at:
#
#     https://opensource.org/licenses/BSD-3-Clause
#
# Additional licenses for third-party dependencies are also included
# and must be reviewed separately.

if(CMAKE_BUILD_TYPE MATCHES "Release")
    set(RELEASE_FLAGS "-O3 -DNDEBUG -flto -ffunction-sections -fdata-sections -fno-omit-frame-pointer")

    set(CMAKE_CXX_FLAGS_RELEASE ${CMAKE_CXX_FLAGS_RELEASE} ${RELEASE_FLAGS})
    set(CMAKE_C_FLAGS_RELEASE ${CMAKE_C_FLAGS_RELEASE} ${RELEASE_FLAGS})

    set(CMAKE_EXE_LINKER_FLAGS_RELEASE "${CMAKE_EXE_LINKER_FLAGS_RELEASE} -Wl,--gc-sections -Wl,--export-dynamic -Wl,--strip-debug")

    message(STATUS "Release optimization enabled")
endif()