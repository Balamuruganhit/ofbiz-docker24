# Create a Multiple Tenant In ofbiz

## Steps are follow to create a tenant

### Setup the database

    	*CREATE USER tenant1_user WITH PASSWORD 'tenant1_pass';
    	CREATE DATABASE ofbiz_tenant001;
    	CREATE DATABASE ofbizolap_tenant001;
    	GRANT ALL PRIVILEGES ON DATABASE ofbiz_tenant001 TO tenant1_user;
    	GRANT ALL PRIVILEGES ON DATABASE ofbizolap_tenant001 TO tenant1_user;

    	*CREATE USER tenant2_user WITH PASSWORD 'tenant1_pass';
    	CREATE DATABASE ofbiz_tenant002;
    	CREATE DATABASE ofbizolap_tenant002;
    	GRANT ALL PRIVILEGES ON DATABASE ofbiz_tenant002 TO tenant2_user;
    	GRANT ALL PRIVILEGES ON DATABASE ofbizolap_tenant002 TO tenant2_user;
    Above code is to create a db for each tenant to store respective data.

## Get ip of postgres

    	using this command to get "docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container_name_or_id>"

## Run the Gradlew setup for create multiple tenant\

		create tenant 1
		1.create a tenant using below command
			docker compose run --rm ofbiz createTenant -PtenantId=tenant001 -PtenantName="My Tenant 001" -PdomainName=tenant001.example.com -PtenantReaders=seed,seed-initial,ext -PdbPlatform=P -PdbIp=172.18.0.2 -PdbUser=tenant1_user -PdbPassword=tenant1_pass
		2.load the data into tenant db
			docker compose run --rm ofbiz loadTenant -PtenantId=tenant001 -PtenantReaders=seed,seed-initial,demo
		Create tenant 2
		1.create a tenant using below command
			docker compose run --rm ofbiz createTenant -PtenantId=tenant002 -PtenantName="My Tenant 002" -PdomainName=tenant002.example.com -PtenantReaders=seed,seed-initial,ext -PdbPlatform=P -PdbIp=172.18.0.2 -PdbUser=tenant2_user -PdbPassword=tenant1_pass
		2.load the data into tenant db
			docker compose run --rm ofbiz loadTenant -PtenantId=tenant001 -PtenantReaders=seed,seed-initial,demo

## Config the general.properties

    multipleTenant option set Y
