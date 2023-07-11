pipeline {
    agent any

    stages {
        stage('Decrypt GPG File from S3') {
            steps {
                sh 'chmod +x decrypt-gpg-s3-uat.sh'
                sh './decrypt-gpg-s3-uat.sh'
            }
        }

        stage('List S3 Outbox') {
            steps {
                sh 'aws s3 ls s3://poc-gpg-bucket-uat-11072023-2309/in/ '
            }
        }

        stage('List S3 Inbox') {
            steps {
                sh 'aws s3 ls s3://poc-gpg-bucket-uat-11072023-2309/out/ '
            }
        }

        stage('List S3 Archive') {
            steps {
                sh 'aws s3 ls s3://poc-gpg-bucket-uat-11072023-2309/archive/ '
            }
        }
    }
}    
