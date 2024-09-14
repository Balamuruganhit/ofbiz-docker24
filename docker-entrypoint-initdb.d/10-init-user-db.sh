#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER ofbiz WITH PASSWORD 'ofbiz';
    CREATE DATABASE ofbiz;
    GRANT ALL PRIVILEGES ON DATABASE ofbiz TO ofbiz;

    CREATE USER ofbizolap WITH PASSWORD 'ofbizolap';
    CREATE DATABASE ofbizolap;
    GRANT ALL PRIVILEGES ON DATABASE ofbizolap TO ofbizolap;

    CREATE USER ofbiztenant WITH PASSWORD 'ofbiztenant';
    CREATE DATABASE ofbiztenant;
    GRANT ALL PRIVILEGES ON DATABASE ofbiztenant TO ofbiztenant;

    CREATE USER tenant1_user WITH PASSWORD 'tenant1_pass';
    CREATE DATABASE ofbiz_tenant001;
    CREATE DATABASE ofbizolap_tenant001;
    GRANT ALL PRIVILEGES ON DATABASE ofbiz_tenant001 TO tenant1_user;
    GRANT ALL PRIVILEGES ON DATABASE ofbizolap_tenant001 TO tenant1_user;

    CREATE USER tenant2_user WITH PASSWORD 'tenant1_pass';
    CREATE DATABASE ofbiz_tenant002;
    CREATE DATABASE ofbizolap_tenant002;
    GRANT ALL PRIVILEGES ON DATABASE ofbiz_tenant002 TO tenant2_user;
    GRANT ALL PRIVILEGES ON DATABASE ofbizolap_tenant002 TO tenant2_user;

EOSQL