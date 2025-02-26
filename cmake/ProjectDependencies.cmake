# This file is part of the Stomper project.
#
# Licensed under the BSD 3-Clause License (the "License"); a copy of the License
# is included with this project. You may also obtain a copy of the License at:
#
#     https://opensource.org/licenses/BSD-3-Clause
#
# Additional licenses for third-party dependencies are also included
# and must be reviewed separately.

include(FetchContent)

# https://github.com/catchorg/Catch2
# Check: third-party/catch2.dat
FetchContent_Declare(
        catch2
        GIT_REPOSITORY https://github.com/catchorg/Catch2.git
        GIT_TAG v3.8.0
)

# https://github.com/bombela/backward-cpp
# Check: third-party/backward.dat
FetchContent_Declare(
        backward
        GIT_REPOSITORY https://github.com/bombela/backward-cpp.git
        GIT_TAG v1.6
)


FetchContent_MakeAvailable(catch2)
FetchContent_MakeAvailable(backward)