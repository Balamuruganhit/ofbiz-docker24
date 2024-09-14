#!/bin/bash
set -e

# Ensure the database service is running.
RUNNING_DB_SERVICE_ID=$(docker compose ps --quiet --filter status=running db 2>/dev/null || true)
if [ -z "$RUNNING_DB_SERVICE_ID" ]; then
    echo "Database service is NOT running. Please start the database service before running this script. (See start_db.sh)"
    exit 0
fi

# Ensure the ofbiz service is NOT running.
RUNNING_OFBIZ_SERVICE_ID=$(docker compose ps --quiet --filter status=running ofbiz 2>/dev/null || true)
if [ -n "$RUNNING_OFBIZ_SERVICE_ID" ]; then
    echo "OFBiz service is running. Please stop the OFBiz service before running this script. (See stop_ofbiz.sh)"
    exit 0
fi

echo Loading demo data...
docker compose run --rm ofbiz createTenant -PtenantId=tenant001   -PtenantName="My Tenant 001" -PdomainName=tenant001.example.com -PtenantReaders=seed,seed-initial,ext -PdbPlatform=P -PdbIp=127.0.0.1 -PdbUser=ofb_tenant001 -PdbPassword=ofbiz@tenant
echo Demo data loaded.
./gradlew loadTenantData -PtenantId=tenant001 -PtenantReaders=seed,seed-initial,demo --stacktrace --info

echo Administrative user name: localadmin
echo Administrative user password: ofbiz
