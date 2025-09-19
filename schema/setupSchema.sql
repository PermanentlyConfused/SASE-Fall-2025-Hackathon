CREATE DATABASE home_db;
\c home_db;

CREATE TABLE HomeProfile (
    HomeID SERIAL PRIMARY KEY,
    Country VARCHAR(100),
    StateProvince VARCHAR(100),
    Town VARCHAR(100),
    Color VARCHAR(50),
    Latitude DECIMAL(9,6),
    Longitude DECIMAL(9,6),
    Ownership TEXT  
);

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
    Description TEXT,
    Address TEXT,
    Date DATE,
    Time TIME
);

CREATE TABLE Hobby_Events (
    HobbyID INT REFERENCES Hobbies(HobbyID) ON DELETE CASCADE,
    EventID INT REFERENCES Events(EventID) ON DELETE CASCADE,
    PRIMARY KEY (HobbyID, EventID)
);
