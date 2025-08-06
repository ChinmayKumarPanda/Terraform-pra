# EC2 instance with S3 backend access
resource "aws_instance" "name" {
  ami                  = var.ami
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = var.tags
  }
}

# 1️⃣ IAM Role for EC2
resource "aws_iam_role" "ec2_s3_role" {
  name = "ec2-s3-full-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# 2️⃣ Inline policy for specific S3 bucket access
resource "aws_iam_role_policy" "ec2_s3_bucket_policy" {
  name = "ec2-s3-backend-access"
  role = aws_iam_role.ec2_s3_role.id

  policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": "s3:ListBucket",
          "Resource": "arn:aws:s3:::chinu.shop"
        },
        {
          "Effect": "Allow",
          "Action": [
            "s3:GetObject",
            "s3:PutObject",
            "s3:DeleteObject",
            "s3:GetBucketAcl"
          ],
          "Resource": "arn:aws:s3:::chinu.shop/terraform.tfstate"
        }
      ]
    }
  )
}

# 3️⃣ (Optional) Attach AWS managed full S3 access
# Note: This is commented out. It is better to use the inline policy
# for least privilege access. If you uncomment this, it will grant
# the EC2 instance full S3 access across all buckets.
# resource "aws_iam_role_policy_attachment" "s3_full_access" {
#   role       = aws_iam_role.ec2_s3_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
# }

# 4️⃣ Instance profile to attach the role to EC2
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-s3-full-access-profile"
  role = aws_iam_role.ec2_s3_role.name
}