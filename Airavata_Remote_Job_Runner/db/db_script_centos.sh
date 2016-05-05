#!/bin/bash
service postgresql status
if [ "$?" -gt "0" ]
 then
        sudo yum -y update
        sudo yum -y install postgresql-client postgresql postgresql-contrib
        sudo -u postgres psql postgres -a -f /opt/scripts/airavata_ddl_20160321.sql
        sudo -u postgres psql postgres -a -f /opt/scripts/airavata_dml_20160321.sql
        sudo -u postgres psql postgres -c "ALTER USER Postgres WITH PASSWORD 'root';"
 fi
