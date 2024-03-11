-- cities with one connected flight
CREATE TABLE flights (
    start_port varchar,
    end_port varchar
);

CREATE TABLE airports (
    city_name varchar,
    port_code varchar
);

INSERT INTO flights(start_port,end_port)
VALUES
('JFK','NRT'),
('LGA','LAX'),
('LAX','HND'),
('JFK','CDG'),
('CDG','MUC'),
('JFK','HND'),
('JFK','MUC'),
('MUC','NRT');

INSERT INTO airports(city_name,port_code)
VALUES
('New York','JFK'),
('New York','LGA'),
('Paris','CDG'),
('Tokyo','HND'),
('Los Angeles','LAX'),
('Tokyo','NRT'),
('Munich','MUC');

-- Write a SQL query that finds all the cities through which a flight from New York to Tokyo may pass 
--if the passenger wants to make exactly one change of flights

/* WITH ConnectCities AS (
    SELECT DISTINCT f1.end_port AS connecting_port, a2.city_name AS connecting_city
    FROM Flights f1
    JOIN Flights f2 ON f1.end_port = f2.start_port
    JOIN Airports a1 ON f1.end_port = a1.port_code
    JOIN Airports a2 ON f2.end_port = a2.port_code
    WHERE a1.city_name = 'New York' AND a2.city_name = 'Tokyo'
)
SELECT DISTINCT connecting_city
FROM ConnectCities; */

WITH RECURSIVE OneStopFlights AS (
    SELECT f1.end_port AS stopover_port, f2.end_port AS destination
    FROM flights f1
    JOIN flights f2 ON f1.end_port = f2.start_port
    WHERE f1.start_port LIKE 'NY%' -- Starting from New York
      AND f2.end_port LIKE 'TY%' -- Ending in Tokyo
), IntermediateCities AS (
    SELECT DISTINCT a.city_name
    FROM OneStopFlights osf
    JOIN airports a ON osf.stopover_port = a.port_code
    WHERE a.city_name != 'New York' AND a.city_name != 'Tokyo'
)
SELECT * FROM IntermediateCities;
