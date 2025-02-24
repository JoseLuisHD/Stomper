#!/bin/bash

# This file is part of the Stomper project.
#
# Licensed under the BSD 3-Clause License (the "License"); a copy of the License
# is included with this project. You may also obtain a copy of the License at:
#
#     https://opensource.org/licenses/BSD-3-Clause
#
# Additional licenses for third-party dependencies are also included
# and must be reviewed separately.

log_message() {
    local prefix=$1
    local message=$2
    echo "[$prefix] $message"
}

if [ $# -lt 1 ]; then
    log_message "ERROR" "You must provide at least the file argument."
    exit 1
fi

file=$1
include=$2

# Check if .clang-tidy exists in the current directory
if [ ! -f ".clang-tidy" ]; then
    log_message "ERROR" ".clang-tidy file not found in the current directory."
    exit 1
fi

# Check if the file exists
if [ ! -f "$file" ]; then
    log_message "ERROR" "File '$file' does not exist."
    exit 1
fi

# Check if the file extension is valid (.h/.cpp/.hpp)
if [[ ! "$file" =~ \.(h|cpp|hpp)$ ]]; then
    log_message "ERROR" "File '$file' must have a '.h', '.cpp', or '.hpp' extension."
    exit 1
fi

# Run clang-tidy tool with defined arguments:
# File - Required
# Include - Optional
if [ -n "$include" ]; then
    if [ ! -d "$include" ]; then
        log_message "ERROR" "Include directory '$include' does not exist."
        exit 1
    fi

    log_message "INFO" "Running clang-tidy with file='$file' and dictionary='$include'"
    clang-tidy "$file" -- -I"$include" -x c++ -std=c++23
else
    log_message "INFO" "Running clang-tidy with file='$file'."
    clang-tidy "$file" -- -x c++ -std=c++23
fi
