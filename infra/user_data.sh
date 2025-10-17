#!/bin/bash
# ========================================
# 🚀 Automated setup for Next.js + PostgreSQL + PM2
# ========================================

exec > >(tee /var/log/deploy.log|logger -t user-data -s 2>/dev/console) 2>&1

# Update system packages
sudo yum update -y

# Install utilities (git, jq, awscli)
sudo yum install -y git jq awscli

# Install Node.js (v18)
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo yum install -y nodejs

# Verify installations
node -v
npm -v
git --version
aws --version

# Install PM2 globally
sudo npm install -g pm2

# Clone the app repo
cd /home/ec2-user
if [ -d "app" ]; then
  echo "App directory already exists, removing..."
  rm -rf app
fi

git clone https://github.com/sherryguocc/goldenset-devops-assignment.git app
cd app

# ========================================
# ⚙️ Fetch DB credentials from AWS Secrets Manager
# ========================================
REGION="ap-southeast-2"
SECRET_NAME="goldenset-devops-internship-assignment-db-secret"

# Wait a few seconds to ensure IAM role is ready
sleep 10

# Fetch the secret JSON and extract values
SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id "$SECRET_NAME" --query SecretString --output text --region "$REGION")
if [ -z "$SECRET_JSON" ]; then
  echo "❌ Failed to fetch DB credentials from Secrets Manager"
  exit 1
fi

DB_USER=$(echo $SECRET_JSON | jq -r .username)
DB_PASS=$(echo $SECRET_JSON | jq -r .password)
DB_HOST=$(echo $SECRET_JSON | jq -r .host)
DB_PORT=$(echo $SECRET_JSON | jq -r .port)
DB_NAME=$(echo $SECRET_JSON | jq -r .dbname)

# Write environment variables for Next.js
cat <<EOF > /home/ec2-user/app/.env.local
DATABASE_URL=postgresql://$DB_USER:$DB_PASS@$DB_HOST:$DB_PORT/$DB_NAME
NODE_ENV=production
EOF

echo "✅ DATABASE_URL has been written to .env.local"

# ========================================
# 🧱 Build and run Next.js app
# ========================================

npm install
npm run build

# Start the app using PM2
pm2 start npm --name "nextjs-dashboard" -- start
pm2 startup systemd
pm2 save

echo "✅ Deployment complete! App should be running on port 3000."
