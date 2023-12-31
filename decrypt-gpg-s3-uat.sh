#!/bin/bash

# Set the S3 bucket name and prefix for the objects
S3_BUCKET="poc-gpg-bucket-uat-11072023-2309"
S3_INPUT_PATH="in/"
S3_OUTPUT_PATH="out/"
S3_ARCHIVE_PATH="archive/"

# Set the local directory where decrypted files will be saved
LOCAL_DIR="/tmp/decrypted-files-uat/"

# Download the encrypted files from S3
aws s3 cp "s3://${S3_BUCKET}/${S3_INPUT_PATH}" /tmp --recursive --exclude "*" --include "*.pgp"

# Decrypt each file using gpg
for file in /tmp/*.pgp; do
  filename=$(basename "$file")
  output_file="${LOCAL_DIR}${filename%.pgp}"
  gpg --pinentry-mode=loopback --decrypt --output "$output_file" "$file"

# Upload the decrypted file to S3
  aws s3 cp "$output_file" "s3://${S3_BUCKET}/${S3_OUTPUT_PATH}${filename%.pgp}"
done

# Remove the temporary encrypted files
rm -rf /tmp/*.pgp
rm -rf /tmp/decrypted-files-uat/*.txt

# List the temporary encrypted files
ls -ltr /tmp/*.pgp
ls -tlr /tmp/decrypted-files-uat/*.txt

# Move all PGP files to the archive directory
#aws s3 mv "s3://${S3_BUCKET}/${S3_INPUT_PATH}/" "s3://${S3_BUCKET}/${S3_ARCHIVE_PATH}/" --recursive --exclude "*" --include "*.pgp"
#aws s3 mv s3://poc-gpg-bucket-uat-11072023-2309/in/ s3://poc-gpg-bucket-uat-11072023-2309/archive/ --recursive --exclude "*" --include "*.pgp"

# Display a success message
echo "Decryption complete. Files saved in ${LOCAL_DIR}"
