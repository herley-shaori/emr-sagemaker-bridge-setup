#!/bin/bash

# Check if the bucket name is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <bucket-name>"
  exit 1
fi

BUCKET_NAME=$1

# Empty the S3 bucket
aws s3 rm s3://$BUCKET_NAME --recursive

# Delete the S3 bucket
aws s3api delete-bucket --bucket $BUCKET_NAME