# This file is part of the Stomper project.
#
# Licensed under the BSD 3-Clause License (the "License"); a copy of the License
# is included with this project. You may also obtain a copy of the License at:
#
#     https://opensource.org/licenses/BSD-3-Clause
#
# Additional licenses for third-party dependencies are also included
# and must be reviewed separately.

option(STOMPER_DEBUG_ASAN "Enable Address Sanitizer (ASan)" OFF)
option(STOMPER_DEBUG_TSAN "Enable Thread Sanitizer (TSan)" OFF)
option(STOMPER_DEBUG_MSAN "Enable Memory Sanitizer (MSan)" OFF)
option(STOMPER_DEBUG_UBSAN "Enable Undefined Behavior Sanitizer (UBSan)" OFF)
option(STOMPER_DEBUG_VALGRIND "Enable Valgrind" OFF)

# Configure ASan Function
function(project_configure_asan)
    if(STOMPER_DEBUG_TSAN OR STOMPER_DEBUG_MSAN OR STOMPER_DEBUG_UBSAN)
        message(FATAL_ERROR "Cannot use Address Sanitizer with (Memory, Thread, Undefined Behavior) Sanitizer")
    endif()

    set(STOMPER_ASAN_FLAGS "-fsanitize=address -fno-omit-frame-pointer")
    set(STOMPER_ASAN_LINKER_FLAGS "-fsanitize=address")

    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} ${STOMPER_ASAN_FLAGS}" PARENT_SCOPE)
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} ${STOMPER_ASAN_FLAGS}" PARENT_SCOPE)
    set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} ${STOMPER_ASAN_LINKER_FLAGS}" PARENT_SCOPE)

    message(STATUS "Address Sanitizer (ASan) enabled")
endfunction()

# Configure TSan Function
function(project_configure_tsan)
    if(STOMPER_DEBUG_TSAN OR STOMPER_DEBUG_ASAN OR STOMPER_DEBUG_UBSAN)
        message(FATAL_ERROR "Cannot use Thread Sanitizer with (Memory, Address, Undefined Behavior) Sanitizer")
    endif()

    set(STOMPER_TSAN_FLAGS "-fsanitize=thread -fno-omit-frame-pointer")
    set(STOMPER_TSAN_LINKER_FLAGS "-fsanitize=thread")

    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} ${STOMPER_TSAN_FLAGS}" PARENT_SCOPE)
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} ${STOMPER_TSAN_FLAGS}" PARENT_SCOPE)
    set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} ${STOMPER_TSAN_LINKER_FLAGS}" PARENT_SCOPE)

    message(STATUS "Thread Sanitizer (TSan) enabled")
endfunction()

# Configure MSan Function
function(project_configure_msan)
    if(STOMPER_DEBUG_ASAN OR STOMPER_DEBUG_TSAN OR STOMPER_DEBUG_UBSAN)
        message(FATAL_ERROR "Cannot use Memory Sanitizer with (Thread, Address, Undefined Behavior) Sanitizer")
    endif()

    set(STOMPER_MSAN_FLAGS "-fsanitize=memory -fsanitize-memory-track-origins=2 -fno-omit-frame-pointer")
    set(STOMPER_MSAN_LINKER_FLAGS "-fsanitize=memory")

    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} ${STOMPER_MSAN_FLAGS}" PARENT_SCOPE)
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} ${STOMPER_MSAN_FLAGS}" PARENT_SCOPE)
    set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} ${STOMPER_MSAN_LINKER_FLAGS}" PARENT_SCOPE)

    message(STATUS "Memory Sanitizer (MSan) enabled")
endfunction()

# Configure UBSan Function
function(project_configure_ubsan)
    if(STOMPER_DEBUG_ASAN OR STOMPER_DEBUG_TSAN OR STOMPER_DEBUG_MSAN)
        message(FATAL_ERROR "Cannot use Undefined Behavior Sanitizer with (Thread, Address, Memory) Sanitizer")
    endif()

    set(STOMPER_UBSAN_FLAGS "-fsanitize=undefined -fno-omit-frame-pointer")
    set(STOMPER_UBSAN_LINKER_FLAGS "-fsanitize=undefined")

    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} ${STOMPER_UBSAN_FLAGS}" PARENT_SCOPE)
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} ${STOMPER_UBSAN_FLAGS}" PARENT_SCOPE)
    set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} ${STOMPER_UBSAN_LINKER_FLAGS}" PARENT_SCOPE)

    message(STATUS "Undefined Behavior Sanitizer (UBSan) enabled")
endfunction()

# Configure Valgrind Function
function(project_configure_valgrind)
    set(VALGRIND_FLAGS "-fno-inline -fno-omit-frame-pointer")

    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} ${VALGRIND_FLAGS}" PARENT_SCOPE)
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} ${VALGRIND_FLAGS}" PARENT_SCOPE)

    # Disable optimizations to allow valgrind to scan more properly.
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fno-builtin" PARENT_SCOPE)
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -fno-builtin" PARENT_SCOPE)

    message(STATUS "Valgrind Checks Configs enabled")
endfunction()


# Include sanitizers in the build if the profile is debug and is selected.
# Some sanitizers are not compatible with each other, so it is best to generate a separate binary for each.
if(CMAKE_BUILD_TYPE MATCHES "Debug")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g -O0")
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g -O0")

    if(STOMPER_DEBUG_ASAN)
        project_configure_asan()
    endif()

    if(STOMPER_DEBUG_TSAN)
        project_configure_tsan()
    endif()

    if(STOMPER_DEBUG_MSAN)
        project_configure_msan()
    endif()

    if(STOMPER_DEBUG_UBSAN)
        project_configure_ubsan()
    endif()

    if(STOMPER_DEBUG_VALGRIND)
        project_configure_valgrind()
    endif()
else()
    message(STATUS "Build type is not Debug (current: ${CMAKE_BUILD_TYPE}). Sanitizers and Valgrind configurations will not be applied.")
endif()