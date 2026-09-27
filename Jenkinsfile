pipeline {
    agent any

    environment {
    AWS_REGION = 'us-east-1'
    AWS_DEFAULT_REGION = 'us-east-1'
    AWS_PAGER = ''
    AWS_ACCOUNT_ID = '678817681968'
    ECR_REPOSITORY = 'aws-eks-cicd-pipeline'
    EKS_CLUSTER = 'aws-eks-cicd-cluster'
    KUBECONFIG = '/var/jenkins_home/.kube/config'

    IMAGE_TAG = "${BUILD_NUMBER}"
    IMAGE_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMAGE_TAG}"
}

    stages {
 
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build \
                  --platform linux/amd64 \
                  -t $IMAGE_URI \
                  ./app
                '''
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION \
                | docker login \
                  --username AWS \
                  --password-stdin \
                  $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
                '''
            }
        }

        stage('Push Image to ECR') {
            steps {
                sh '''
                docker push $IMAGE_URI
                '''
            }
        }

        stage('Configure EKS') {
            steps {
                sh '''
                aws eks update-kubeconfig \
                  --region $AWS_REGION \
                  --name $EKS_CLUSTER
                '''
            }
        }

        stage('Deploy with Helm') {
            steps {
                sh '''
                helm upgrade --install hello-world ./helm/hello-world \
                  --set image.repository=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY \
                  --set image.tag=$IMAGE_TAG
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                kubectl rollout status deployment/hello-world
                kubectl get pods
                '''
            }
        }
    }

    post {
        success {
            echo 'Deployment completed successfully.'
        }

        failure {
            echo 'Pipeline failed.'
        }
    }
}
