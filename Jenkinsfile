pipeline {
    agent any

    stages {
        stage('Decrypt GPG File from S3') {
            steps {
                echo "Hello"
                #sh 'chmod +x test-decrypt-02.sh'
                #sh './test-decrypt-02.sh'
            }
        }

        stage('List S3 Outbox') {
            steps {
                sh 'aws s3 ls s3://poc-gpg-bucket-uat-142603072023/in/ '
            }
        }

        stage('List S3 Inbox') {
            steps {
                sh 'aws s3 ls s3://poc-gpg-bucket-uat-142603072023/out/ '
            }
        }
    }
}    
