CREATE DATABASE project
CREATE TABLE airports (
    IATA VARCHAR(3) PRIMARY KEY,
    names VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE aircraft (
    aircraft_ID INT PRIMARY KEY,
    registration_number VARCHAR(20) UNIQUE,
    model VARCHAR(50),
    manufacture VARCHAR(50),
    capacity INT,
    year_of_manufactur INT
);


CREATE TABLE flights (
    flights_ID INT PRIMARY KEY,
    flight_number VARCHAR(10),
    departure_datetime DATETIME,
    arrival_datetime DATETIME,
    status1 VARCHAR(20) CHECK (status1 IN ('Scheduled', 'Delayed', 'Cancelled', 'Completed')),
    O_IATA VARCHAR(3),
    D_IATA VARCHAR(3),
    aircraft_ID INT,
    FOREIGN KEY (O_IATA) REFERENCES airports(IATA),
    FOREIGN KEY (D_IATA) REFERENCES airports(IATA),
    FOREIGN KEY (aircraft_ID) REFERENCES aircraft(aircraft_ID)
);

CREATE TABLE Passenger (
    national_ID VARCHAR(20) PRIMARY KEY,
    names VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    nationality VARCHAR(50),
    BD DATE
);

CREATE TABLE Crew (
    Crew_ID INT PRIMARY KEY,
    license VARCHAR(20) UNIQUE,
    name1 VARCHAR(100),
    role1 VARCHAR(20) CHECK (role1 IN ('Pilot', 'Co-Pilot', 'Flight Attendant', 'Engineer'))
);

CREATE TABLE booking (
    booking_ID INT PRIMARY KEY,
    class VARCHAR(15) CHECK (class IN ('Economy', 'Business', 'First')),
    seat_num VARCHAR(5),
    price DECIMAL(10, 2),
    booking_date DATE,
    national_ID VARCHAR(20),
    flights_ID INT,
    FOREIGN KEY (national_ID) REFERENCES Passenger(national_ID),
    FOREIGN KEY (flights_ID) REFERENCES flights(flights_ID)
);

CREATE TABLE FlightCrew (
    Crew_ID INT,
    flights_ID INT,
    PRIMARY KEY (Crew_ID, flights_ID),
    FOREIGN KEY (Crew_ID) REFERENCES Crew(Crew_ID),
    FOREIGN KEY (flights_ID) REFERENCES flights(flights_ID)
);

INSERT INTO airports VALUES 
('JFK', 'John F. Kennedy', 'New York', 'USA'),
('LHR', 'Heathrow', 'London', 'UK'),
('DXB', 'Sami', 'Dubai', 'UAE'),
('HND', 'Haneda', 'Tokyo', 'Japan'),
('CDG', 'Ali', 'Paris', 'France');

INSERT INTO aircraft VALUES 
(1, 'N123AB', '737-800', 'Boeing', 160, 2018),
(2, 'G-XWB', 'A350-900', 'Airbus', 300, 2020),
(3, 'A6-EEI', 'A380-800', 'Airbus', 500, 2015),
(4, 'JA811A', '787-9', 'Boeing', 250, 2019),
(5, 'F-GZCK', 'A330-200', 'Airbus', 240, 2017);

INSERT INTO flights VALUES 
(1, 'AA100', '2024-06-01 08:00', '2024-06-01 20:00', 'Completed', 'JFK', 'LHR', 1),
(2, 'BA200', '2024-06-02 10:00', '2024-06-02 22:00', 'Delayed', 'LHR', 'DXB', 2),
(3, 'EK300', '2024-06-03 14:00', '2024-06-04 06:00', 'Scheduled', 'DXB', 'HND', 3),
(4, 'JL400', '2024-06-04 12:00', '2024-06-05 08:00', 'Cancelled', 'HND', 'CDG', 4),
(5, 'AF500', '2024-06-05 09:00', '2024-06-05 13:00', 'Completed', 'CDG', 'JFK', 5),
(6, 'AA101', '2024-06-06 18:00', '2024-06-07 06:00', 'Scheduled', 'JFK', 'DXB', 1),
(7, 'BA201', '2024-06-07 22:00', '2024-06-08 10:00', 'Scheduled', 'LHR', 'HND', 2),
(8, 'EK301', '2024-06-08 01:00', '2024-06-08 07:00', 'Scheduled', 'DXB', 'CDG', 3);

INSERT INTO Passenger VALUES 
('ID1', 'Alice', 'alice@test.com', '111', 'American', '1990-01-01'),
('ID2', 'Bob', 'bob@test.com', '222', 'British', '1985-05-12'),
('ID3', 'Yuki', 'yuki@test.com', '333', 'Japanese', '1992-03-20'),
('ID4', 'Omar', 'omar@test.com', '444', 'Emirati', '1988-11-30'),
('ID5', 'Marie', 'marie@test.com', '555', 'French', '1995-07-15'),
('ID6', 'Hans', 'hans@test.com', '666', 'German', '1982-02-28'),
('ID7', 'Sofia', 'sofia@test.com', '777', 'Italian', '1993-09-10'),
('ID8', 'Liam', 'liam@test.com', '888', 'Irish', '1987-12-05');

INSERT INTO booking VALUES 
(1, 'First', '1A', 5000, '2024-05-01', 'ID1', 1),
(2, 'Business', '10C', 2500, '2024-05-02', 'ID2', 1),
(3, 'Economy', '32F', 800, '2024-05-03', 'ID3', 2),
(4, 'First', '2B', 5500, '2024-05-04', 'ID4', 3),
(5, 'Economy', '45A', 750, '2024-05-05', 'ID5', 4),
(6, 'Business', '12D', 2200, '2024-05-06', 'ID6', 5),
(7, 'Economy', '22B', 600, '2024-05-07', 'ID7', 6),
(8, 'First', '1K', 6000, '2024-05-08', 'ID8', 7),
(9, 'Economy', '15E', 900, '2024-05-09', 'ID1', 8),
(10, 'Business', '8J', 2800, '2024-05-10', 'ID4', 2);

INSERT INTO Crew VALUES 
(1, 'LIC01', 'Capt. Miller', 'Pilot'),
(2, 'LIC02', 'Officer Chen', 'Co-Pilot'),
(3, 'LIC03', 'Sarah Jones', 'Flight Attendant'),
(4, 'LIC04', 'David Wilson', 'Flight Attendant'),
(5, 'LIC05', 'Kenji Sato', 'Engineer'),
(6, 'LIC06', 'Capt. Dubois', 'Pilot');
