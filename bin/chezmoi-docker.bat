@echo off
REM chezmoi-docker.bat - Windows wrapper for chezmoi in Docker
REM Usage: chezmoi-docker.bat [chezmoi args]

setlocal ENABLEDELAYEDEXPANSION

REM Determine script directory
set SCRIPT_DIR=%~dp0
set REPO_DIR=%SCRIPT_DIR%..\
set DOCKER_DIR=%REPO_DIR%docker\

REM Build image if requested
if "%1"=="--build" (
    shift
    echo Building chezmoi Docker image...
    docker build -t levonk/chezmoi:latest -f "%DOCKER_DIR%Dockerfile" "%REPO_DIR%"
    echo Build complete. You can now use 'chezmoi-docker.bat' to run chezmoi commands.
    exit /b 0
)

REM Check if image exists, build if not
for /f "tokens=*" %%i in ('docker images -q levonk/chezmoi:latest') do set IMAGE_EXISTS=%%i
if not defined IMAGE_EXISTS (
    echo Docker image not found. Building it first...
    docker build -t levonk/chezmoi:latest -f "%DOCKER_DIR%Dockerfile" "%REPO_DIR%"
)

REM Run chezmoi in the container
REM Mount user home and repo for access
REM Note: %USERPROFILE% is the Windows home directory
REM       Adjust as needed for your dotfiles layout

docker run -it --rm ^
    --name chezmoi ^
    -v "%USERPROFILE%:%USERPROFILE%" ^
    -v "%REPO_DIR%chezmoi:/dotfiles" ^
    -e USER=%USERNAME% ^
    -e HOME=%USERPROFILE% ^
    -w "%USERPROFILE%" ^
    levonk/chezmoi:latest %*
