@echo off
:Loop
IF "%~1"=="" GOTO Continue
IF "%~1"=="--docker-image" (
  SET DOCKER_IMAGE=%~2
  SHIFT
)
IF "%~1"=="--base-model-name" (
  SET BASE_MODEL_NAME=%~2
  SHIFT
)
IF "%~1"=="--weights-file" (
  SET WEIGHTS_FILE=%~f2
  SHIFT
)
IF "%~1"=="--image-source" (
  SET IMAGE_SOURCE=%~f2
  SHIFT
)
IF "%~1"=="--predictions-file" (
  SET PREDICTIONS_FILE=%~f2
  SHIFT
)
SHIFT
GOTO Loop
:Continue

for /F %%i in ("%PREDICTIONS_FILE%") do SET BASENAME_PF=%%~nxi
for /F %%i in ("%IMAGE_SOURCE%") do SET BASENAME_IS=%%~nxi

docker run --rm --name iqa --entrypoint entrypoints/entrypoint.predict.cpu.sh -v %IMAGE_SOURCE%:/src/%BASENAME_IS% -v %PREDICTIONS_FILE%:/src/%BASENAME_PF% -v %WEIGHTS_FILE%:/src/weights.hdf5 %DOCKER_IMAGE% %BASE_MODEL_NAME% /src/weights.hdf5 /src/%BASENAME_IS% /src/%BASENAME_PF%