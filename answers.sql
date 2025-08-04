-- Question 1 🛠️ Achieving 1NF (First Normal Form)
-- The Products column contains multiple values, which violates 1NF.
-- We transform the table so each product is in a separate row.

-- Assuming the original table is named ProductDetail,
-- and since SQL doesn’t have a universal string split,
-- here is a manual approach using UNION ALL for known products:

SELECT OrderID, CustomerName, 'Laptop' AS Product FROM ProductDetail WHERE FIND_IN_SET('Laptop', Products) > 0
UNION ALL
SELECT OrderID, CustomerName, 'Mouse' FROM ProductDetail WHERE FIND_IN_SET('Mouse', Products) > 0
UNION ALL
SELECT OrderID, CustomerName, 'Tablet' FROM ProductDetail WHERE FIND_IN_SET('Tablet', Products) > 0
UNION ALL
SELECT OrderID, CustomerName, 'Keyboard' FROM ProductDetail WHERE FIND_IN_SET('Keyboard', Products) > 0
UNION ALL
SELECT OrderID, CustomerName, 'Phone' FROM ProductDetail WHERE FIND_IN_SET('Phone', Products) > 0;

-- Note: For large or dynamic product lists, use database-specific string split functions or procedures.

--------------------------------------------------------------

-- Question 2 🧩 Achieving 2NF (Second Normal Form)
-- Remove partial dependency of CustomerName on OrderID by splitting into two tables:

-- Create Orders table (OrderID, CustomerName)
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerName VARCHAR(100)
);

-- Insert unique order data into Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create OrderItems table (OrderID, Product, Quantity)
CREATE TABLE OrderItems (
  OrderID INT,
  Product VARCHAR(100),
  Quantity INT,
  PRIMARY KEY (OrderID, Product),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert product details into OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
