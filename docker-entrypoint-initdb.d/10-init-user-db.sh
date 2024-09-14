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
    CREATE DATABASE tenant1_db;
    
    GRANT ALL PRIVILEGES ON DATABASE tenant1_db TO tenant1_user;

    CREATE USER tenant2_user WITH PASSWORD 'tenant1_pass';
    CREATE DATABASE tenant2_db;
    GRANT ALL PRIVILEGES ON DATABASE tenant2_db TO tenant2_user;

EOSQL