# lambda/process_files.py
import json
import boto3
import os
import re

def lambda_handler(event, context):
    s3_client = boto3.client('s3')
    sqs_client = boto3.client('sqs')
    
    # Get the SQS queue URL from environment variable
    queue_url = os.environ.get('SQS_QUEUE_URL')
    
    # Get the bucket name and key from the event
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    
    # Only process metadata.txt files
    if key.endswith('metadata.txt'):
        try:
            # Get the metadata file content
            response = s3_client.get_object(Bucket=bucket, Key=key)
            content = response['Body'].read().decode('utf-8')
            
            # Extract file names from the metadata
            file_names = re.findall(r'[\w\.-]+\.txt', content)
            
            # Send messages to SQS for each file name
            for file_name in file_names:
                message = {
                    'bucket': bucket,
                    'file_name': file_name
                }
                
                sqs_client.send_message(
                    QueueUrl=queue_url,
                    MessageBody=json.dumps(message)
                )
                
            return {
                'statusCode': 200,
                'body': json.dumps(f'Processed {len(file_names)} files from metadata')
            }
            
        except Exception as e:
            print(f"Error processing metadata file: {str(e)}")
            return {
                'statusCode': 500,
                'body': json.dumps(f'Error: {str(e)}')
            }
    else:
        return {
            'statusCode': 200,
            'body': json.dumps('Not a metadata file, skipping')
        }
