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

-- Assigning Pilot (1 or 6) and Attendant (3 or 4) to all 8 flights
INSERT INTO FlightCrew VALUES 
(1,1), (3,1), (6,2), (4,2), (1,3), (3,3), (6,4), (4,4),
(1,5), (3,5), (6,6), (4,6), (1,7), (3,7), (6,8), (4,8);

-- Update one flight status from 'Scheduled' to 'Completed'
update flights
set status1 = 'Completed'
where flights_ID = 3;

-- Change one flight status from 'Delayed' to 'Cancelled'
update flights
set status1 = 'Cancelled'
where flights_ID = 2;

--  Increase all Economy class booking prices by 10%
update booking
set price = price * 1.10
where class = 'Economy'

-- Update one passenger's phone number 
update Passenger
set phone = '122'
where phone = '111';

-- 5. Move one crew member to a different role
update Crew
set role1 = 'Engineer'
where Crew_ID = 1;

-- Delete one cancelled flight
SELECT * FROM FlightCrew WHERE flights_ID = 4;
DELETE FROM FlightCrew WHERE flights_ID = 4;
SELECT * FROM booking WHERE flights_ID = 4;
DELETE FROM booking WHERE flights_ID = 4;
DELETE FROM flights WHERE flights_ID = 4;
--Delete one booking linked to a cancelled flight
SELECT b.* FROM booking b
JOIN flights f ON b.flights_ID = f.flights_ID
WHERE f.status1 = 'Cancelled';
DELETE FROM booking 
WHERE booking_ID = 5;
-- Try to delete a passenger who has existing bookings. Observe what happens and write a short comment in your SQL file explaining the result.
SELECT p.names, b.booking_ID 
FROM Passenger p
JOIN booking b ON p.national_ID = b.national_ID
WHERE p.national_ID = 'ID1';
DELETE FROM Passenger 
WHERE national_ID = 'ID1';


-- Basic Level:
-- . List all flights and their current status, ordered by departure datetime from earliest to latest.
SELECT flight_number, status1, departure_datetime 
FROM flights 
ORDER BY departure_datetime ASC;
-- Show all passengers, ordered alphabetically by full name 
SELECT * 
FROM Passenger 
ORDER BY names ASC;
-- List all aircraft and their seating capacity, ordered from largest to smallest
SELECT manufacture, model, capacity 
FROM aircraft 
ORDER BY capacity DESC;
-- Show all bookings and their class. Display only distinct class values that exist in the system
SELECT DISTINCT class 
FROM booking;
-- List all flights that have a status of 'Delayed' or 'Cancelled'.
SELECT flight_number, status1 
FROM flights 
WHERE status1 IN ('Delayed', 'Cancelled');
-- Show all passengers whose nationality is 'Omani'.
SELECT * 
FROM Passenger 
WHERE nationality = 'Omani';
-- List all airports, ordered by country
SELECT * 
FROM airports 
ORDER BY country ASC;


--Medium Level
--For each flight, show the flight number, the name of the origin airport, and the name of the destination airport
SELECT f.flight_number, 
       a1.names AS Origin_Airport, 
       a2.names AS Destination_Airport
FROM flights f
JOIN airports a1 ON f.O_IATA = a1.IATA
JOIN airports a2 ON f.D_IATA = a2.IATA;
-- Show each booking along with the full name of the passenger who made it and the flight number it belongs to
SELECT b.booking_ID, p.names AS Passenger_Name, f.flight_number
FROM booking b
JOIN Passenger p ON b.national_ID = p.national_ID
JOIN flights f ON b.flights_ID = f.flights_ID;SELECT b.booking_ID, p.names AS Passenger_Name, f.flight_number
FROM booking b
JOIN Passenger p ON b.national_ID = p.national_ID
JOIN flights f ON b.flights_ID = f.flights_ID;
-- List all crew members assigned to flight 'SK101', showing their full name and role
SELECT c.name1, c.role1
FROM Crew c
JOIN FlightCrew fc ON c.Crew_ID = fc.Crew_ID
JOIN flights f ON fc.flights_ID = f.flights_ID
WHERE f.flight_number = 'SK101';
-- Show all completed flights along with the aircraft model used on each flight
SELECT f.flight_number, a.model
FROM flights f
JOIN aircraft a ON f.aircraft_ID = a.aircraft_ID
WHERE f.status1 = 'Completed';
--. For each passenger, show their full name and the total number of bookings they have made. Order by booking count from highest to lowest
SELECT p.names, COUNT(b.booking_ID) AS Total_Bookings
FROM Passenger p
LEFT JOIN booking b ON p.national_ID = b.national_ID
GROUP BY p.names
ORDER BY Total_Bookings DESC;
-- Show the total revenue collected from each booking class
SELECT class, SUM(price) AS Total_Revenue
FROM booking
GROUP BY class;
-- Count how many flights each aircraft has been assigned to
SELECT a.registration_number, a.model, COUNT(f.flights_ID) AS Flight_Count
FROM aircraft a
LEFT JOIN flights f ON a.aircraft_ID = f.aircraft_ID
GROUP BY a.registration_number, a.model;
-- List all flights that have more than one booking
SELECT f.flight_number, COUNT(b.booking_ID) AS Booking_Count
FROM flights f
JOIN booking b ON f.flights_ID = b.flights_ID
GROUP BY f.flight_number
HAVING COUNT(b.booking_ID) > 1;
-- Show the full details of all bookings  passenger name, flight number, origin airport, destination airport, class, and price paid
SELECT p.names AS Passenger_Name, 
       f.flight_number, 
       a1.names AS Origin, 
       a2.names AS Destination, 
       b.class, 
       b.price
FROM booking b
JOIN Passenger p ON b.national_ID = p.national_ID
JOIN flights f ON b.flights_ID = f.flights_ID
JOIN airports a1 ON f.O_IATA = a1.IATA
JOIN airports a2 ON f.D_IATA = a2.IATA;

-- Advanced Level
--List all passengers who have never made a booking.
SELECT names, national_ID 
FROM Passenger 
WHERE national_ID NOT IN (SELECT DISTINCT national_ID FROM booking);
--List all passengers who booked a flight that is currently 'Cancelled'. Show the passenger name, flight number, and booking date.
SELECT p.names, f.flight_number, b.booking_date
FROM Passenger p
JOIN booking b ON p.national_ID = b.national_ID
JOIN flights f ON b.flights_ID = f.flights_ID
WHERE f.status1 = 'Cancelled';






















