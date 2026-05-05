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

CREATE TABLE Airline (
    airline_IATA CHAR(3) PRIMARY KEY,
    airline_name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    contact_email VARCHAR(100)
);
CREATE TABLE Gate (
    gate_ID INT PRIMARY KEY IDENTITY(1,1),
    gate_code VARCHAR(10) NOT NULL,
    terminal_name VARCHAR(50),
    IATA VARCHAR(3),
    CONSTRAINT FK_Gate_Airports FOREIGN KEY (IATA) 
        REFERENCES airports(IATA)
);

CREATE TABLE Baggage1 (
    baggage_id INT PRIMARY KEY IDENTITY(1,1),
    tag_number VARCHAR(20) NOT NULL UNIQUE,
    weight_kg DECIMAL(5, 2) NOT NULL CHECK (weight_kg > 0),
    type VARCHAR(10) NOT NULL CHECK (type IN ('Cabin', 'Checked')),
    booking_id INT NOT NULL,
    CONSTRAINT FK_Baggage_Booking FOREIGN KEY (booking_id) 
        REFERENCES booking(booking_id)
       
);

CREATE TABLE FlightDelayLog (
    delay_id INT PRIMARY KEY IDENTITY(1,1),
    reason TEXT NOT NULL,
    duration_minutes INT NOT NULL CHECK (duration_minutes > 0),
    recorded_at DATETIME NOT NULL ,
    flight_id INT NOT NULL,
    CONSTRAINT FK_Delay_Flights FOREIGN KEY (flight_id) 
        REFERENCES flights(flights_ID)
  
);



















