-- Initiliazing the tables and inserting data
CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName NVARCHAR(100),
Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Laptop', 1500.00),
(2, 'Mouse', 25.00),
(3, 'Keyboard', 45.00);

CREATE TABLE Sales (
SaleID INT PRIMARY KEY,
ProductID INT,
Quantity INT,
SaleDate DATETIME,
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate) VALUES
(1, 1, 2, '2024-01-10'),
(2, 2, 5, '2024-01-15'),
(3, 1, 1, '2024-02-20'),
(4, 3, 3, '2024-03-05'),
(5, 2, 7, '2024-03-25'),
(6, 3, 2, '2024-04-12');

-- Finding the total sales a quantity sold per year for each product
SELECT YEAR(s.SaleDate) as Year, p.ProductName, SUM(s.Quantity * p.Price) AS TotalSales, 
SUM(s.Quantity) AS NumberOfSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName, YEAR(s.SaleDate)
ORDER BY TotalSales DESC;

-- Fetching the product with the highest amount of sales    
SELECT p.ProductName, SUM(s.Quantity * p.Price) AS TotalSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC
LIMIT 1;
