# This file is part of the Stomper project.
#
# Licensed under the BSD 3-Clause License (the "License"); a copy of the License
# is included with this project. You may also obtain a copy of the License at:
#
#     https://opensource.org/licenses/BSD-3-Clause
#
# Additional licenses for third-party dependencies are also included
# and must be reviewed separately.

cmake_minimum_required(VERSION 3.30)

project(Stomper VERSION "1.0.0" LANGUAGES C CXX)

set(CMAKE_C_STANDARD 17)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

include(ProjectVariables)
include(ProjectEnvironment)
include(ProjectDependencies)
include(ProjectDebugProfile)
include(ProjectReleaseProfile)

add_executable(Stomper ${STOMPER_LAUNCHER_SOURCE})

target_sources(${PROJECT_NAME}
        PRIVATE ${STOMPER_SOURCES})

target_include_directories(${PROJECT_NAME}
        PRIVATE ${STOMPER_INCLUDE} ${STOMPER_TMP_INCLUDE}
        PUBLIC ${STOMPER_SDK_INCLUDE})

target_link_libraries(${PROJECT_NAME}
        PRIVATE backward)

add_subdirectory(${STOMPER_TEST_DIR})
add_backward(${PROJECT_NAME})
