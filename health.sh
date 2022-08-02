#!/bin/bash
# DATABASE HEALTH QUERY
/opt/mssql-tools/bin/sqlcmd -P ${MSSQL_PASSWORD} -S ${MSSQL_SERVER} -U ${MSSQL_USER} -d ${MSSQL_DATABASE}  -i /tmp/health.sql