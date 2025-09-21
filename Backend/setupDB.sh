#!/bin/bash

psql -U postgres -h localhost -p 5432 -f "./schema/setupSchema.sql" > SetupDB_output.log 2>&1