#!/bin/bash
# DATABASE HEALTH QUERY
/opt/mssql-tools/bin/sqlcmd -P ${MSSQL_PASSWORD} -S db -U ${MSSQL_USER}  -i /tmp/health.sql