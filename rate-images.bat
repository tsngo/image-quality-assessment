@echo off
SET SCRIPT_PATH=%~d0%~p0
SET IMAGE_SOURCE="..\images\sorted"
:Loop
IF "%~1"=="" GOTO Continue
IF "%~1"=="--image-source" (
  SET IMAGE_SOURCE=%~f2
  SHIFT
)
SHIFT
GOTO Loop
:Continue

echo %CD%\predictions-a.json
echo %SCRIPT_PATH%
echo %IMAGE_SOURCE%

%SCRIPT_PATH%predict.bat --weights-file %SCRIPT_PATH%models\MobileNet\weights_mobilenet_aesthetic_0.07.hdf5 --image-source %IMAGE_SOURCE% --predictions-file %CD%\predictions-a.json && %SCRIPT_PATH%predict.bat --weights-file %SCRIPT_PATH%models\MobileNet\weights_mobilenet_technical_0.11.hdf5 --image-source %IMAGE_SOURCE% --predictions-file %CD%\predictions-t.json