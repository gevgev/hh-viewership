#!/bin/bash
set -x

for i in `seq 20160710 20160712`;
do
  echo $i
  ./run.sh <AWS_ACCESS_KEY_ID> <AWS_SECRET_ACCESS_KEY> rovi-cdw data_downloader_tracker.txt cdw_downloads_logs input_compressed_cdw_data cdw-data-reports tv_viewership.cod event/tv_viewership mso-list.csv $i
done 