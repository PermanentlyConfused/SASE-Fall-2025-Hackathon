#!/bin/bash

psql -U postgres -h localhost -p 5432 -f "./schema/setupSchema.sql" > SetupDB_output.log 2>&1

INSERT INTO Events (Category, Description, Address, Date,Time,Lat,Long) VALUES ('Food', 'Jernabi', '11 Maple St, Potsdam, NY 13676', Null , Null,  44.667987, -74.988479);
INSERT INTO Events (Category, Description, Address, Date,Time,Lat,Long) VALUES ('Food', 'Royal Indian Grill', '38 Market St, Potsdam, NY 13676', Null , Null,  44.6688102, -74.9864899);
INSERT INTO Events (Category, Description, Address, Date,Time,Lat,Long) VALUES ('Attractions', 'SLC Arts', '6-8 Raymond St, Potsdam, NY 13676', Null , Null,  44.6698599, -74.9901593);
INSERT INTO HomeProfile (Country, StateProvince, Town, Color,Lat,Long) VALUES ('United States', 'New York', 'Potsdam', 'white' ,44.6636318 , -74.9941057);