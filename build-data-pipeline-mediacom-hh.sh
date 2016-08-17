#!/bin/sh
set -x

mkdir data-pipeline-mediacom

cd data-pipeline-mediacom/

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

echo "Build precondition"
GOOS=linux go build -v github.com/gevgev/precondition

rc=$?; if [[ $rc != 0 ]]; then 
	echo "Build failed: precondition"
	cd ..
	exit $rc; 
fi

echo "Copying script and mso list"
cp ../run-ubuntu-hh-only.sh run.sh
cp ../mso-list-mediacom.csv mso-list.csv
cp ../run-pipeline-mediacom.sh loop.sh

echo "Pushing to S3"

aws s3 cp . s3://daap-pipeline/hh-mediacom --recursive

echo 'Success'
cd ..