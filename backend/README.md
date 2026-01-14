# Objective
This backend /dir has sample express backend application. The purpose of this application is to implement/learn about deployement backend application onto AWS and create CI/CD pipeline to automate it. 

## Below are the different ways to deploy backend using AWS Services

### 1. ECR+ECS/FARGATE+ALB:
#### Steps:
1. Containerize backend using Docker:
    - Create Dockerfile / .dockerignore
    - run docker container locally and test apis 

    Run this commands to build and run docker image locally
    ```
    cd backend
    docker build -t cicd-aws-lab-backend .
    docker run -p 5001:5001 -e PORT=5001 cicd-aws-lab-backend
    ```

2. Push docker image to ECR:
    - 