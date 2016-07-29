#!/bin/bash
set -x

if [ "$#" -ne 2 ]; then
    echo "Error: Missing parameters:"
    echo "  AWS_access_key"
    echo "  AWS_access_secret"
    exit -1
fi

cdw_aws_key=$1
cdw_aws_secret=$2

dates=$(./precondition -K "$cdw_aws_key" -S "$cdw_aws_secret")

results=($dates)

if [ ${results[0]} != "true" -o ${results[2]} != "true" ]; then
	echo "Could not find dates:"
	echo "$dates" 
	exit -1
fi

from=${results[1]}
to=${results[3]}

echo $from, $to

d=$(date -I -d "$from + 1 day")
up=$(date -I -d "$to + 1 day")

while [ "$d" != "$up" ]; do 
  dd=$(date -d "$d" +%Y%m%d)

  ./run.sh "$cdw_aws_key" "$cdw_aws_secret" rovi-cdw data_downloader_tracker.txt cdw_downloads_logs input_compressed_cdw_data cdw-data-reports tv_viewership.cod event/tv_viewership mso-list.csv "$dd"

  d=$(date -I -d "$d + 1 day")
done
