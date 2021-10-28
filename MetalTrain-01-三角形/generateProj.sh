#!/bin/bash

#SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"


# Attention: specify your DEVELOPMENT_TEAM_ID and PRODUCT_BUNDLE_IDENTIFIER,or you can manually specify below
if [ -z "$DEVELOPMENT_TEAM_ID" ]
then
    DEVELOPMENT_TEAM_ID="xxxx66666" # this is example,consist of number and letter,"xxxx66666" is invalid
fi
if [ -z "$PRODUCT_BUNDLE_IDENTIFIER" ]
then
    PRODUCT_BUNDLE_IDENTIFIER="com.learnmetal.xxx" # also is example
fi


mkdir -p build
pushd build

cmake -G Xcode   \
    -DCMAKE_SYSTEM_NAME=iOS \
	-DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_OSX_DEPLOYMENT_TARGET=10.0 \
    -DCMAKE_IOS_INSTALL_COMBINED=YES \
    -DCMAKE_XCODE_ATTRIBUTE_DEVELOPMENT_TEAM=${DEVELOPMENT_TEAM_ID} \
    -DPRODUCT_BUNDLE_IDENTIFIER=${PRODUCT_BUNDLE_IDENTIFIER} \
    -DCMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY="iPhone Developer"  \
    ../ &&  echo "cmake generate done " || echo "cmake generate failed"

popd
