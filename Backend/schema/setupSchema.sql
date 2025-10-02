DROP DATABASE home_db;
CREATE DATABASE home_db;
\c home_db;


CREATE TABLE HomeProfile (
    HomeID SERIAL PRIMARY KEY,
    Country VARCHAR(100),
    StateProvince VARCHAR(100),
    Town VARCHAR(100) UNIQUE NOT NULL,
    Hobbies TEXT,
    Color VARCHAR(50), --Maybe remove this shit later if lazy :D
    Lat NUMERIC(9,7),
    Long NUMERIC(9,7)
);

--If we were to scale this application then we would modify this into a Users table and their respective selected Profile.
CREATE TABLE SelectedProfile(
    HomeID INT 
);

INSERT INTO SelectedProfile (HomeID) VALUES (NULL);

CREATE TABLE Hobbies (
    HobbyID SERIAL PRIMARY KEY,
    HobbyName VARCHAR(100) UNIQUE NOT NULL
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
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (1,	'Family Friendly');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (2,	'Sports Matches');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (3,	'Music Concerts');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (4,	'Art Exhibitions');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (5,	'Festivals and Fairs');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (6,	'Farmers Markets');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (7,	'Performances');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (8,	'Gaming Events');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (9,	'Outdoor Activities');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (10,	'Film Screenings');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (11,	'Book Fairs');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (12,	'Craft Workshops');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (13,	'Charity');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (14,	'Yoga');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (15,	'Gardening');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (16,	'Historical Tours');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (17,	'Science Fairs');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (18,	'Technology Expos');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (19,	'Business Networking');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (20,	'Career Fairs');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (21,	'Holiday Parades');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (22,	'Cultural Festivals');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (23,	'Religious Services');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (24,	'Political Rallies');
INSERT INTO Hobbies (HobbyID,HobbyName) VALUES (25,	'Community Meetings');


-- ALL INSERTS BELOW ARE FOR CONVIENCE, THESE WILL BE PULLED FROM API 

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


-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'STEM-CONNECT 2025', '1000 Fort Duquesne Blvd, Pittsburgh, PA 15222', 'October 2, 2025 04:30 PM', 'October 4, 2025 05:30 PM', 40.445782 , -79.99651);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Highlights of the Potsdam Prints Collection', '44 Pierrepont Ave, Potsdam, NY 13676, United States', 'September 24, 2025 02:00 PM', 'September 24, 2025 04:00 PM', 44.6619721, -74.9757728);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'SUNY Potsdam Figure Skating Club Practice', '005 Tupper Lake Dr, Potsdam, NY 13676, United States', 'September 24, 2025 09:45 PM', 'September 24, 2025 10:45 PM', 44.6605374, -74.9672573);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Men''s Rugby Practice', 'MAX-HL RUGBY - Rugby Field # 2', 'September 24, 2025 05:00 PM', 'September 24, 2025 06:00 PM', NULL, NULL);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '20 Main St, Potsdam, NY 13676, United States in Potsdam to show Sorry, Baby', '20 Main St, Potsdam, NY 13676, United States (unsure)', 'September 22, 2025', NULL, 44.6689891, -74.98567);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Classic car show', '8 Maple St, Potsdam, NY 13676, United States', 'September 27, 2025 10:00 AM', 'September 27, 2025 03:00 PM', 44.66730949999999, -74.98776459999999);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Nels Cline, member of the indie band Wilco, to join 2 Park St STE1, Potsdam, NY 13676, United States performance', '2 Park St STE1, Potsdam, NY 13676, United States (unsure)', 'September 23, 2025', NULL, 44.669362, -74.982714);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '10 Raymond St, Potsdam, NY 13676, United States to host hands-on STEM program', '10 Raymond St, Potsdam, NY 13676, United States (unsure)', 'September 20, 2025', NULL, 44.6698799, -74.98776240000001);  
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Creative Partner Showcase Exhibition', '6 8 Raymond St, Potsdam, NY 13676, USA', '2025-09-11 00:00:00', NULL, 44.66991429999999, -74.9875764);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Rural Recreation Association 2025 Fall Summit', '71 Cornelia St W, Smiths Falls, ON K7A 1T7, Canada (unsure)', '2025-10-16 09:00:00', NULL, 44.905918, -76.0272312);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '2025 South Dundas Awards of Excellence Gala', '4421 Stormont, Dundas, And Glengarry County Rd 16, Brinston, ON K0E 1C0, Canada', '2025-10-24 18:15:00', NULL, 44.92303039999999, -75.3465605);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Peace Pole Ceremony', '99 Raymond St, Potsdam, NY 13676, United States', 'September 21, 2025 3:00 PM', NULL, 44.669536, -74.98966600000001);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Annual Cabbage Roll Sale', '39 W Orvis St, Massena, NY 13662, United States', 'September 20, 2025 10:00 AM', 'September 20, 2025 2:00 PM', 44.93041729999999, -74.8944581);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Community shred day', '6950 NY-56, Potsdam, NY 13676, United States', 'September 20, 2025 9:00 AM', 'September 20, 2025 1:00 PM', 44.7133062, -74.986884);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'End of the Summer Bash', '10 Maple St, Norwood, NY 13668, United States (unsure)', 'September 20, 2025 4:00 PM', 'September 20, 2025 6:00 PM', 44.74396, -75.002804);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Howl Story Slam Live!', 'Potsdam, NY 13676, USA (unsure)', 'September 9, 2025', NULL, 44.6697805, -74.9813084);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Music of the Night', '999 Charley Hill Rd, Schroon Lake, NY 12870, United States (unsure)', 'September 7, 2025', NULL, 43.8200606, -73.8037284);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Irish Afternoon', 'Fort Edward, NY 12828, USA (unsure)', 'September 7, 2025', NULL, 43.2670175, -73.5845597);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Great Adirondack Moose Festival', 'Indian Lake, Ohio, USA (unsure)', 'September 26, 2025', 'September 28, 2025', 40.4990656, -83.8950042);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Old Forge Oktoberfest', 'Old Forge, NY, USA (unsure)', 'September 26, 2025', 'September 27, 2025', 43.7100885, -74.9734809);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Music of the Night', '207 Glen St, Glens Falls, NY 12801, United States (unsure)', 'September 26, 2025', NULL, 43.3103261, -73.6450851);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Music with Joey Blake and David Worm', 'Ogdensburg Dr, Potsdam, NY 13676, United States (unsure)', 'September 20, 2025 08:00 AM', 'September 20, 2025 09:00 PM', 44.6642656, -74.972129);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Saturday Visit Day', '44 Pierrepont Ave, Potsdam, NY 13676, United States (unsure)', 'September 20, 2025 10:00 AM', 'September 20, 2025 12:00 PM', 44.661522, -74.973023);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Weekly Bible Study', 'Potsdam, NY 13676, United States (unsure)', 'September 20, 2025 11:00 AM', 'September 20, 2025 01:00 PM', 44.6623448, -74.97407869999999);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Alumni Night at the Ski Jumps', '5486 Cascade Rd, Lake Placid, NY 12946, United States', 'September 20, 2025 05:00 PM', 'September 20, 2025 07:00 PM', 44.2599124, -73.9664465);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'THE PHANTOM FIXERS (A STAGED READING OF A FULL-LENGTH PLAY)', '2 Park St STE1, Potsdam, NY 13676, United States (unsure)', 'September 7, 2 PM', NULL, 44.669362, -74.982714);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Makers Market Night!', '140 New Scotland Ave, Albany, NY 12208, United States (unsure)', '2025-09-19 00:00:00', '2025-09-19 23:59:59', 42.6525561, -73.78239049999999);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Porchfest Schenectady', 'Schenectady, NY, USA (unsure)', '2025-09-20 00:00:00', '2025-09-20 23:59:59', 42.8143509, -73.93874199999999);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Tournament for charity', '151 5th St, Eagle Bay, NY 13331, USA', 'September 11, 2024 12:00 AM', 'September 12, 2024 12:00 AM', 43.704759, -74.99705290000001);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Troy Country Folk Art Show and Artisan Market', '80 Vandenburgh Ave, Troy, NY 12180, United States', 'September 5, 2025', 'September 7, 2025', 42.6958308, -73.68238529999999);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Craryville Food Truck and Craft Beer Festival', '44 Golf Course Rd, Craryville, NY 12521, United States', 'September 20, 2025', 'September 21, 2025', 42.1525417, -73.6028789);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Webster Garlic Fest', '1350 Chiyoda Dr, Webster, NY 14580, United States', 'September 6, 2025', 'September 7, 2025', 43.2279663, -77.42171760000001);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Foods', 'Jernabi', '11 Maple St, Potsdam, NY 13676', Null , Null,  44.667987, -74.988479);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Foods', 'Royal Indian Grill', '38 Market St, Potsdam, NY 13676', Null , Null,  44.6688102, -74.9864899);
-- INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Attractions', 'SLC Arts', '6-8 Raymond St, Potsdam, NY 13676', Null , Null,  44.6698599, -74.9901593);

-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (1, 2);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (2, 4);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (3, 2);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (4, 2);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (5, 10);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (6, 5);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (7, 3);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (8, 17);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (9, 4);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (10, 25);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (11, 19);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (12, 25);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (13, 13);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (14, 25);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (15, 5);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (16, 7);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (17, 3);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (18, 22);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (19, 5);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (20, 22);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (21, 3);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (22, 3);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (23, 1);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (24, 23);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (25, 2);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (26, 7);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (27, 5);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (28, 5);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (29, 13);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (30, 4);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (31, 5);
-- INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (32, 5);

INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Fall Fest 2025', '50 Pine Creek Rd, McKnight, PA 15237, USA', '2025-10-11 13:00:00', NULL,  40.585721,  -80.0468308);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'O''Noir: The Experience', 'Preserving Underground (unsure), West New Kensington, PA', '2025-10-10 18:30:00', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'RAPS Convergence MedTech Mixer', '940 Penn Ave, Pittsburgh, PA 15222, USA', '2025-10-08 17:00:00', NULL,  40.444102,  -79.996563);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Pittsburgh WITCON 2025: Thrive Forward, Shape Tomorrow', 'One Bigelow Sq, Pittsburgh, PA 15219, United States', '2025-10-08 08:00:00', NULL,  40.4407079,  -79.9940657);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Dark Angel', '120 51st St, Pittsburgh, PA 15201, USA', '2025-10-01 18:30:00', NULL,  40.4786517,  -79.9566818);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'The Waterview Band', 'City Winery - Pittsburgh (unsure), Pittsburgh, PA', '2025-10-02 19:30:00', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'My Life - Billy Joel Tribute', 'Jergel''s Rhythm Grille (unsure), Pittsburgh, PA', '2025-10-02 19:30:00', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Golden Apples', 'Palace Theatre (unsure), Pittsburgh, PA', '2025-10-02 19:30:00', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Killer Queen', 'Bottlerocket Social Hall (unsure), Pittsburgh, PA', '2025-10-02 20:00:00', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Pittsburgh Panthers Football', 'Gameday Hospitality - Pittsburgh (unsure), Pittsburgh, PA', '2025-10-03 21:00:00', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Gospel Melodies Day Party & Brunch', 'City Winery - Pittsburgh (unsure), Pittsburgh, PA', '2025-10-04 03:30:00', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Duquesne Dukes Football', 'Rooney Field (unsure), Pittsburgh, PA', '2025-10-04 12:00:00', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'The Waterview Band', '1627 Smallman St, Pittsburgh, PA 15222, United States (unsure)', 'Oct 2, 2025 7:30 PM', NULL,  40.4499809,  -79.98795419999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'My Life - Billy Joel Tribute', '103 Slade Lane, Warrendale, PA 15086, United States (unsure)', 'Oct 2, 2025 7:30 PM', NULL,  40.6546862,  -80.0822189);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Ashland Craft', '21 W Otterman St, Greensburg, PA 15601, United States (unsure)', 'Oct 2, 2025 7:30 PM', NULL,  40.303661,  -79.54550499999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Golden Apples', '5024 Curry Rd, Pittsburgh, PA 15236, United States (unsure)', 'Oct 2, 2025 8:00 PM', NULL,  40.3498351,  -79.9962386);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Killer Queen', '1226 Arlington Ave, Pittsburgh, PA 15210, United States (unsure)', 'Oct 2, 2025 8:00 PM', NULL,  40.4210491,  -79.9921119);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Masters of Illusion', '1015 Main St, Wheeling, WV 26003, United States (unsure)', 'Oct 2, 2025 8:00 PM', NULL,  40.0700819,  -80.72428769999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'The Callous Daoboys', '1101 5th Ave Basement, New Kensington, PA 15068, United States (unsure)', 'Oct 1, 2025 6:45 PM', NULL,  40.568349,  -79.766277);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Ladies and Tangents', '166 East Bridge St, Homestead, PA 15120, United States (unsure)', 'Oct 1, 2025 7:00 PM', NULL,  40.4089383,  -79.9149412);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'The Original Kenny Rogers Band', '21 W Otterman St, Greensburg, PA 15601, United States (unsure)', 'Oct 1, 2025 7:00 PM', NULL,  40.303661,  -79.54550499999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Joe Torry', '1627 Smallman St, Pittsburgh, PA 15222, United States (unsure)', 'Oct 1, 2025 7:30 PM', NULL,  40.4499809,  -79.98795419999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Alexandra Kay', '400 N Shore Dr, Pittsburgh, PA 15212, USA', 'Oct 1, 2025 7:30 PM', NULL,  40.446102,  -80.0123564);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Pool Kids', '4053 Butler St, Pittsburgh, PA 15201, United States (unsure)', 'Oct 1, 2025 8:00 PM', NULL,  40.4693859,  -79.9615871);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Gottmik', '425 Chartiers Ave, McKees Rocks, PA 15136, United States (unsure)', 'Oct 1, 2025 8:00 PM', NULL,  40.4646184,  -80.0589552);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Dia de los Muertos Halloween Party', '405 Wood St, Pittsburgh, PA 15222, United States (unsure)', 'Oct 31, 2025 7:00 PM', 'Nov 1, 2025 12:00 AM',  40.4395984,  -80.0014058);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'The Assembly: A Vintage Makers Market', '6425 Penn Ave, Pittsburgh, PA 15206, United States', '2025-09-21 12:00 PM', '2025-09-21 06:00 PM',  40.4575672,  -79.91667699999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Movie Night on the Lawn', '6425 Penn Ave, Pittsburgh, PA 15206, United States', '2025-09-21 07:30 PM', NULL,  40.4573361,  -79.9161194);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Weekly Yoga Session', '6425 Penn Ave, Pittsburgh, PA 15206, United States', '2025-09-20 10:30 AM', '2025-09-20 11:30 AM',  40.4573361,  -79.9161194);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Live Music on the Lawn', '6425 Penn Ave, Pittsburgh, PA 15206, United States', '2025-09-20 06:00 PM', '2025-09-20 09:00 PM',  40.4573361,  -79.9161194);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Monster Pumpkins Festival', '2875 Railroad St, Pittsburgh, PA 15222, United States (unsure)', 'October 18, 2024', 'October 19, 2024',  40.4589935,  -79.9763261);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Night of 1,000 Skulls', '117 Sandusky St, Pittsburgh, PA 15212, United States (unsure)', 'October 24, 2024 8:00pm', NULL,  40.448459,  -80.0025189);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Fall Flower Show: Visions of Japan', '1 Schenley Drive, Pittsburgh, PA 15213, United States (unsure)', 'October 4, 2024', 'October 26, 2024',  40.4390155,  -79.947951);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Intro to Mountain Biking', '230 S Bouquet St, Pittsburgh, PA 15213, United States (unsure)', 'October 1, 2025 4:00pm', 'October 1, 2025 5:30pm',  40.44169309999999,  -79.95448309999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'A Night of Unleashed Wonder', '230 S Bouquet St, Pittsburgh, PA 15213, United States (unsure)', 'October 2, 2025 7:00pm', 'October 2, 2025 8:30pm',  40.4413729,  -79.9545701);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'VMI/HVI Research Conference', '203 Lothrop St, Pittsburgh, PA 15213, United States (unsure)', 'October 1, 2025 12:00pm', 'October 1, 2025 1:00pm',  40.4418436,  -79.9617201);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'The Language of Flowers', 'The University Store on Fifth, C4C: The Workshop (lower level) (unsure)', 'October 9, 2025 3:30pm', 'October 9, 2025 5:00pm', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Pittsburgh Coffee & Chocolate Festival', '209 Mall Plaza Blvd, Monroeville, PA 15146, USA', 'October 25, 2025', 'October 26, 2025',  40.4324939,  -79.7914449);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Fall Migration Festival', '120 Forsythe Rd, Valencia, PA 16059, United States (unsure)', 'September 21, 2025', NULL,  40.7035034,  -79.9573616);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'LA BOHï¿½ME', '237 7th St, Pittsburgh, PA 15222, United States (unsure)', 'October 18, 2025', NULL,  40.4429853,  -80.000016);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Pittsburgh, PA, USA Marathon Weekend', 'Pittsburgh, PA, USA (unsure)', 'May 4, 2025', NULL,  40.4386612,  -79.99723519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'JD McPherson', '4053 Butler St, Pittsburgh, PA 15201, United States', '2025-12-16 00:00:00', NULL,  40.4693859,  -79.9615871);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Bailey Zimmerman', '3719 Terrace St, Pittsburgh, PA 15261, United States', '2026-04-11 00:00:00', NULL,  40.4439212,  -79.96229439999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Trans-Siberian Orchestra', '1001 Fifth Ave, Pittsburgh, PA 15219, United States', '2025-12-20 00:00:00', NULL,  40.4393097,  -79.98955289999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'PVRIS', '425 Chartiers Ave, McKees Rocks, PA 15136, United States', '2025-12-02 00:00:00', NULL,  40.4646184,  -80.0589552);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Knox', '400 Lincoln Ave, Millvale, PA 15209, United States', '2025-11-07 00:00:00', NULL,  40.4808185,  -79.97224949999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Patrick Watson', 'Carnegie Lecture Hall, Pittsburgh, PA 15213, United States', '2026-03-30 00:00:00', NULL,  40.4426657, -79.9499166);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'tobyMac', '3719 Terrace St, Pittsburgh, PA 15261, United States', '2026-03-26 00:00:00', NULL,  40.4439212,  -79.96229439999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'ERNEST', '425 Chartiers Ave, McKees Rocks, PA 15136, United States', '2026-03-14 00:00:00', NULL,  40.4646184,  -80.0589552);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Noah Gundersen', '5024 Curry Rd, Pittsburgh, PA 15236, United States', '2025-11-18 00:00:00', NULL,  40.3498351,  -79.9962386);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'The Barr Brothers', '4053 Butler St, Pittsburgh, PA 15201, United States', '2026-02-16 00:00:00', NULL,  40.4693859,  -79.9615871);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'ULTRA SUNN', '242 51st St, Pittsburgh, PA 15201, United States', '2026-05-09 00:00:00', NULL,  40.478707,  -79.956419);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'IN-ZO', '400 N Shore Dr, Pittsburgh, PA 15212, United States', '2026-02-25 00:00:00', NULL,  40.4461361,  -80.0122828);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Rhett Miller', '56 S 12th St, Pittsburgh, PA 15203, United States', '2025-12-13 00:00:00', NULL,  40.4289443,  -79.98654429999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'mgk', '665 PA-18, Burgettstown, PA 15021, United States', '2026-06-10 00:00:00', NULL,  40.4194104,  -80.4341644);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Jason Aldean', '720 Curtin Rd, State College, PA 16801, United States', '2026-01-29 00:00:00', NULL,  40.8085471,  -77.85546389999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Ashnikko', '400 N Shore Dr, Pittsburgh, PA 15212, United States', '2026-05-12 00:00:00', NULL,  40.4461361,  -80.0122828);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Atlas Genius', '4053 Butler St, Pittsburgh, PA 15201, United States', '2025-11-02 00:00:00', NULL,  40.4693859,  -79.9615871);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Pittsburgh Arts and Crafts Holiday Spectacular', 'Monroeville, PA, USA (unsure)', '2025-11-21 00:00:00', '2025-11-23 00:00:00',  40.4211798,  -79.7881024);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Wild Lights at Elmood Park Zoo I', 'Norristown, PA, USA (unsure)', '2025-11-21 00:00:00', '2025-11-23 00:00:00',  40.121497,  -75.3399048);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'LumiNature at the Philadelphia Zoo I', 'Philadelphia, PA, USA (unsure)', '2025-11-21 00:00:00', '2025-11-23 00:00:00',  39.9525839,  -75.1652215);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Peoples Gas Holiday Market I', 'Pittsburgh, PA, USA (unsure)', '2025-11-21 00:00:00', '2025-11-23 00:00:00',  40.4386612,  -79.99723519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Reading Blues Fest', 'Reading, PA, USA (unsure)', '2025-11-21 00:00:00', '2025-11-23 00:00:00',  40.3369615,  -75.9214385);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Holiday Lights at Kennywood II', 'West Mifflin, PA, USA (unsure)', '2025-11-21 00:00:00', '2025-11-23 00:00:00',  40.3634026,  -79.86643749999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Wine ''n Shine Pierogies Palooza: Altoona', 'Altoona, PA, USA (unsure)', '2025-11-22 00:00:00', NULL,  40.5186809,  -78.3947359);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Jolly Jamboree', 'Elysburg, PA 17824, USA (unsure)', '2025-11-22 00:00:00', NULL,  40.86453059999999,  -76.5524554);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Greensburg Night Market II', 'Greensburg, PA 15601, USA (unsure)', '2026-02-26 00:00:00', NULL,  40.3014581,  -79.5389289);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Cardboard Classic and Mountainfest', 'Scranton, PA, USA (unsure)', '2026-02-27 00:00:00', '2026-02-28 00:00:00',  41.410314,  -75.661099);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Mac and Cheese Fest', 'Bloomsburg, PA 17815, USA (unsure)', '2026-02-28 00:00:00', NULL,  41.003698,  -76.4549457);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Ice and Fire Festival', 'Harrisburg, PA, USA (unsure)', '2026-02-28 00:00:00', NULL,  40.2731911,  -76.8867008);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Pittsburgh Chocolate, Wine and Whiskey Festival', 'Pittsburgh, PA, USA (unsure)', '2026-02-28 00:00:00', NULL,  40.4386612,  -79.99723519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Witches'' Midnight Market', 'Lehighton, PA 18235, USA (unsure)', '2026-10-25 00:00:00', NULL,  40.8337029, -75.7138008);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Haven Wicked Wine Festival', 'Lock Haven, PA 17745, USA (unsure)', '2026-10-25 00:00:00', NULL,  41.1370133,  -77.4469263);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'StoOktoberfest at Blue Sparrow Farm', 'Milton, PA, USA (unsure)', '2026-10-25 00:00:00', NULL,  41.0120296,  -76.8477412);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Taste of the Philippines USA', 'Philadelphia, PA, USA (unsure)', '2026-10-25 00:00:00', NULL,  39.9525839, -75.1652215);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Trax Farm Fall Festival VI', 'Finleyville, PA 15332, USA (unsure)', '2026-10-25 00:00:00', '2026-10-26 00:00:00',  40.2522922,  -80.0028294);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Hazle Township Fall Festival and Trail of Treats', 'Hazle Township, PA, USA (unsure)', '2026-10-25 00:00:00', '2026-10-26 00:00:00',  40.9568399,  -76.02758589999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Pennsylvania Renaissance Faire XI', 'Manheim, PA 17545, USA (unsure)', '2026-10-25 00:00:00', '2026-10-26 00:00:00',  40.16342789999999,  -76.3949614);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Pittsburgh Coffee and Chocolate Festival', 'Monroeville, PA, USA (unsure)', '2026-10-25 00:00:00', '2026-10-26 00:00:00',  40.4211798,  -79.7881024);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Reel Q Pittsburgh, PA, USA LGBTQ Film Festival', 'Pittsburgh, PA, USA (unsure)', '2025-10-03 00:00:00', '2025-10-11 00:00:00',  40.4386612,  -79.99723519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Upchuck', '1226 Arlington Ave, Pittsburgh, PA 15210, United States (unsure)', '2025-10-17 00:00:00', NULL,  40.4210491,  -79.9921119);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'All Time Low, Mayday Parade, Four Year Strong', 'UPMC Events Center, 6001 University Blvd, Moon Township, PA 15108, United States (unsure)', '2025-11-19 00:00:00', NULL,  40.5202293,  -80.2147614);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Macy Gray', '510 E 10th Ave, Munhall, PA 15120, United States (unsure)', '2025-11-19 00:00:00', NULL,  40.4070139,  -79.902948);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Sons of Legion', '4053 Butler St, Pittsburgh, PA 15201, United States (unsure)', '2025-11-19 00:00:00', NULL,  40.4693859,  -79.9615871);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Being Dead', '1226 Arlington Ave, Pittsburgh, PA 15210, United States (unsure)', '2025-11-19 00:00:00', NULL,  40.4210491,  -79.9921119);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Southall, Marfa', '103 Slade Lane, Warrendale, PA 15086, United States (unsure)', '2025-11-19 00:00:00', NULL,  40.6546862,  -80.0822189);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Zakk Sabbath, Bonfire, Dark Chapel', '301 Napoleon St, Johnstown, PA 15901, United States (unsure)', '2025-11-19 00:00:00', NULL,  40.3237974,  -78.92336879999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Wednesday, Friendship, Daffo', '425 Chartiers Ave, McKees Rocks, PA 15136, United States (unsure)', '2025-11-20 00:00:00', NULL,  40.4646184,  -80.0589552);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Ezra Ray Hart', '777 Casino Dr, Pittsburgh, PA 15212, United States (unsure)', '2025-11-20 00:00:00', NULL,  40.4478179,  -80.023202);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Rene Vaca', '425 Chartiers Ave, McKees Rocks, PA 15136, United States (unsure)', '2025-11-23 00:00:00', NULL,  40.4646184,  -80.0589552);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Elijah, Royale Lynn, Never Easy', '5024 Curry Rd, Pittsburgh, PA 15236, United States (unsure)', '2025-11-23 00:00:00', NULL,  40.3498351,  -79.9962386);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Maia Sharp & Bill Deasy', '1627 Smallman St, Pittsburgh, PA 15222, United States (unsure)', '2025-11-23 00:00:00', NULL,  40.4499809,  -79.98795419999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Maddy Walsh & the Blind Spots', '313 North Ave, Pittsburgh, PA 15209, United States (unsure)', '2025-11-23 00:00:00', NULL,  40.482127,  -79.9741133);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Sevendust, Cory Marks', '400 N Shore Dr, Pittsburgh, PA 15212, United States (unsure)', '2025-11-24 00:00:00', NULL,  40.4461361,  -80.0122828);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Waterparks, Chloe Moriondo', '400 N Shore Dr, Pittsburgh, PA 15212, United States (unsure)', '2025-11-25 00:00:00', NULL,  40.4461361,  -80.0122828);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Sanguisugabogg, Despised Icon, Defeated Sanity, Corpse Pile', '425 Chartiers Ave, McKees Rocks, PA 15136, United States (unsure)', '2025-11-25 00:00:00', NULL,  40.4646184,  -80.0589552);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Boz Skaggs', '21 W Otterman St, Greensburg, PA 15601, United States (unsure)', '2025-11-25 00:00:00', NULL,  40.303661,  -79.54550499999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Bit Brigade', '5024 Curry Rd, Pittsburgh, PA 15236, United States (unsure)', '2025-11-25 00:00:00', NULL,  40.3498351,  -79.9962386);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'ASCEND QFTW (Queer, Femme, Trans, Women) Affinity Session', '2141 Mary St, Pittsburgh, PA 15203, United States (unsure)', '2025-07-19 20:00:00', NULL,  40.4262792,  -79.9755136);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Pittsburgh StepTrek on the South Side', 'South Side Flats, Pittsburgh, PA 15203, USA (unsure)', '2024-10-04 10:00:00', '2024-10-04 14:00:00',  40.42923589999999,  -79.9858859);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Reel Q Film Festival', '2815 Penn Ave, Pittsburgh, PA 15222, United States (unsure)', '2024-10-03 00:00:00', '2024-10-11 23:59:00',  40.4573138,  -79.97537460000001);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Pittsburgh, PA, USA''s top events', 'Pittsburgh, PA, USA (unsure)', '2025-10-02 00:00:00', '2025-12-21 00:00:00',  40.4386612,  -79.99723519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Ben Schonberger: Hi-NRG', '707 Penn Ave, Pittsburgh, PA 15222, United States (unsure)', '2025-07-25 00:00:00', '2026-02-22 00:00:00',  40.443462,  -79.9999433);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Celebrating 45 Years of CAPA: Alumni and Faculty Exhibition', '812 Liberty Ave, Pittsburgh, PA 15222, United States (unsure)', '2025-08-29 00:00:00', '2026-01-25 00:00:00',  40.4427064,  -79.9983874);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Frank Lloyd Wright''s Southwestern Pennsylvania: The Pittsburgh Projects', '820 Liberty Ave, Pittsburgh, PA 15222, United States (unsure)', '2025-10-24 00:00:00', '2026-05-10 00:00:00',  40.44276929999999,  -79.9981477);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Michael Zagaris: 60 Years of NFL Photography', '707 Penn Ave, Pittsburgh, PA 15222, United States (unsure)', '2026-04-17 00:00:00', '2026-11-08 00:00:00',  40.443462,  -79.9999433);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Sharmistha Ray: Emergent Realties', '601 Wood St, Pittsburgh, PA 15222, United States (unsure)', '2025-12-12 00:00:00', '2026-07-05 00:00:00',  40.4422596,  -79.9995138);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Eradicate Hate 2025', 'Pittsburgh, PA 15222, United States (unsure)', '2025-09-15 00:00:00', '2025-09-17 00:00:00',  40.4464771,  -79.99602519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'The Pokï¿½mon Company International- 2026 Regional', 'Pittsburgh, PA 15222, United States (unsure)', '2025-09-19 00:00:00', '2025-09-21 00:00:00',  40.4464771,  -79.99602519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Pittsburgh Heart Team Summit 2025', 'Pittsburgh, PA 15222, United States (unsure)', '2025-09-19 00:00:00', NULL,  40.4464771,  -79.99602519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Dhol Baaje - Ritu''s Garba Event 2025', 'Pittsburgh, PA 15222, United States (unsure)', '2025-09-20 00:00:00', NULL,  40.4464771,  -79.99602519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'TrueSense Marketing Homecoming 2025', 'Pittsburgh, PA 15222, United States (unsure)', '2025-09-23 00:00:00', '2025-09-25 00:00:00',  40.4464771,  -79.99602519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'An Evening with Lech Walesa, Nobel Peace Prize Winner and Former President of Poland 2025', 'Pittsburgh, PA 15222, United States (unsure)', '2025-09-26 00:00:00', NULL,  40.4464771,  -79.99602519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Coast Collective - Travelers Show - Pittsburgh 2025', 'Pittsburgh, PA 15222, United States (unsure)', '2025-09-28 00:00:00', '2025-09-29 00:00:00',  40.4464771,  -79.99602519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Investment Casting Technical Conference and Exposition 2025', 'Pittsburgh, PA 15222, United States (unsure)', '2025-09-29 00:00:00', '2025-10-01 00:00:00',  40.4464771,  -79.99602519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'STEM-CONNECT 2025', '1000 Fort Duquesne Blvd, Pittsburgh, PA 15222', '2025-10-02 00:00:00', '2025-10-04 00:00:00',  40.445782 , -79.99651);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Regulatory Affairs Professionals Society - RAPS Converge 2025', 'Pittsburgh, PA 15222, United States (unsure)', '2025-10-07 00:00:00', '2025-10-09 00:00:00',  40.4464771,  -79.99602519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'RV Fall Show 2025', 'Pittsburgh, PA 15222, United States (unsure)', '2025-10-10 00:00:00', '2025-10-12 00:00:00',  40.4464771,  -79.99602519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '2025 Cleancurrents Annual Tradeshow', 'Pittsburgh, PA 15222, United States (unsure)', '2025-10-14 00:00:00', '2025-10-16 00:00:00',  40.4464771,  -79.99602519999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '1061 Washington Ave, Carnegie, PA 15106, United States: Science Communication Workshop', '1061 Washington Ave, Carnegie, PA 15106, United States (unsure)', 'October 4, 2024 09:00 AM', 'October 4, 2024 03:00 PM',  40.3979737,  -80.0826416);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '2425 Liberty Ave, Pittsburgh, PA 15222, United States - October Song Shop', '2425 Liberty Ave, Pittsburgh, PA 15222, United States (unsure)', '2025-10-04 12:00:00', '2025-10-04 13:00:00',  40.452979,  -79.9800551);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Dark Angel Fall 2025 Tour', '242 51st St, Pittsburgh, PA 15201, United States (unsure)', 'October 1, 2025 6:30 PM', NULL,  40.478707,  -79.956419);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Alexandra Kay', '400 N Shore Dr, Pittsburgh, PA 15212, United States (unsure)', 'October 2, 2024 8:00 PM', NULL,  40.4461361,  -80.0122828);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '16066 BBQ Bash', '2525 Rochester Rd, Cranberry Twp, PA 16066, United States', '2024-09-20 00:00:00', NULL,  40.6977556,  -80.10817829999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Fall Harvest Town Square Market', '2525 Rochester Rd, Cranberry Twp, PA 16066, United States', '2024-09-19 00:00:00', NULL,  40.6977556,  -80.10817829999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Fall Harvest Town Square Market', '2525 Rochester Rd, Cranberry Twp, PA 16066, United States', '2025-09-05 00:00:00', '2025-09-05 23:59:59',  40.6977556,  -80.10817829999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Friday Night Lights at the Brewery', '205 S Main St, Zelienople, PA 16063, United States', '2025-06-13 00:00:00', '2025-06-13 23:59:59',  40.794154,  -80.1369007);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Gnome Scavenger Hunt', '7370 Baker St, Pittsburgh, PA 15206, United States', 'October 2, 2025 6:30 PM', 'November 2, 2025 10:30 PM',  40.4842648,  -79.922206);


INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (1, 1);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (1, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (2, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (3, 19);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (4, 19);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (4, 20);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (4, 18);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (5, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (6, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (7, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (7, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (8, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (9, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (10, 2);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (11, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (11, 23);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (12, 2);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (13, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (14, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (14, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (15, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (16, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (17, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (18, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (19, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (20, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (21, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (22, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (23, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (24, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (25, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (26, 1);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (26, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (26, 22);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (27, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (28, 10);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (29, 14);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (30, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (30, 9);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (31, 1);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (31, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (32, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (32, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (32, 22);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (33, 1);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (33, 4);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (34, 9);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (35, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (36, 17);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (36, 19);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (37, 4);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (38, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (39, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (39, 9);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (40, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (41, 2);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (41, 9);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (42, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (43, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (44, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (44, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (45, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (46, 25);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (47, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (48, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (49, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (50, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (51, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (52, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (53, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (54, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (55, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (56, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (57, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (58, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (59, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (59, 12);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (60, 1);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (60, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (61, 1);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (61, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (62, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (62, 21);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (63, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (63, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (64, 1);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (64, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (64, 21);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (65, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (66, 1);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (66, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (67, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (68, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (68, 9);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (69, 1);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (69, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (70, 1);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (70, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (70, 22);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (71, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (72, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (73, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (74, 1);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (74, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (75, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (75, 22);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (76, 1);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (76, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (77, 1);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (77, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (78, 1);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (78, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (78, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (78, 22);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (79, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (80, 10);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (80, 22);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (81, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (82, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (83, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (84, 23);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (85, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (86, 4);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (86, 22);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (87, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (88, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (88, 22);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (89, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (90, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (91, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (92, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (93, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (94, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (95, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (96, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (97, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (98, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (98, 7);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (98, 8);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (99, 25);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (100, 9);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (100, 16);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (101, 10);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (101, 22);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (102, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (102, 22);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (103, 4);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (104, 4);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (105, 4);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (105, 16);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (106, 4);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (107, 4);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (108, 25);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (109, 8);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (110, 19);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (111, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (111, 22);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (112, 19);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (113, 25);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (114, 4);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (115, 19);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (115, 18);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (116, 19);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (116, 20);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (117, 19);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (118, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (118, 18);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (119, 19);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (119, 18);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (120, 17);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (121, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (122, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (123, 3);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (124, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (125, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (125, 6);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (126, 5);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (126, 6);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (127, 2);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (128, 1);
INSERT INTO Hobby_Events (EventID, HobbyID) VALUES (128, 9);
-- --THese will have to be inserted later manually
-- INSERT INTO HomeProfile_Utilities (HomeID, UtilID, Payment) VALUES ('1', '1', 'FALSE'); 
-- INSERT INTO HomeProfile_Utilities (HomeID, UtilID, Payment) VALUES ('1', '67', 'FALSE');
