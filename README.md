## Steps Performed in AWS Console to Host the Website Manually

1. Sign in to the AWS Console using the **root account**.
2. Create a new **IAM user** with:
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