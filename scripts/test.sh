#!/bin/bash

echo "🧪 Testing CloudFront Multi-Origin Setup"
echo "=========================================="

# Get CloudFront URL from Terraform output
cd terraform
CLOUDFRONT_URL=$(terraform output -raw cloudfront_url)
cd ..

echo "CloudFront URL: $CLOUDFRONT_URL"
echo ""

# Test 1: Root path
echo "Test 1: Root path (/)"
echo "Expected: 'Hello, CDN origin is working fine'"
curl -s "$CLOUDFRONT_URL/" | grep -o "Hello, CDN origin is working fine" && echo "✅ PASS" || echo "❌ FAIL"
echo ""

# Test 2: Secondary origin path
echo "Test 2: /devops-folder/ path"
echo "Expected: 'Hello, CDN 2 origin is working fine'"
curl -s "$CLOUDFRONT_URL/devops-folder/" | grep -o "Hello, CDN 2 origin is working fine" && echo "✅ PASS" || echo "❌ FAIL"
echo ""

# Test 3: Check cache headers
echo "Test 3: Cache headers (Root)"
curl -sI "$CLOUDFRONT_URL/" | grep -i "x-cache"
echo ""

echo "Test 4: Cache headers (/devops-folder/)"
curl -sI "$CLOUDFRONT_URL/devops-folder/" | grep -i "x-cache"
echo ""

echo "=========================================="
echo "Manual verification URLs:"
echo "Root: $CLOUDFRONT_URL/"
echo "DevOps Folder: $CLOUDFRONT_URL/devops-folder/"
