# hh-viewership

Steps:

For data-pipeline:
  1. Build/package for aws data pipeline:
      - ./build-data-pipeline.sh
      - it will push the artifacts to s3://.../data-pipeline/hh-viewership bucket
  2. Execute the ./loop.sh AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY within the data pipeline
      - It will first run ./precondition to identify the available data and last run dates
      - Next it will execute the loop with the ./run script, pasisng the date and AWS key/secret

For ec-2:
  1. Build/package for ec2 linux:
      - Prep:
        - cp loop-secure.sh loop.sh
        - inside loop.sh replace with values: 
          - AWS_ACCESS_KEY_ID
          - AWS_SECRET_ACCESS_KEY
          - $> ./build-ec2.sh
  2. Launch ec2 instance:
      - c4.2xlarge
      - 500GB EBS
      - daap-s3-role
      - default security group (default VPC)
      - Setup:
          - ./configure.sh
            - /data
            - chown ec2-user:ec2-user /data
            - yum install -y tree
  3. Deploy:
      - archive.zip from build-ec2.sh --> /data
      - working dir
      - unzip archive.zip under working
  4. Run:
      - A. Single day:
          - nohup ./run-hh-viewership.sh <AWS_ACCESS_KEY_ID> <AWS_SECRET_ACCESS_KEY> rovi-cdw data_downloader_tracker.txt cdw_downloads_logs input_compressed_cdw_data cdw-data-reports tv_viewership.cod event/tv_viewership mso-list.csv <20160702> &
      - B. Range of days:
        - adjust the date range inside loop.sh (FOR loop)
        - nohup ./loop.sh &
  5. Monitor:
      - tail nohup.out
      - tree events
      - tree cdw-data-reports
      - df -h
      - free -m
