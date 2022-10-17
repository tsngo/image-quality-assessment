#!/bin/bash
set -e

BASE_MODEL_NAME=$1
WEIGHTS_FILE=$2
IMAGE_SOURCE=$3
PREDICTIONS_FILE=$4
IMG_FORMAT=$5

# predict
python -m evaluater.predict \
--base-model-name $BASE_MODEL_NAME \
--weights-file $WEIGHTS_FILE \
--image-source $IMAGE_SOURCE \
--predictions-file $PREDICTIONS_FILE \
--img-format $IMG_FORMAT