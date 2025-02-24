# This file is part of the Stomper project.
#
# Licensed under the BSD 3-Clause License (the "License"); a copy of the License
# is included with this project. You may also obtain a copy of the License at:
#
#     https://opensource.org/licenses/BSD-3-Clause
#
# Additional licenses for third-party dependencies are also included
# and must be reviewed separately.

# Verify that the project is compatible with the compiler
if(NOT (CMAKE_CXX_COMPILER_ID STREQUAL "Clang" AND CMAKE_C_COMPILER_ID STREQUAL "Clang"))
    message(FATAL_ERROR
            "This project requires the Clang compiler. Detected compiler: C:${CMAKE_C_COMPILER_ID}/C++:${CMAKE_CXX_COMPILER_ID}. "
            "Please switch to Clang and try again."
    )
endif()

if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS 18.0 OR CMAKE_C_COMPILER_VERSION VERSION_LESS 18.0)
    message(FATAL_ERROR
            "Clang version 18.0 or higher is required. Detected version: C:${CMAKE_C_COMPILER_VERSION}/C++:${CMAKE_CXX_COMPILER_VERSION}. "
            "Please update your Clang compiler and try again."
    )
endif()

# Set up tools and project outputs
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${STOMPER_RESOURCES_OUT})

# Set up the header file with the info variables in the compilation
configure_file("${STOMPER_INCLUDE}/StomperInfo.h.in" "${STOMPER_TMP_INCLUDE}/StomperInfo.h")