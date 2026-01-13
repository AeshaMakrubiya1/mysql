CREATE TABLE Customers(
    CustommerId INT PRIMARY KEY,
    Name VARCHAR(20),
    Email VARCHAR(20),
    Address VARCHAR(100)
);

INSERT INTO Customers VALUES
(1, 'Aditiya', 'aditiya@gmail.com', '123 Main Street'),
(2, 'Lela', 'lela@gmail.com', '456 Oak Avenue'),
(3, 'Alice', 'alice@gmail.com', '789 Pine Road'),
(4, 'Bob', 'bob@gmail.com', '101 Elm Street'),
(5, 'Charlie', 'charlie@gmail.com', '202 Maple Drive');
SELECT * FROM Customers;
UPDATE Customers
SET Address = '123 Main St, Apt 4B'
WHERE CustommerId = 1;  

DELETE FROM Customers
WHERE CustommerId = 3;

SELECT * FROM Customers;
WHERE Name = 'Alice';

CREATE TABLE Orders(
    OrderId INT PRIMARY KEY,
    OrderDate DATE,
    CustommerId INT,
    Amount DECIMAL(10, 2),
    FOREIGN KEY (CustommerId) REFERENCES Customers(CustommerId)
);  
INSERT INTO Orders VALUES
(1, '2026-01-15', 1, 25000),
(2, '2026-02-20', 2, 15050),
(3, '2026-03-10', 4, 30075),
(4, '2026-04-05', 5, 45000);

SELECT * FROM Orders;
WHERE CustommerId = 2;
UPDATE Orders
SET Amount = 16000
WHERE OrderId = 2;
DELETE FROM Orders
WHERE OrderId = 3;
SELECT * FROM Orders;
WHERE orderDate>= CURRENT_DATE - INTERVAL 30 DAY;
SELECT MAX(Amount) AS HighestAmount,
         MIN(Amount) AS LowestAmount,
         AVG(Amount) AS AverageAmount
FROM Orders;


CREATE TABLE PRODUCTS(
    ProductId INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);
INSERT INTO PRODUCTS VALUES
(1, 'Laptop', 75000, 10),
(2, 'Smartphone', 50000, 20),
(3, 'Tablet', 30000, 15),
(4, 'Headphones', 5000, 50),
(5, 'Smartwatch', 15000, 25);
SELECT * FROM PRODUCTS;
ORDER BY Price DESC;
UPDATE PRODUCTS
SET Price = 70000
WHERE ProductId = 1;    
DELETE FROM PRODUCTS
WHERE ProductId = 4;
SELECT * FROM PRODUCTS;
WHERE Price BETWEEN 10000 AND 40000;

SELECT MAX(Price) AS MOST_EXPENSIVE,
         MIN(Price) AS Cheapest
FROM PRODUCTS;


CREATE TABLE OrderDetails(
    OrderDetailId INT PRIMARY KEY,
    OrderId INT,
    ProductId INT,
    Quantity INT,
    FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
    FOREIGN KEY (ProductId) REFERENCES PRODUCTS(ProductId)
);
INSERT INTO OrderDetails VALUES
(1,101,201,1,55000),
(2,102,202,2,60000),
(3,103,203,1,30000),
(4,104,204,3,15000);
SELECT * FROM OrderDetails;
WHERE OrderId = 102;

SELECT SUM(Quantity) AS TotalQuantity
FROM OrderDetails;

SELECT ProductID, SUM(Quantity) AS TotalSold
FROM OrderDetails
GROUP BY ProductID;
ORDER BY TotalSold DESC;
LIMIT 4;

SELECT ProductId, COUNT(*)AS TimesSold
FROM OrderDetails
WHERE ProductId=201
GROUP BY ProductId;