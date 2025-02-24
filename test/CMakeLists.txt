# This file is part of the Stomper project.
#
# Licensed under the BSD 3-Clause License (the "License"); a copy of the License
# is included with this project. You may also obtain a copy of the License at:
#
#     https://opensource.org/licenses/BSD-3-Clause
#
# Additional licenses for third-party dependencies are also included
# and must be reviewed separately.

set(TEST_TARGET_NAME "${PROJECT_NAME}-tests")

add_executable(${TEST_TARGET_NAME} ${STOMPER_TEST_SOURCES} ${STOMPER_SOURCES})

target_include_directories(${TEST_TARGET_NAME} PRIVATE ${STOMPER_INCLUDE} ${STOMPER_TMP_INCLUDE} ${STOMPER_SDK_INCLUDE})
target_link_libraries(${TEST_TARGET_NAME} PRIVATE Catch2::Catch2WithMain)