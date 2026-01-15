# Objective
This backend /dir has sample express backend application. The purpose of this application is to implement/learn about different **backend** deployement architectures AWS provides and create CI/CD pipeline to automate that. 

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

2. Push docker image to ECR Private Registery:
    ##### Steps:
    - Verify docker and AWS CLI
    ``` 
    docker --version
    aws --version
    ```
    - Create ECR Repository
    ``` 
    aws ecr create-repository \
    --repository-name <YOUR REPOSITORY NAME> \
    --region <YOUR PREFFERED REGION>
    ```
    You will recieve ECR Repository URI
   
    - Authenticate Docker to ECR
    ```
    aws ecr get-login-password --region <YOUR REGION> \
    | docker login --username AWS --password-stdin <REPOSITORY URI>
    ```
   
    - Build docker image
    ```
    docker buildx build --platform linux/amd64 -t  cicd-aws-lab-backend .
    ```
    > Here, I have built docker image using ``amd64`` architecture, because I am using MAC OS(ARM64) and ECR supports **x86_64** image
   
    - Tag you build image and push to ECR Repo
    ```
    docker tag cicd-aws-lab-backend:latest <REPOSITORY URI>/cicd-aws-lab-backend:latest
    docker push <REPOSITORY URI>/cicd-aws-lab-backend:latest
    ```
3. Create task definition is AWS:
    > **What is task definition**: 
     A blueprint to run your docker image. Tells AWS about the type of infrastructure(EC2, Fargate, or Mix), resources it should allocate(CPU,RAM), env variable to use, port to map, cloudWatch logs, health check of the container, etc.
    ##### Steps:
    - Give name to it; ``cicd-aws-lab-backend``
    - Set ``AWS Fargate`` as a infrastructure
    - Set CPU and and memory needed to run the docker image.
    
    > You need to create two roles here:
     1. Task role (optional): Need this if your **docker image make an API Request** to any other AWS Service.
     2. Task Execution role (mandatory): Need this if your **task makes an API Request** to any other AWS Service. It is needed because task's primary job is to get the docker image from ECR, which is AWS Service. 

4. Create ECS Service with latest task definition revision. 
    ##### Steps:
    1. Create cluster under Amazon Elastic Container Service with the **backend-generic-cluster** name. Here, choose the same infrastructure you choose when creating task definition, which is fargate in our case. 
    2. 