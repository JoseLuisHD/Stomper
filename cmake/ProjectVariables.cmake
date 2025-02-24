# This file is part of the Stomper project.
#
# Licensed under the BSD 3-Clause License (the "License"); a copy of the License
# is included with this project. You may also obtain a copy of the License at:
#
#     https://opensource.org/licenses/BSD-3-Clause
#
# Additional licenses for third-party dependencies are also included
# and must be reviewed separately.

# In-Project Variables
set(STOMPER_VERSION ${PROJECT_VERSION})
set(STOMPER_SYSTEM_NAME ${CMAKE_SYSTEM_NAME})
set(STOMPER_SYSTEM_ARCH ${CMAKE_SYSTEM_PROCESSOR})
set(STOMPER_BUILD_TYPE ${CMAKE_BUILD_TYPE})
string(TIMESTAMP STOMPER_BUILD_DATE "%d %b %y")

# Main Variables
set(STOMPER_INCLUDE "${CMAKE_SOURCE_DIR}/include")
set(STOMPER_TMP_INCLUDE "${CMAKE_BINARY_DIR}/tmp-include")
set(STOMPER_SDK_INCLUDE "${CMAKE_SOURCE_DIR}/sdk")

set(STOMPER_RESOURCES_IN "${CMAKE_SOURCE_DIR}/resources")
set(STOMPER_RESOURCES_OUT "${CMAKE_BINARY_DIR}/bin")

set(STOMPER_TEST_DIR "${CMAKE_SOURCE_DIR}/test")

# Sources
set(STOMPER_LAUNCHER_SOURCE "${CMAKE_SOURCE_DIR}/launcher/StomperLauncher.cpp")
file(GLOB_RECURSE STOMPER_SOURCES "${CMAKE_SOURCE_DIR}/src/*.cpp")
file(GLOB_RECURSE STOMPER_TEST_SOURCES "${CMAKE_SOURCE_DIR}/test/src/*.cpp")