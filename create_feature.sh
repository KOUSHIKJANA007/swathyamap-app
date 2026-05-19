#!/bin/bash

FEATURE_NAME=$1

BASE_DIR="lib/feature/$FEATURE_NAME"

mkdir -p $BASE_DIR/{data,domain,presentation}

mkdir -p $BASE_DIR/data/{model,repository,datasource}
mkdir -p $BASE_DIR/domain/{entities,repository,usecases}
mkdir -p $BASE_DIR/presentation/{bloc,pages,widgets}

echo "Feature '$FEATURE_NAME' created successfully!"