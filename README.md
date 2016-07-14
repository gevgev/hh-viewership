# hh-viewership

Steps:
  1. Build/package for ec2 linux:
      $> ./build-ec2.sh
  2. Launch ec2 instance:
      - c4.2xlarge
      - 500GB EBS
      - daap-s3-role
      - default security group (default VPC)
      - yum install -y tree
      - Setup:
        - /data
        - chown ec2-user:ec2-user /data
  3. Deploy:
      - archive.zip from build-ec2.sh --> /data
      - working dir
      - unzip archive.zip under working
      - adjust the date raneg for loop.sh
      - nohup ./loop.sh &
  4. Monitor:
      - tail nohup.out
      - tree events
      - tree cdw-data-reports
      - df -h
      - free -m
