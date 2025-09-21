DROP DATABASE home_db;
CREATE DATABASE home_db;
\c home_db;

CREATE TABLE Hobbies (
    HobbyID SERIAL PRIMARY KEY,
    HobbyName VARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE HomeProfile(
    HomeID SERIAL PRIMARY KEY,
    Country VARCHAR(100),
    StateProvince VARCHAR(100),
    Town VARCHAR(100) UNIQUE NOT NULL,
    Color VARCHAR(50),
    Lat NUMERIC(9,7),
    Lon NUMERIC(9,7)
);

CREATE TABLE SelectedProfile(
    HomeID INT REFERENCES HomeProfile(HomeID) ON DELETE CASCADE
);
INSERT INTO HomeProfile(HomeID, Country, StateProvince, Town, Color, Lat, Lon) 
VALUES (1, 'United States', 'NY', 'Potsdam', '#ffffff', 44.6642656, -74.972129);

INSERT INTO SelectedProfile (HomeID) VALUES (1);


CREATE TABLE HomeProfile_Hobbies (
    HomeID INT REFERENCES HomeProfile(HomeID) ON DELETE CASCADE,
    HobbyID INT REFERENCES Hobbies(HobbyID) ON DELETE CASCADE,
    PRIMARY KEY (HomeID, HobbyID)
);  

CREATE TABLE Utilities (
    UtilID SERIAL PRIMARY KEY,
    Company VARCHAR(100),
    PhoneNumber VARCHAR(50),
    UtilityType VARCHAR(50)
);

CREATE TABLE HomeProfile_Utilities (
    HomeID INT REFERENCES HomeProfile(HomeID) ON DELETE CASCADE,
    UtilID INT REFERENCES Utilities(UtilID) ON DELETE CASCADE,
    Payment BOOLEAN,
    PRIMARY KEY (HomeID, UtilID)
);

CREATE TABLE Events (
    EventID SERIAL PRIMARY KEY,
    Category TEXT NOT NULL,
    Description TEXT,
    Address TEXT,
    StartDate TIMESTAMP,
    EndDate TIMESTAMP,    
    Lat NUMERIC(9,7),
    Long NUMERIC(9,7)
);

CREATE TABLE Hobby_Events (
    HobbyID INT REFERENCES Hobbies(HobbyID) ON DELETE CASCADE,
    EventID INT REFERENCES Events(EventID) ON DELETE CASCADE,
    PRIMARY KEY (HobbyID, EventID)
);



INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (1, 'National Grid', '1-800-322-3223', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (2, 'Rochester Gas and Electric', '1-800-743-1701', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (3, 'NYS Electric and Gas', '800-572-1111, 800-572-1131, 800-600-2275', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (4, 'Central Hudson Gas and Electric', '845-452-2700, 800-942-8274', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (5, 'Orange and Rockland Utilities', '1-877-434-4100', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (6, 'Long Island Power Authority', '(516) 222-7700', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (7, 'Consolidated Edison', '1-800-752-6633', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (8, 'Municipal Utility: ROUSES POINT', '1-800-342-3377', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (9, 'Municipal Utility: MASSENA', '315-769-3588', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (10, 'Municipal Utility: PLATTSBURGH', '(518) 563-7704', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (11, 'Municipal Utility: LAKE PLACID', '518-523-2597', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (12, 'Municipal Utility: TUPPER LAKE', '518-359-9261', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (13, 'Municipal Utility: THERESA', '315-628-4425', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (14, 'Municipal Utility: PHILADELPHIA', '601-656-1121', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (15, 'Municipal Utility: BOONVILLE', '812-897-1230', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (16, 'Municipal Utility: HOLLEY', '(609) 267-0015, (609) 267-5420', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (17, 'Municipal Utility: SPENCERPORT', '(585) 352-4771', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (18, 'Municipal Utility: CHURCHVILLE', '(585) 442-7200, (585) 442-2009', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (19, 'Municipal Utility: SILVER SPRINGS', '(585) 493-2500', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (20, 'Municipal Utility: FAIRPORT', '585-223-9500', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (21, 'Municipal Utility: BERGEN', '201-422-0100', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (22, 'Municipal Utility: SHERRILL', '315-363-2440, 315-363-0031', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (23, 'Municipal Utility: AKRON', '(712) 568-2041', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (24, 'Municipal Utility: SOLVAY', '315-488-4549, 315-468-6229', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (25, 'Municipal Utility: FRANKFORT', '(765) 659-3361', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (26, 'Municipal Utility: ILION', '1-800-342-3355', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (27, 'Municipal Utility: MOHAWK', '315-866-4312, 315-866-6659', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (28, 'Municipal Utility: SKANEATELES', '(315) 685-5628', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (29, 'Municipal Utility: HAMILTON', '(609) 625-1872', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (30, 'Municipal Utility: GREEN ISLAND', '518-273-2201', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (31, 'Municipal Utility: PENN YAN', '315-536-3374', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (32, 'Municipal Utility: SHERBURNE', '(607) 674-2300, (607) 316-8803', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (33, 'Municipal Utility: CASTILE', '716-493-5340', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (34, 'Municipal Utility: RICHMONDVILLE', '518-294-6681', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (35, 'Municipal Utility: GROTON', '860-446-4000', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (36, 'Municipal Utility: ARCADE', '(585) 496-7444, (585) 496-7444, 800-662-1220', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (37, 'Municipal Utility: SPRINGVILLE', '801-489-2752', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (38, 'Municipal Utility: BROCTON', '716-792-4160', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (39, 'Municipal Utility: MARATHON', '(305) 289-5005, (305) 517-6764', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (40, 'Municipal Utility: WESTFIELD', '317-924-3311', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (41, 'Municipal Utility: WATKINS GLEN', '(607) 351-8464', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (42, 'Municipal Utility: BATH', '(607) 664-9103', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (43, 'Municipal Utility: MAYVILLE', '1-866-917-7368', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (44, 'Municipal Utility: ANGELICA', '(585) 466-7431', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (45, 'Municipal Utility: GREENE', '607-656-4500', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (46, 'Municipal Utility: LITTLE VALLEY', '716-938-9151, 716-938-9154', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (47, 'Municipal Utility: SALAMANCA', '716-945-3130, 716-945-3490', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (48, 'Municipal Utility: JAMESTOWN', '(765) 676-6331', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (49, 'Municipal Utility: ANDOVER', '(316) 733-1303', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (50, 'Municipal Utility: WELLSVILLE', '1-877-885-7968', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (51, 'Municipal Utility: ENDICOTT', '(607) 757-2411', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (52, 'Municipal Utility: WAVERLY', '319-559-2000', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (53, 'Municipal Utility: FISHERS ISLAND', '(631) 788-7251', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (54, 'Municipal Utility: GREENPORT', '(631) 477-1748', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (55, 'Municipal Utility: ROCKVILLE CENTRE', '(516) 678-9300, (516) 678-9323, (516) 678-9224', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (56, 'Municipal Utility: FREEPORT', '815.233.0111, 815.233.0711', 'electric');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (57, 'Bath Electric Gas and Water', '607-776-3072', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (58, 'Central Hudson Gas and Electric', '845-452-2700, 800-942-8274', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (59, 'Corning Natural Gas', '(607) 936-3755, (800) 834-2134', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (60, 'Fillmore Gas Company', '585-567-2272', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (61, 'NYS Electric and Gas', '800-572-1111, 800-572-1131, 800-600-2275', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (62, 'National Fuel Gas Distribution', '(814) 871-8200', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (63, 'National Grid', '1-800-322-3223', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (64, 'Orange and Rockland Utilities', '1-877-434-4100', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (65, 'Reserve Gas Company', '(716) 937-9484', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (66, 'Rochester Gas and Electric', '1-800-743-1701', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (67, 'St. Lawrence Gas', '315-769-3511', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (68, 'Valley Energy', '1-800-998-4427, 570-888-9664', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (69, 'Woodhull Municipal Gas Company', '607-458-5178', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (70, 'Chautauqua Utilities, Inc.', '716-456-1061', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (71, 'NULL', '716-456-1061', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (72, 'National Grid - NYC', '718-643-4050', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (73, 'National Grid - Long Island', '718-643-4050', 'gas');
INSERT INTO Utilities (UtilID, Company, PhoneNumber, UtilityType) VALUES (74, 'Consolidated Edison', '1-800-752-6633', 'gas');

INSERT INTO HomeProfile_Utilities (HomeID, UtilID, Payment) VALUES ('1', '1', 'FALSE'); 
INSERT INTO HomeProfile_Utilities (HomeID, UtilID, Payment) VALUES ('1', '67', 'FALSE');
