#!/bin/sh
set -x

mkdir build-ec2

cd build-ec2/

echo "Build cdwdatagetter"
GOOS=linux go build -v github.com/gevgev/cdwdatagetter

rc=$?; if [[ $rc != 0 ]]; then 
	echo "Build failed: cdwdatagetter"
	cd ..
	exit $rc; 
fi

echo "Build aws-s3-uploader"
GOOS=linux go build -v github.com/gevgev/aws-s3-uploader

rc=$?; if [[ $rc != 0 ]]; then 
	echo "Build failed: aws-s3-uploader"
	cd ..
	exit $rc; 
fi

echo "Copying script and mso list"
cp ../run-ubuntu-hh-viewership.sh run.sh
cp ../mso-list-full.csv mso-list.csv
cp ../loop.sh loop.sh

echo "Archiving"

zip archive.zip *

echo 'Success'
cd ..