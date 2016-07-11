#!/bin/bash
set -x

output_files_dir=cdw-data-reports
mso_list=mso-list-full.csv

./aws-s3-uploader -p "$output_files_dir" -n hhid_count -b daap-hh-count -m "$mso_list"

mv "$output_files_dir" cdw-viewership-reports/

./aws-s3-uploader -p cdw-viewership-reports/ -n tv_viewership -b daap-viewership-reports -m "$mso_list" -z=true
