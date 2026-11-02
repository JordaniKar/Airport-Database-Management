Create database 2026_kursova_rabota;
use 2026_kursova_rabota;
CREATE TABLE airports (
    id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(100) NOT NULL,
    airport_name VARCHAR(100) NOT NULL
);

CREATE TABLE planes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    plane_type VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    year_built INT,
    company VARCHAR(100)
);

CREATE TABLE crew_members (
    id INT PRIMARY KEY AUTO_INCREMENT,
    crew_name VARCHAR(100) NOT NULL,
    crew_role ENUM('pilot', 'cabin_crew', 'navigator') NOT NULL,
    age INT,
    years_of_experience INT
);

CREATE TABLE flights (
    id INT PRIMARY KEY AUTO_INCREMENT,
    take_off_date DATE NOT NULL,
    take_off_hour TIME NOT NULL,
    duration_minutes INT NOT NULL, -- по-лесно за изчисления от текст
    plane_id INT,
    departure_airport_id INT,
    arrival_airport_id INT,
    food_type VARCHAR(50),
    FOREIGN KEY (plane_id) REFERENCES planes(id),
    FOREIGN KEY (departure_airport_id) REFERENCES airports(id),
    FOREIGN KEY (arrival_airport_id) REFERENCES airports(id)
);

CREATE TABLE flight_crew (
    flight_id INT,
    crew_member_id INT,
    PRIMARY KEY (flight_id, crew_member_id),
    FOREIGN KEY (flight_id) REFERENCES flights(id) ON DELETE CASCADE,
    FOREIGN KEY (crew_member_id) REFERENCES crew_members(id) ON DELETE CASCADE
);

INSERT INTO airports (city, airport_name) VALUES
('Sofia', 'Sofia Airport - Terminal 2'),
('London', 'Heathrow Airport'),
('Paris', 'Charles de Gaulle'),
('Frankfurt', 'Frankfurt Airport'),
('Varna', 'Varna Airport');

INSERT INTO planes (plane_type, capacity, year_built, company) VALUES
('Airbus A320', 180, 2015, 'Bulgaria Air'),
('Boeing 737-800', 189, 2018, 'Ryanair'),
('Airbus A321', 220, 2020, 'Wizz Air'),
('Embraer E190', 100, 2012, 'Lufthansa'),
('Boeing 777', 350, 2016, 'Air France'),
('Airbus A350', 300, 2021, 'British Airways'),
('Boeing 787', 250, 2019, 'LOT'),
('Airbus A319', 140, 2010, 'Austrian Airlines'),
('Bombardier CRJ900', 90, 2014, 'Lufthansa CityLine'),
('Airbus A330', 280, 2017, 'Turkish Airlines');

INSERT INTO crew_members (crew_name, crew_role, age, years_of_experience) VALUES
('Ivan Ivanov', 'pilot', 45, 20), ('Petar Petrov', 'pilot', 38, 12),
('Maria Georgieva', 'pilot', 34, 8), ('Stefan Nikolov', 'pilot', 50, 25),
('Elena Koleva', 'pilot', 29, 4), ('Dimitar Angelov', 'pilot', 42, 15),
('Georgi Stoyanov', 'pilot', 36, 10), ('Vasil Levski', 'pilot', 48, 22),
('Nikola Tesla', 'pilot', 41, 14), ('Hristo Botev', 'pilot', 33, 7),
('Aneliya Dimova', 'cabin_crew', 25, 2), ('Boryana Tsvetkova', 'cabin_crew', 28, 5),
('Viktor Emilov', 'cabin_crew', 30, 7), ('Gabriela Ruseva', 'cabin_crew', 24, 1),
('Daniel Kostov', 'cabin_crew', 31, 8), ('Ekaterina Mileva', 'cabin_crew', 27, 4),
('Zhivko Petkov', 'cabin_crew', 29, 5), ('Zornitsa Todorova', 'cabin_crew', 26, 3),
('Ivaylo Slavchev', 'cabin_crew', 32, 10), ('Yordanka Hristova', 'cabin_crew', 40, 18),
('Kaloyan Simeonov', 'cabin_crew', 23, 1), ('Liliya Ivanova', 'cabin_crew', 22, 1),
('Martin Tsvetanov', 'navigator', 44, 19), ('Nadya Petrova', 'navigator', 37, 11),
('Ognyan Donev', 'navigator', 52, 28);

INSERT INTO flights (take_off_date, take_off_hour, duration_minutes, plane_id, departure_airport_id, arrival_airport_id, food_type) VALUES
('2026-05-01', '08:30:00', 120, 1, 1, 2, 'Hot Meal'),
('2026-05-01', '10:00:00', 180, 2, 2, 3, 'Snack'),
('2026-05-02', '12:45:00', 90, 3, 3, 4, 'Vegetarian'),
('2026-05-02', '15:20:00', 60, 4, 4, 1, 'No Food'),
('2026-05-03', '06:00:00', 50, 1, 1, 5, 'Sandwich'),
('2026-05-03', '09:15:00', 55, 1, 5, 1, 'Sandwich'),
('2026-05-04', '21:00:00', 210, 5, 2, 5, 'Full Dinner'),
('2026-05-04', '22:30:00', 130, 6, 3, 1, 'Cold Platter'),
('2026-05-05', '07:00:00', 110, 7, 1, 4, 'Breakfast'),
('2026-05-05', '14:00:00', 125, 8, 4, 2, 'Lunch'),
('2026-05-06', '11:10:00', 140, 9, 2, 1, 'Snack'),
('2026-05-06', '16:40:00', 170, 10, 5, 3, 'Hot Meal'),
('2026-05-07', '08:00:00', 120, 1, 1, 2, 'Standard'),
('2026-05-07', '13:00:00', 115, 2, 2, 4, 'Standard'),
('2026-05-08', '19:20:00', 95, 3, 4, 5, 'Light'),
('2026-05-08', '23:00:00', 100, 4, 5, 2, 'No Food'),
('2026-05-09', '05:30:00', 200, 5, 3, 5, 'Breakfast'),
('2026-05-09', '10:15:00', 150, 6, 1, 3, 'Lunch'),
('2026-05-10', '14:50:00', 180, 7, 2, 3, 'Hot Meal'),
('2026-05-10', '18:00:00', 65, 8, 5, 1, 'Snack'),
('2026-05-11', '09:00:00', 120, 9, 1, 2, 'Vegetarian'),
('2026-05-11', '20:00:00', 130, 10, 4, 1, 'Dinner'),
('2026-05-12', '07:45:00', 110, 1, 2, 1, 'Breakfast'),
('2026-05-12', '12:00:00', 115, 2, 3, 4, 'Lunch'),
('2026-05-13', '15:30:00', 90, 3, 1, 5, 'Sandwich'),
('2026-05-13', '17:00:00', 85, 4, 5, 4, 'Snack'),
('2026-05-14', '22:00:00', 210, 5, 2, 5, 'Standard'),
('2026-05-14', '06:15:00', 130, 6, 3, 1, 'Standard'),
('2026-05-15', '11:00:00', 140, 7, 4, 2, 'Lunch'),
('2026-05-15', '19:45:00', 160, 8, 1, 4, 'Dinner');

INSERT INTO flight_crew (flight_id, crew_member_id) VALUES
(1, 1), (1, 2), (1, 11),
(2, 3), (2, 4), (2, 12),
(3, 5), (3, 6), (3, 13),
(4, 7), (4, 8), (4, 14),
(5, 9), (5, 10), (5, 15),
(6, 1), (6, 2), (6, 16),
(7, 3), (7, 4), (7, 17), (7, 23),
(8, 5), (8, 6), (8, 18),
(9, 7), (9, 8), (9, 19),
(10, 9), (10, 10), (10, 20);