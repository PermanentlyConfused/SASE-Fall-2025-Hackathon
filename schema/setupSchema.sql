DROP DATABASE home_db;
CREATE DATABASE home_db;
\c home_db;


CREATE TABLE HomeProfile (
    HomeID SERIAL PRIMARY KEY,
    Country VARCHAR(100),
    StateProvince VARCHAR(100),
    Town VARCHAR(100) UNIQUE NOT NULL,
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

CREATE TABLE HomeProfile_Hobbies (
    HomeID INT REFERENCES HomeProfile(HomeID) ON DELETE CASCADE,
    HobbyID INT REFERENCES Hobbies(HobbyID) ON DELETE CASCADE,
    PRIMARY KEY (HomeID, HobbyID)
);  

CREATE TABLE Utilities (
    UtilID SERIAL PRIMARY KEY,
    Company VARCHAR(100),
    PhoneNumber VARCHAR(20),
    UtilityType VARCHAR(50),
    Payment DECIMAL(10,2)
);

CREATE TABLE HomeProfile_Utilities (
    HomeID INT REFERENCES HomeProfile(HomeID) ON DELETE CASCADE,
    UtilID INT REFERENCES Utilities(UtilID) ON DELETE CASCADE,
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

INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Foods', 'Jernabi', '11 Maple St, Potsdam, NY 13676', Null , Null,  44.667987, -74.988479);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Foods', 'Royal Indian Grill', '38 Market St, Potsdam, NY 13676', Null , Null,  44.6688102, -74.9864899);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Attractions', 'SLC Arts', '6-8 Raymond St, Potsdam, NY 13676', Null , Null,  44.6698599, -74.9901593);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Sorry, Baby', '20 Main St, Potsdam, NY 13676, United States (unsure)', 'September 22, 2025', NULL, 44.6689891, -74.98567);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Classic Car Show', '8 Maple St, Potsdam, NY 13676, USA', 'September 27, 2025 10:00 AM', 'September 27, 2025 3:00 PM', 44.6672802, -74.9878877);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Nels Cline Performance', '2 Park St STE1, Potsdam, NY 13676, United States (unsure)', 'September 23, 2025', NULL, 44.669362, -74.982714);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '16th Annual St. Lawrence Valley Model Train, Toy & Collectible Expo', '180 Harte Haven Plaza, Massena, NY 13662, United States', 'September 20, 2025', 'September 21, 2025', 44.921817, -74.887022);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Hands-on STEM program', '10 Raymond St, Potsdam, NY 13676, United States (unsure)', 'September 20, 2025', NULL, 44.6698799, -74.98776240000001);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Creative Partner Showcase Exhibition', '6 8 Raymond St, Potsdam, NY 13676, USA', 'September 11, 2025', NULL, 44.66991429999999, -74.9875764);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Glow Bowling', '44 Pierrepont Ave, Potsdam, NY 13676, USA (unsure)', 'September 20, 2025 06:00 PM', 'September 20, 2025 10:00 PM', 44.663596, -74.97521850000001);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Men''s Rugby Practice', '005 Tupper Lake Dr, Potsdam, NY 13676, United States (unsure)', 'September 25, 2025 05:00 PM', 'September 25, 2025 06:00 PM', 44.6605374, -74.9672573);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Womxn''s Rugby Practice', '005 Tupper Lake Dr, Potsdam, NY 13676, United States (unsure)', 'September 25, 2025 05:00 PM', 'September 25, 2025 07:00 PM', 44.6605374, -74.9672573);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Interview Speed Meeting', 'Potsdam, NY 13676, United States (unsure)', 'September 25, 2025 06:00 PM', 'September 25, 2025 07:00 PM', 44.6623448, -74.97407869999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Rural Recreation Association 2025 Fall Summit', '35 Old Mill Rd, Smiths Falls, ON K7A 1Z3, Canada (unsure)', 'October 16, 2025 09:00 AM', NULL, 44.89802299999999, -76.0219195);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '2025 South Dundas Awards of Excellence Gala', '4421 Stormont, Dundas, And Glengarry County Rd 16, Brinston, ON K0E 1C0, Canada', 'October 24, 2025 06:15 PM', NULL, 44.92303039999999, -75.3465605);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Omniscient Wellness Open House', '150 Marketplace Ave, Ottawa, ON K2J 6V2, Canada (unsure)', 'October 23, 2025 05:00 PM', NULL, 45.27196120000001, -75.7386056);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Cornwall Psychic & Crystal Fair', '1000 Vincent Massey Dr, Cornwall, ON K6J 4P7, Canada (unsure)', 'October 24, 2025 02:00 PM', NULL, 45.0275656, -74.7521017);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Peace Pole Ceremony', '99 Raymond St, Potsdam, NY 13676, USA', '2025-09-21 15:00:00', NULL, 44.6698827, -74.9892198);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Rock The Call annual fundraiser', '6 Elm St, Potsdam, NY 13676, USA', '2025-09-20 00:00:00', NULL, 44.6701962, -74.9861513);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Annual Cabbage Roll Sale', '39 W Orvis St, Massena, NY 13662, USA', '2025-09-20 10:00:00', '2025-09-20 14:00:00', 44.9303136, -74.8945076);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Community shred day', '6950 NY-56, Potsdam, NY 13676, USA', '2025-09-20 09:00:00', '2025-09-20 13:00:00', 44.7133319, -74.98690909999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'End of the Summer Bash', '11 S Main St, Norwood, NY 13668, USA', '2025-09-20 16:00:00', '2025-09-20 18:00:00', 44.7496987, -74.99402839999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Howl Story Slam Live!', 'Potsdam, NY 13676, USA (unsure)', 'September 9, 2025', NULL, 44.6697805, -74.9813084);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Music of the Night', '999 Charley Hill Rd, Schroon Lake, NY 12870, United States (unsure)', 'September 7, 2025', NULL, 43.8200606, -73.8037284);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Irish Afternoon', 'Fort Edward, NY 12828, USA (unsure)', 'September 7, 2025', NULL, 43.2670175, -73.5845597);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Bigfoot, UFOs and Ghosts', 'Whitehall, NY, USA (unsure)', 'September 26, 2025', NULL, 43.5556231, -73.40372339999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Great Adirondack Moose Festival', 'Indian Lake, Ohio, USA (unsure)', 'September 26, 2025', 'September 28, 2025', 40.4990656, -83.8950042);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Old Forge Oktoberfest', 'Old Forge, NY, USA (unsure)', 'September 26, 2025', 'September 27, 2025', 43.7100885, -74.9734809);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Comedy Night', '6311 NY-30, Indian Lake, NY 12842, United States (unsure)', 'September 26, 2025', NULL, 43.7823716, -74.2671062);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Music of the Night', '207 Glen St, Glens Falls, NY 12801, United States (unsure)', 'September 26, 2025', NULL, 43.3103261, -73.6450851);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'NYS Free Fishing Days', 'Millenium Towers, A1-12-05, Sector 9, Sanpada east, Navi Mumbai, Maharashtra 400705, India', 'September 27, 2025', NULL, 19.058358, 73.01208989999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Saturday Visit Day', '44 Pierrepont Ave, Potsdam, NY 13676, United States (unsure)', 'September 20, 2025 10:00 AM', 'September 20, 2025 12:00 PM', 44.661522, -74.973023);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Weekly Bible Study', '2200 E Kenwood Blvd #W140, 2200 E Kenwood Blvd, Milwaukee, WI 53211, United States (unsure)', 'September 20, 2025 11:00 AM', 'September 20, 2025 01:00 PM', 43.0752308, -87.881425);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Alumni Night at the Ski Jumps', '5486 Cascade Rd, Lake Placid, NY 12946, United States (unsure)', 'September 20, 2025 05:00 PM', 'September 20, 2025 07:00 PM', 44.2599124, -73.9664465);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Music with Joey Blake and David Worm', 'Ogdensburg Dr, Potsdam, NY 13676, United States (unsure)', 'September 20, 2025 08:00 AM', 'September 20, 2025 09:00 PM', 44.6642656, -74.972129);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Womxn''s Rugby vs. Oswego', 'MAX-HL RUGBY - Rugby Field # 2 (unsure)', 'September 21, 2025 01:00 PM', 'September 21, 2025 03:00 PM', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Imani Winds in concert', '45 Lake Placid Drive, Potsdam, NY 13676, United States (unsure)', 'September 27, 7:30 PM', NULL, 44.6648199, -74.97260949999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'THE PHANTOM FIXERS', '2 Park St STE1, Potsdam, NY 13676, United States (unsure)', '2023-09-07 14:00:00', NULL, 44.669362, -74.982714);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Crane Community Circlesong Residency', '44 Pierrepont Ave, Potsdam, NY 13676, United States (unsure)', '2023-09-18 00:00:00', '2023-09-20 23:59:59', 44.6648532, -74.9708208);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Woodwind Summit', '44 Pierrepont Ave, Potsdam, NY 13676, United States (unsure)', '2023-09-26 00:00:00', '2023-09-27 23:59:59', 44.6648532, -74.9708208);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Fall Rummage Sale', 'Millenium Towers, A1-12-05, Sector 9, Sanpada east, Navi Mumbai, Maharashtra 400705, India', 'September 20, 2025 8:00 AM', NULL, 19.058358, 73.01208989999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Tournament to assist our brother / sisters battling cancer or other life threatening illnesses', '151 5th St, Eagle Bay, NY 13331, USA', '2024-09-11 12:00 AM', '2024-09-11 12:00 AM', 43.704759, -74.99705290000001);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '2025 Rabies Vaccination Clinic Schedule Release', '960 NY-51, Ilion, NY 13357, USA', '2025-09-11 5:30 PM', '2025-09-11 7:00 PM', 42.9310704, -75.1138473);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Herkimer County Event', '104 N Washington St, Herkimer, NY 13350, USA', '2024-09-09 5:30 PM', '2024-09-01 12:00 AM', 43.02707669999999, -74.9843639);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Troy Country Folk Art Show and Artisan Market', '80 Vandenburgh Ave, Troy, NY 12180, USA', '2025-09-05 00:00:00', '2025-09-07 23:59:59', 42.6958308, -73.68238529999999);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '2025 Fredonia Red, White and Blues Festival', 'Fredonia, NY 14063, USA (unsure)', '2025-09-05 00:00:00', NULL, 42.4400576, -79.3317105);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Craryville Food Truck and Craft Beer Festival', '44 Golf Course Rd, Craryville, NY 12521, USA', '2025-09-20 00:00:00', '2025-09-21 23:59:59', 42.1526052, -73.6029795);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '2025 North Creek Community Day Outdoor Show', 'North Creek, NY 12853, USA (unsure)', '2025-09-20 00:00:00', NULL, 43.6978427, -73.9859658);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Webster Garlic Fest', '1350 Chiyoda Dr, Webster, NY 14580, USA', '2025-09-06 00:00:00', '2025-09-07 23:59:59', 43.2279573, -77.4221252);

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