#!/bin/bash
set -e

# Ensure the database service is running.
RUNNING_DB_SERVICE_ID=$(docker compose ps --quiet --filter status=running db 2>/dev/null || true)
if [ -z "$RUNNING_DB_SERVICE_ID" ]; then
    echo "Database service is NOT running. Please start the database service before running this script. (See start_db.sh)"
    exit 0
fi

# Ensure the OFBiz service is NOT running.
RUNNING_OFBIZ_SERVICE_ID=$(docker compose ps --quiet --filter status=running ofbiz 2>/dev/null || true)
if [ -n "$RUNNING_OFBIZ_SERVICE_ID" ]; then
    echo "OFBiz service is running. Please stop the OFBiz service before running this script. (See stop_ofbiz.sh)"
    exit 0
fi

# Tenant parameters (you can modify these as needed)
TENANT_ID="tenant1"
TENANT_NAME="Tenant_One"
DOMAIN_NAME="tenant1.example.com"
DB_NAME="tenant1_db"
DB_USER="tenant1_user"
DB_PASSWORD="tenant1_pass"

# Step 1: Create the tenant
# Create Tenant 1
echo "tenant1 create start"
./gradlew "ofbiz --service createTenant --tenantId=tenant1 --tenantName=Tenant_One --domainName=tenant1.example.com --tenantDataSourceName=tenant1-datasource"
echo "tenant 1 created"

echo "tenant2 create start"
./gradlew "ofbiz --service createTenant --tenantId=tenant2 --tenantName=Tenant_Two --domainName=tenant2.example.com --tenantDataSourceName=tenant2-datasource"

echo "start ofbiz"
./gradlew ofbiz
# Admin credentials (can be modified if needed)
echo "Administrative user name: localadmin"
echo "Administrative user password: ofbiz"
