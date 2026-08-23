@echo off
setlocal
set GRADLE_VERSION=8.11.1
set DIST_DIR=%USERPROFILE%\.elevate-gradle\%GRADLE_VERSION%
set ZIP_PATH=%DIST_DIR%\gradle-%GRADLE_VERSION%-bin.zip
set GRADLE_BIN=%DIST_DIR%\gradle-%GRADLE_VERSION%\bin\gradle.bat

if exist "%GRADLE_BIN%" goto run

if not exist "%DIST_DIR%" mkdir "%DIST_DIR%"

if not exist "%ZIP_PATH%" (
  echo Downloading Gradle %GRADLE_VERSION%...
  powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Invoke-WebRequest -Uri 'https://services.gradle.org/distributions/gradle-%GRADLE_VERSION%-bin.zip' -OutFile '%ZIP_PATH%'"
  if errorlevel 1 exit /b 1
)

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Expand-Archive -Path '%ZIP_PATH%' -DestinationPath '%DIST_DIR%' -Force"
if errorlevel 1 exit /b 1

:run
call "%GRADLE_BIN%" %*
