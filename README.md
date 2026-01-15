# Objective
The aim of this project is to learn and practice concepts of GitHub Actions and AWS Services

## Current(Intial) Version setup:
- A Simple index.html file is being served using Amazon S3 and CloudFront
- A GitHub Actions ci/cd is placed that will automatically going to update the website on ``code push to main branch``

### Steps Performed in AWS Console to Host the Frontend Manually
1. Sign in to the AWS Console using the **root account**.
2. Create a new **IAM user** with(least privilege):
   - Full S3 access
   - CloudFront access
3. Sign in to the AWS Console using the **new user credentials**.
4. Create an **S3 bucket** with **public access blocked**.
5. Upload `index.html` using the **Object Upload** option in S3.
6. Verify that the S3 object **cannot be accessed directly** via the S3 URL.
7. Create an **AWS CloudFront distribution**:
   1. Use the **S3 REST endpoint** (do **not** use the website endpoint).  
   2. Enable **Origin Access Control (OAC)** to allow CloudFront to access private S3 objects.  
   3. Set the **Default Root Object** as `index.html`.  
      > This tells CloudFront which object to serve when a user accesses the distribution DNS.
8. Access your website via the **CloudFront DNS**, which now serves `index.html` through the CDN.
> **Blocked public access of S3 and OAC ensures that only cloudfront distribution can access S3 objects**

### Steps performed to build ci/cd workflow using GitHub Actions
1. First create AWS User access keys and password through AWS Console for above AWS User
2. Download csv file into project folder; makesure add that into .gitignore
3. Now create all the required variables for workflow inside GitHub ``Repository Secrets`` to inject into workflow file securely; no hardcoded values
   - AWS_ACCESS_KEY_ID
   - AWS_REGION
   - AWS_SECRET_ACCESS_KEY
   - CLOUDFRONT_DISTRIBUTION_ID
   - S3_BUCKET_NAME
4. Create yml workflow file under .github/workflows directory
5. commit and push; check the status of worlflow file inside github repo 

## Steps to run the docker container
1. Go inside project directory where Dockerfile exists
```bash
# build the docker image
docker build -t cicd-aws-lab
# run the container; map host port 80 to container port 80
docker run -p 80:80 cicd-aws-lab
```
2. now go to your [localhost](http://localhost/); you should see the webpage being served there

## Checkout the live website:
https://diwihxs8zdk4e.cloudfront.net/