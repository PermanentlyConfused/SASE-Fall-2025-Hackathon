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


INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'STEM-CONNECT 2025', '1000 Fort Duquesne Blvd, Pittsburgh, PA 15222', 'October 2, 2025 04:30 PM', 'October 4, 2025 05:30 PM', 40.445782 , -79.99651);
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

-- --THese will have to be inserted later manually
-- INSERT INTO HomeProfile_Utilities (HomeID, UtilID, Payment) VALUES ('1', '1', 'FALSE'); 
-- INSERT INTO HomeProfile_Utilities (HomeID, UtilID, Payment) VALUES ('1', '67', 'FALSE');
