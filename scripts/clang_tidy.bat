@echo off
setlocal enabledelayedexpansion

:: This file is part of the Stomper project.
::
:: Licensed under the BSD 3-Clause License (the "License"); a copy of the License
:: is included with this project. You may also obtain a copy of the License at:
::
::     https://opensource.org/licenses/BSD-3-Clause
::
:: Additional licenses for third-party dependencies are also included
:: and must be reviewed separately.

:log_message
set "prefix=%~1"
set "message=%~2"
echo [%prefix%] %message%
exit /b 0

if "%~1"=="" (
    call :log_message ERROR "You must provide at least the file argument."
    exit /b 1
)

set "file=%~1"
set "include=%~2"

:: Check if .clang-tidy exists in the current directory
if not exist ".clang-tidy" (
    call :log_message ERROR ".clang-tidy file not found in the current directory."
    exit /b 1
)

:: Check if the file exists
if not exist "%file%" (
    call :log_message ERROR "File '%file%' does not exist."
    exit /b 1
)

:: Check if the file extension is valid (.h/.cpp/.hpp)
echo %file% | findstr /i "\.h$ \.cpp$ \.hpp$" >nul
if errorlevel 1 (
    call :log_message ERROR "File '%file%' must have a '.h', '.cpp', or '.hpp' extension."
    exit /b 1
)

:: Run clang-tidy tool with defined arguments:
:: File - Required
:: Include - Optional
if not "%include%"=="" (
    if not exist "%include%" (
        call :log_message ERROR "Include directory '%include%' does not exist."
        exit /b 1
    )

    call :log_message INFO "Running clang-tidy with file='%file%' and directory='%include%'."
    clang-tidy "%file%" -- -I"%include%" -x c++ -std=c++23
) else (
    call :log_message INFO "Running clang-tidy with file='%file%'"
    clang-tidy "%file%" -- -x c++ -std=c++23
)

exit /b 0
