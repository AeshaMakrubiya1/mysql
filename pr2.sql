REATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Email VARCHAR(50),
    RegistrationDate VARCHAR(20)
);

INSERT INTO Customers VALUES
(1, 'Jonsi', 'patel', 'jonsipatel11@gmail.com', '2023-01-15'),
(2, 'Janvi', 'rao', 'janvirao1@gmail.com', '2021-11-02');

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate VARCHAR(20),
    CustomerID INT,
    TotalAmount DECIMAL(10, 2),
);

INSERT INTO Orders VALUES
(1, '2023-07-01', 1, 150.50),
(2, '2023-07-03', 2, 200.75);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    HireDate DATE,
    Department VARCHAR(50),
    salary DECIMAL(10, 2)
);

INSERT INTO Employees VALUES
(1, 'evy','rey', '2020-01-15', 'Sales', 55000),
(2, 'eva','mishra', '2021-03-20', 'HR', 55000);

SELECT o.OrderID, c.FirstName, c.LastName, o.TotalAmount
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID;

SELECT c.FirstName, c.LastName, o.OrderID
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;

SELECT c.FirstName, c.LastName, o.OrderID
FROM Customers c
FULL OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID;

SELECT CustomerID
FROM Orders
WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM Orders);

SELECT * FROM Employees
WHERE Salary> (SELECT AVG(Salary) FROM Employees);

SELECT OrderID,
YEAR(OrderDate) AS Year,
MONTH(OrderDate) AS Month
FROM Orders;

SELECT OrderID,
DATEDIFF(CURDATE(), OrderDate) AS DaysDifference
FROM Orders;

SELECT DATE_FORMAT(HireDate, '%d-%m-%Y') AS FormattedDate
FROM orders;

SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM Customers;

SELECT REPLACE(FirstName, 'John', 'Jonathan')
FROM Customers;

SELECT UPPER(FirstName), LOWER(LastName)
FROM Customers;

SELECT TRIM(Email)
FROM Customers;

SELECT OrderID, TotalAmount,
SUM(TotalAmount) OVER (ORDER BY OrderDate) AS RunningTotal
FROM Orders;

SELECT OrderID, TotalAmount,
RANK() OVER (ORDER BY TotalAmount DESC) AS Rankorder
FROM Orders;

SELECT OrderID, TotalAmount,
CASE 
    WHEN TotalAmount > 1000 THEN '10% Discount'
    WHEN TotalAmount > 500 THEN '6% Discount'
    ELSE 'No Discount'
END AS Discount
FROM Orders;

SELECT EmployeeID, Salary,
CASE 
    WHEN Salary>80000 THEN 'High'
    WHEN Salary>50000 THEN 'Medium'
    ELSE 'Low'
END AS SalaryCategory
FROM Employees;