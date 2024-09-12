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
TENANT_ID="tenant001"
TENANT_NAME="My Tenant 001"
DOMAIN_NAME="tenant001.example.com"
DB_PLATFORM="P"  # M is typically for PostgreSQL
DB_IP="172.19.0.2"
DB_USER="ofbiztenant"  # Use the database user created for the tenant
DB_PASSWORD="ofbiztenant"  # Use the password set for the tenant database user
TENANT_READERS="seed,seed-initial,ext"
TENANT_COMPONENT="base"

# Step 1: Create the tenant
echo "Creating tenant '$TENANT_NAME' with ID '$TENANT_ID'..."
# docker compose run --rm ofbiz  createTenant -PtenantId=tenant001   -PtenantName="My Tenant 001" -PdomainName=tenant001.example.com -PtenantReaders=seed,seed-initial,ext -PdbPlatform=P -PdbIp=172.19.0.2 -PdbUser=ofbiztenant -PdbPassword=ofbiztenant -Dorg.gradle.jvmargs="-Xmx1024m"
docker compose run --rm ofbiz createTenant -PtenantId=mytenant -PtenantName="My Name" -PdomainName=com.example -PtenantReaders=seed,seed-initial,ext -PdbPlatform=M -PdbIp=127.0.0.1 -PdbUser=mydbuser -PdbPassword=mydbpass
echo "Tenant '$TENANT_NAME' created with ID '$TENANT_ID'."

# Step 2: Load tenant data
echo "Loading data for tenant '$TENANT_ID'..."
docker compose run --rm ofbiz loadTenant -PtenantId=mytenant -PtenantReaders=seed,seed-initial,demo -PtenantComponent=base

echo "Data for tenant '$TENANT_ID' loaded."

# Admin credentials (can be modified if needed)
echo "Administrative user name: localadmin"
echo "Administrative user password: ofbiz"
