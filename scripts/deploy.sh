#!/bin/bash
set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}=========================================================="
echo "   BlueStacks DevOps Challenge - Assignment 1 Deployment"
echo "==========================================================${NC}"
echo ""

if ! aws sts get-caller-identity &> /dev/null; then
    echo -e "${RED}❌ AWS credentials not configured!${NC}"
    exit 1
fi

echo -e "${GREEN}✅ AWS credentials verified${NC}"
echo ""

echo -e "${BLUE}📦 Step 1: Initializing Terraform...${NC}"
cd terraform
terraform init
echo ""

echo -e "${BLUE}✅ Step 2: Validating configuration...${NC}"
terraform validate
echo ""

echo -e "${BLUE}📋 Step 3: Planning infrastructure...${NC}"
terraform plan -out=tfplan
echo ""

echo -e "${BLUE}🏗️  Step 4: Creating AWS infrastructure...${NC}"
terraform apply tfplan
echo ""

echo -e "${BLUE}📤 Step 5: Getting bucket information...${NC}"
PRIMARY_BUCKET=$(terraform output -raw primary_bucket_name)
SECONDARY_BUCKET=$(terraform output -raw secondary_bucket_name)
CLOUDFRONT_ID=$(terraform output -raw cloudfront_distribution_id)
CLOUDFRONT_URL=$(terraform output -raw cloudfront_url)

echo "Primary bucket: $PRIMARY_BUCKET"
echo "Secondary bucket: $SECONDARY_BUCKET"
echo ""

cd ..

echo -e "${BLUE}📤 Uploading content...${NC}"
aws s3 sync content/primary/ s3://$PRIMARY_BUCKET/ --delete
aws s3 sync content/secondary/ s3://$SECONDARY_BUCKET/ --delete
echo ""

echo -e "${BLUE}🔄 Creating CloudFront invalidation...${NC}"
aws cloudfront create-invalidation --distribution-id $CLOUDFRONT_ID --paths "/*" > /dev/null
echo ""

echo -e "${GREEN}=========================================================="
echo "                 ✅ Deployment Complete!"
echo "==========================================================${NC}"
echo ""
echo "🌐 Your CloudFront URL:"
echo -e "${GREEN}$CLOUDFRONT_URL${NC}"
echo ""
echo "Test in browser:"
echo "  ${CLOUDFRONT_URL}/"
echo "  ${CLOUDFRONT_URL}/devops-folder/"
echo ""
