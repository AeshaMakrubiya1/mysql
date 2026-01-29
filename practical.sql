CREATE DATABASE SmartEventManagement;

USE SmartEventManagement;

CREATE TABLE Events (
event_name VARCHAR(100),
event_id INT PRIMARY KEY AUTO_INCREMENT,
event_date DATE,
venue_id INT,
organizer_id INT,
ticket_price DECIMAL(10,2),
available_seats INT
);

CREATE TABLE Venues (
venue_id INT PRIMARY KEY AUTO_INCREMENT,
venue_name VARCHAR(50),
location VARCHAR(100),
capacity INT
);

CREATE TABLE Organizers (
organizer_id INT PRIMARY KEY AUTO_INCREMENT,
organizer_name VARCHAR(50),
contact_email VARCHAR(40),
phone_number VARCHAR(15)
);

CREATE TABLE Attendees (
attendee_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
email VARCHAR(40),
phone_number VARCHAR(10)
);

CREATE TABLE Tickets (
ticket_id INT PRIMARY KEY AUTO_INCREMENT,
event_id INT,
attendee_id INT,
booking_date DATE,
status ENUM('Confirmed', 'Cancelled', 'Pending'),
UNIQUE(event_id, attendee_id),
FOREIGN KEY (event_id) REFERENCES Events(event_id),
FOREIGN KEY (attendee_id) REFERENCES Attendees(attendee_id)
);

CREATE TABLE Payments (
payment_id INT PRIMARY KEY AUTO_INCREMENT,
ticket_id INT,
amount_paid DECIMAL(10,2),
payment_status ENUM('Success', 'Failed', 'Pending'),
payment_date DATETIME,
FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id)
);

INSERT INTO Venues VALUES
('City Hall','Mumbai',500),
('Expo Center','Delhi',1000);

INSERT INTO Organizers VALUES
('Ashrii Events','ash11@gmail.com','9876543210'),
('eva Events','evaa12@gmail.com','9876512345');

INSERT INTO Events VALUES
('Music Fest','2025-12-10',1,1,1200,200),
('Tech Summit','2025-12-20',2,2,1500,300);

INSERT INTO Attendees VALUES
('john smith','john11@gmail.com','9987765442'),
('riva rao','riva90@gmail.com','9911882279');

INSERT INTO Tickets VALUES
(1,1,'2025-11-01','Confirmed'),
(2,2,'2025-11-02','Pending');

INSERT INTO Payments VALUES
(1,1200,'Success','2025-11-01 10:00:00'),
(2,1500,'Pending','2025-11-02 12:00:00');

INSERT INTO Events VALUES (3,'Art Expo','2025-12-15',1,2,900,150);

UPDATE Events SET ticket_price = 1300 WHERE event_id = 1;

DELETE FROM Events WHERE event_id = 3;

SELECT * FROM Events WHERE event_name LIKE '%Music%';

SELECT * FROM Events e
JOIN Venues v ON e.venue_id = v.venue_id
WHERE v.location = 'Mumbai';


SELECT e.event_name, SUM(p.amount_paid) AS revenue
FROM Events e
JOIN Tickets t ON e.event_id = t.event_id
JOIN Payments p ON t.ticket_id = p.ticket_id
GROUP BY e.event_name
ORDER BY revenue DESC
LIMIT 5;

SELECT * FROM Tickets 
WHERE booking_date >= CURDATE() - INTERVAL 7 DAY;

SELECT * FROM Events
WHERE MONTH(event_date) = 12 AND available_seats > 100;

SELECT DISTINCT a.name
FROM Attendees a
LEFT JOIN Tickets t ON a.attendee_id = t.attendee_id
LEFT JOIN Payments p ON t.ticket_id = p.ticket_id
WHERE t.ticket_id IS NOT NULL OR p.payment_status = 'Pending';

SELECT * FROM Events WHERE available_seats > 0;

SELECT * FROM Events ORDER BY event_date ASC;

SELECT event_id, COUNT(attendee_id) AS total_attendees
FROM Tickets
GROUP BY event_id;


SELECT e.event_name, SUM(p.amount_paid) AS revenue
FROM Events e
JOIN Tickets t ON e.event_id = t.event_id
JOIN Payments p ON t.ticket_id = p.ticket_id
GROUP BY e.event_name;

SELECT SUM(amount_paid) FROM Payments;

SELECT event_id, COUNT(*) AS total
FROM Tickets
GROUP BY event_id
ORDER BY total DESC LIMIT 1;


SELECT AVG(ticket_price) FROM Events;

SELECT e.event_name, v.venue_name
FROM Events e
INNER JOIN Venues v ON e.venue_id = v.venue_id;

SELECT a.name FROM Attendees a
LEFT JOIN Tickets t ON a.attendee_id = t.attendee_id
LEFT JOIN Payments p ON t.ticket_id = p.ticket_id
WHERE p.payment_status IS NULL OR p.payment_status = 'Pending';


SELECT e.event_name FROM Tickets t
RIGHT JOIN Events e ON t.event_id = e.event_id
WHERE t.ticket_id IS NULL;

SELECT a.name, t.ticket_id FROM Attendees a
LEFT JOIN Tickets t ON a.attendee_id = t.attendee_id
UNION
SELECT a.name, t.ticket_id FROM Attendees a
RIGHT JOIN Tickets t ON a.attendee_id = t.attendee_id;

SELECT event_name FROM Events
WHERE event_id IN (
    SELECT event_id FROM Tickets t
    JOIN Payments p ON t.ticket_id = p.ticket_id
    GROUP BY event_id
    HAVING SUM(amount_paid) > (SELECT AVG(amount_paid) FROM Payments)
);

SELECT attendee_id FROM Tickets
GROUP BY attendee_id HAVING COUNT(event_id) > 1;

SELECT organizer_id FROM Events
GROUP BY organizer_id HAVING COUNT(event_id) > 3;

SELECT event_name, MONTH(event_date) FROM Events;

SELECT event_name, DATEDIFF(event_date, CURDATE()) AS days_left FROM Events;

SELECT DATE_FORMAT(payment_date, '%Y-%m-%d %H:%i:%s') FROM Payments;

SELECT UPPER(organizer_name) FROM Organizers;

SELECT TRIM(name) FROM Attendees;

SELECT IFNULL(email,'Not Provided') FROM Attendees;

SELECT e.event_name, SUM(p.amount_paid) AS revenue,
RANK() OVER (ORDER BY SUM(p.amount_paid) DESC) AS rank_position
FROM Events e
JOIN Tickets t ON e.event_id = t.event_id
JOIN Payments p ON t.ticket_id = p.ticket_id
GROUP BY e.event_name;