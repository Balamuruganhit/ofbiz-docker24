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
TENANT_ID="mytenant"
TENANT_NAME="My Name"
DOMAIN_NAME="com.example"
DB_PLATFORM="M"  # M is typically for PostgreSQL
DB_IP="127.0.0.1"
DB_USER="ofbiztenant"  # Use the database user created for the tenant
DB_PASSWORD="ofbiztenant"  # Use the password set for the tenant database user
TENANT_READERS="seed,seed-initial,demo"
TENANT_COMPONENT="base"

# Step 1: Create the tenant
echo "Creating tenant '$TENANT_NAME' with ID '$TENANT_ID'..."
docker compose run --rm ofbiz  createTenant \
  -PtenantId=$TENANT_ID \
  -PtenantName="$TENANT_NAME" \
  -PdomainName=$DOMAIN_NAME \
  -PtenantReaders="seed,seed-initial,ext" \
  -PdbPlatform=$DB_PLATFORM \
  -PdbIp=$DB_IP \
  -PdbUser=$DB_USER \
  -PdbPassword=$DB_PASSWORD

echo "Tenant '$TENANT_NAME' created with ID '$TENANT_ID'."

# Step 2: Load tenant data
echo "Loading data for tenant '$TENANT_ID'..."
docker compose run --rm ofbiz  loadTenant \
  -PtenantId=$TENANT_ID \
  -PtenantReaders=$TENANT_READERS \
  -PtenantComponent=$TENANT_COMPONENT

echo "Data for tenant '$TENANT_ID' loaded."

# Admin credentials (can be modified if needed)
echo "Administrative user name: localadmin"
echo "Administrative user password: ofbiz"
