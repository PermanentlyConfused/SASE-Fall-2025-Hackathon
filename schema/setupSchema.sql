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
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Sorry, Baby', 'Cinema 10 Potsdam (unsure)', 'September 22, 2025', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Classic Car Show', '8 Maple St, Potsdam, NY', 'September 27, 2025 10:00 AM', 'September 27, 2025 3:00 PM', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Nels Cline Performance', 'Potsdam Library (unsure)', 'September 23, 2025', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '16th Annual St. Lawrence Valley Model Train, Toy & Collectible Expo', '180 Harte Haven Plaza, Massena, NY', 'September 20, 2025', 'September 21, 2025', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Hands-on STEM program', 'North Country Children’s Museum Potsdam (unsure)', 'September 20, 2025', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Creative Partner Showcase Exhibition', '6-8 Raymond Street, Potsdam, NY 13676', 'September 11, 2025', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Glow Bowling', '44 Pierrepont Ave, Potsdam, NY 13676 (unsure)', 'September 20, 2025 06:00 PM', 'September 20, 2025 10:00 PM', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Men''s Rugby Practice', 'MAX-HL RUGBY - Rugby Field # 2, SUNY Potsdam, 44 Pierrepont Ave, Potsdam, NY 13676 (unsure)', 'September 25, 2025 05:00 PM', 'September 25, 2025 06:00 PM', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Womxn''s Rugby Practice', 'MAX-HL RUGBY - Rugby Field # 1, SUNY Potsdam, 44 Pierrepont Ave, Potsdam, NY 13676 (unsure)', 'September 25, 2025 05:00 PM', 'September 25, 2025 07:00 PM', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Interview Speed Meeting', 'Student Union Fireside Lounge (Room 202), 44 Pierrepont Ave, Potsdam, NY 13676 (unsure)', 'September 25, 2025 06:00 PM', 'September 25, 2025 07:00 PM', NULL, NULL); 
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Rural Recreation Association 2025 Fall Summit', '35 Old Mill Rd, Smiths Falls, ON K7A 1R9 (unsure)', 'October 16, 2025 09:00 AM', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '2025 South Dundas Awards of Excellence Gala', '4421 Stormont, Dundas, And Glengarry County Rd 16, Stormont, Dundas and Glengarry', 'October 24, 2025 06:15 PM', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Omniscient Wellness Open House', '150 Marketplace Ave, Ottawa, ON K2J 5G3 (unsure)', 'October 23, 2025 05:00 PM', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Cornwall Psychic & Crystal Fair', '1000 Vincent Massey Dr, Cornwall, ON K6H 6B3 (unsure)', 'October 24, 2025 02:00 PM', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Peace Pole Ceremony', '99 Raymond St, Potsdam, NY 13676', '2025-09-21 15:00:00', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Rock The Call annual fundraiser', '6 Elm St, Potsdam, NY 13676', '2025-09-20 00:00:00', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Annual Cabbage Roll Sale', '39 W Orvis St, Massena, NY 13662', '2025-09-20 10:00:00', '2025-09-20 14:00:00', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Community shred day', '6950 State Highway 56, Potsdam, NY 13676', '2025-09-20 09:00:00', '2025-09-20 13:00:00', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'End of the Summer Bash', '11 S Main St, Norwood, NY 13668', '2025-09-20 16:00:00', '2025-09-20 18:00:00', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Howl Story Slam Live!', 'Potsdam (unsure)', 'September 9, 2025', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Music of the Night', 'Seagle Festival, Keene Valley (unsure)', 'September 7, 2025', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Irish Afternoon', 'Fort Edward (unsure)', 'September 7, 2025', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Bigfoot, UFOs and Ghosts', 'Whitehall, NY (unsure)', 'September 26, 2025', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Great Adirondack Moose Festival', 'Indian Lake (unsure)', 'September 26, 2025', 'September 28, 2025', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Old Forge Oktoberfest', 'Old Forge, NY (unsure)', 'September 26, 2025', 'September 27, 2025', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Comedy Night', 'Indian Lake Theater (unsure)', 'September 26, 2025', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Music of the Night', 'Charles R. Wood Theater, Glens Falls (unsure)', 'September 26, 2025', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'NYS Free Fishing Days', '(unsure)', 'September 27, 2025', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Saturday Visit Day', 'SUNY Potsdam (unsure)', 'September 20, 2025 10:00 AM', 'September 20, 2025 12:00 PM', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Weekly Bible Study', 'Student Union Fireside Lounge (202) (unsure)', 'September 20, 2025 11:00 AM', 'September 20, 2025 01:00 PM', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Alumni Night at the Ski Jumps', 'Olympic Jumping Complex, Lake Placid, NY (unsure)', 'September 20, 2025 05:00 PM', 'September 20, 2025 07:00 PM', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Music with Joey Blake and David Worm', 'Performing Arts Center (unsure)', 'September 20, 2025 08:00 AM', 'September 20, 2025 09:00 PM', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Womxn''s Rugby vs. Oswego', 'MAX-HL RUGBY - Rugby Field # 2 (unsure)', 'September 21, 2025 01:00 PM', 'September 21, 2025 03:00 PM', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Imani Winds in concert', 'Sara M. Snell Music Theater, 44 Pierrepont Ave, Potsdam, NY 13676 (unsure)', 'September 27, 2025 7:30 PM', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'THE PHANTOM FIXERS', 'Potsdam Public Library (unsure)', '2023-09-07 14:00:00', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Crane Community Circlesong Residency', 'SUNY Potsdam''s Crane School of Music (unsure)', '2023-09-18 00:00:00', '2023-09-20 23:59:59', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Woodwind Summit', 'SUNY Potsdam''s Crane School of Music (unsure)', '2023-09-26 00:00:00', '2023-09-27 23:59:59', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Fall Rummage Sale', '(unsure)', 'September 20, 2025 8:00 AM', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Tournament to assist our brother / sisters battling cancer or other life threatening illnesses', '151 5th St, Thendara, NY', '2024-09-11 12:00 AM', '2024-09-11 12:00 AM', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '2025 Rabies Vaccination Clinic Schedule Release', '960 NY ST. RT 51, Ilion, NY', '2025-09-11 5:30 PM', '2025-09-11 7:00 PM', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Herkimer County Event', '104 North Washington St., Herkimer NY', '2024-09-09 5:30 PM', '2024-09-01 12:00 AM', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Troy Country Folk Art Show and Artisan Market', '80 Vandenburgh Ave, Troy, NY 12180', '2025-09-05 00:00:00', '2025-09-07 23:59:59', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '2025 Fredonia Red, White and Blues Festival', 'Fredonia, NY (unsure)', '2025-09-05 00:00:00', NULL, NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', 'Craryville Food Truck and Craft Beer Festival', '44 Golf Course Rd, Craryville, NY 12521', '2025-09-20 00:00:00', '2025-09-21 23:59:59', NULL, NULL);
INSERT INTO Events (Category, Description, Address, StartDate, EndDate, Lat, Long) VALUES ('Events', '2025 North Creek Community Day Outdoor Show', 'North Creek, NY (unsure)', '2025-09-20 00:00:00', NULL, NULL, NULL);