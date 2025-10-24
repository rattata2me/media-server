@echo off
REM media-server.bat - Control script for Docker Compose media server

setlocal
set COMPOSE_FILE=docker-compose.yaml

REM Check if docker is installed
where docker >nul 2>nul
if errorlevel 1 (
    echo Docker is not installed. Please install Docker.
    exit /b 1
)
REM Check if docker compose is available
for /f "delims=" %%i in ('docker compose version 2^>nul') do set FOUND_COMPOSE=1
if not defined FOUND_COMPOSE (
    echo Docker Compose is not available. Please install Docker Compose v2 (integrated with Docker).
    exit /b 1
)

if "%1"=="start" (
    docker compose -f "%COMPOSE_FILE%" up -d
    exit /b 0
)
if "%1"=="stop" (
    docker compose -f "%COMPOSE_FILE%" stop
    exit /b 0
)
if "%1"=="down" (
    docker compose -f "%COMPOSE_FILE%" down
    exit /b 0
)
if "%1"=="update" (
    docker compose -f "%COMPOSE_FILE%" pull
    docker compose -f "%COMPOSE_FILE%" up -d --remove-orphans
    exit /b 0
)
if "%1"=="clean" (
    docker compose -f "%COMPOSE_FILE%" down
    for /f "tokens=*" %%i in ('docker images --filter "label=com.docker.compose.project=%cd%" -q') do docker rmi -f %%i
    docker compose -f "%COMPOSE_FILE%" pull
    docker compose -f "%COMPOSE_FILE%" up -d --remove-orphans
    exit /b 0
)

REM Usage
echo Usage: %0 ^<start^|stop^|down^|update^|clean^>
exit /b 1
