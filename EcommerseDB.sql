CREATE DATABASE ECommerceDB1;


USE ECommerceDB1;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Price DECIMAL(10, 2)
);

CREATE TABLE Inventory (
    ProductID INT PRIMARY KEY,
    Quantity INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATETIME,
    Status NVARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderLineItems (
    OrderLineItemID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

select * from Customers;
select * from Products;
select * from Inventory;
select * from Orders;
select * from OrderLineItems;



CREATE PROCEDURE CreateOrderWithValidation
    @CustomerID INT,
    @ProductID INT,
    @Quantity INT,
    @ShippingAddress NVARCHAR(255),
    @Email NVARCHAR(100),
    @OrderID INT OUTPUT,
    @OrderTotal DECIMAL(10, 2) OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
    BEGIN
        THROW 50000, 'Invalid customer ID', 1;
        RETURN;
    END;

    IF NOT EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID)
    BEGIN
        THROW 50000, 'Invalid product ID', 1;
        RETURN;
    END;

    DECLARE @AvailableQuantity INT;
    SELECT @AvailableQuantity = Quantity
    FROM Inventory
    WHERE ProductID = @ProductID;

    IF @AvailableQuantity < @Quantity
    BEGIN
        THROW 50000, 'Insufficient inventory', 1;
        RETURN;
    END;

    BEGIN TRANSACTION;

    INSERT INTO Orders (CustomerID, OrderDate, Status)
    VALUES (@CustomerID, GETDATE(), 'Processing');

    SET @OrderID = SCOPE_IDENTITY();

    INSERT INTO OrderLineItems (OrderID, ProductID, Quantity, Price)
    VALUES (@OrderID, @ProductID, @Quantity, (SELECT Price FROM Products WHERE ProductID = @ProductID));

    UPDATE Inventory
    SET Quantity = Quantity - @Quantity
    WHERE ProductID = @ProductID;

    -- Calculate order total
    SELECT @OrderTotal = SUM(Quantity * Price)
    FROM OrderLineItems
    WHERE OrderID = @OrderID;

    COMMIT;

    SELECT @OrderID AS OrderID, @OrderTotal AS OrderTotal;
END;



DECLARE @OrderID INT;
DECLARE @OrderTotal DECIMAL(10, 2);

DECLARE @CustomerID INT = 1; 
DECLARE @ProductID INT = 1;  
DECLARE @Quantity INT = 2;  
DECLARE @ShippingAddress NVARCHAR(255) = '123 Shipping St';
DECLARE @Email NVARCHAR(100) = 'customer@example.com';  

EXEC CreateOrderWithValidation
    @CustomerID,
    @ProductID,
    @Quantity,
    @ShippingAddress,
    @Email,
     @OrderID,
    @OrderTotal;

PRINT 'Order ID: ' + CAST(@OrderID AS NVARCHAR(10));
PRINT 'Order Total: ' + CAST(@OrderTotal AS NVARCHAR(20));


