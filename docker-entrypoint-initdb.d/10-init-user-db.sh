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

    CREATE USER ofb_tenant001 WITH PASSWORD 'ofbiz@tenant';
    CREATE DATABASE ofbiz_tenant001;
    CREATE DATABASE ofbizolap_tenant001;
    CREATE USER ofbizolap_tenant001 WITH PASSWORD 'ofbiz@tenant';
    GRANT ALL PRIVILEGES ON DATABASE ofbiz_tenant001 TO ofbizolap_tenant001;

    
EOSQL
EOSQL