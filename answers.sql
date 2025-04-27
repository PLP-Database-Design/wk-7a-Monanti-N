SELECT OrderID, CustomerName, TRIM(product) AS Product
FROM (
    SELECT OrderID, CustomerName, SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1) AS product
    FROM ProductDetail
    CROSS JOIN (SELECT n1.n FROM (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) n1) n
    WHERE n.n <= LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) + 1
) AS ProductList;




CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
