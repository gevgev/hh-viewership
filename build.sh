#!/bin/sh
set -x

go build -v github.com/gevgev/cdwdatagetter

rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

go build -v github.com/gevgev/aws-s3-uploader

rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

go build -v github.com/gevgev/precondition

rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

echo 'Success'
