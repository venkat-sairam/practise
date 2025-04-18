-- Create Customer Master Table
CREATE TABLE Customer_Master (
    Order_Id VARCHAR(10),
    Customer_Id VARCHAR(10),
    Customer_Name VARCHAR(50),
    Shipping_Address VARCHAR(100),
    Billing_Address VARCHAR(100),
    Order_Date DATE,
    Product_Id VARCHAR(10),
    Product_Name VARCHAR(50),
    Quantity INT,
    Price_Per_Unit DECIMAL(10, 2),
    Subtotal DECIMAL(10, 2),
    Tax DECIMAL(10, 2),
    Store_Id VARCHAR(10),
    Store_Name VARCHAR(50),
    Biller_Id VARCHAR(10),
    Biller_Name VARCHAR(50)
);

-- Insert Data into Customer Master Table
INSERT INTO
    Customer_Master (
        Order_Id,
        Customer_Id,
        Customer_Name,
        Shipping_Address,
        Billing_Address,
        Order_Date,
        Product_Id,
        Product_Name,
        Quantity,
        Price_Per_Unit,
        Subtotal,
        Tax,
        Store_Id,
        Store_Name,
        Biller_Id,
        Biller_Name
    )
VALUES (
        'O001',
        'C001',
        'Alice Smith',
        '123 Oak St, Springfield',
        '123 Oak St, Springfield',
        '2025-01-01',
        'P001',
        'Laptop',
        2,
        1200.00,
        2400.00,
        200.00,
        'S001',
        'Downtown Store',
        'B001',
        'Visa'
    ),
    (
        'O002',
        'C002',
        'Bob Johnson',
        '456 Pine St, Metropolis',
        '456 Pine St, Metropolis',
        '2025-01-02',
        'P002',
        'Smartphone',
        1,
        800.00,
        800.00,
        64.00,
        'S002',
        'Uptown Store',
        'B002',
        'MasterCard'
    ),
    (
        'O003',
        'C003',
        'Carol Lee',
        '789 Maple St, Gotham',
        '789 Maple St, Gotham',
        '2025-01-03',
        'P003',
        'Headphones',
        3,
        150.00,
        450.00,
        36.00,
        'S003',
        'Mall Store',
        'B003',
        'PayPal'
    );


    -- Create Customer Dimension Table
CREATE TABLE Customer_Dim (
    Customer_Id VARCHAR(10) PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Shipping_Address VARCHAR(100),
    Billing_Address VARCHAR(100)
);

-- Create Store Dimension Table
CREATE TABLE Store_Dim (
    Store_Id VARCHAR(10) PRIMARY KEY,
    Store_Name VARCHAR(50)
);

-- Create Product Dimension Table
CREATE TABLE Product_Dim (
    Prod_Id VARCHAR(10) PRIMARY KEY,
    Prod_Name VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- Create Biller Dimension Table
CREATE TABLE Biller_Dim (
    Biller_Id VARCHAR(10) PRIMARY KEY,
    Biller_Name VARCHAR(50)
);

-- Create Date Dimension Table
CREATE TABLE Date_Dim (Order_Date DATE PRIMARY KEY);


-- Create Fact Table
CREATE TABLE Order_Fact (
    Order_Id VARCHAR(10) PRIMARY KEY,
    Qty INT,
    Subtotal DECIMAL(10, 2),
    Tax DECIMAL(10, 2),
    Prod_Id VARCHAR(10),
    Customer_Id VARCHAR(10),
    Store_Id VARCHAR(10),
    Biller_Id VARCHAR(10),
    Order_Date DATE,
    FOREIGN KEY (Prod_Id) REFERENCES Product_Dim (Prod_Id),
    FOREIGN KEY (Customer_Id) REFERENCES Customer_Dim (Customer_Id),
    FOREIGN KEY (Store_Id) REFERENCES Store_Dim (Store_Id),
    FOREIGN KEY (Biller_Id) REFERENCES Biller_Dim (Biller_Id),
    FOREIGN KEY (Order_Date) REFERENCES Date_Dim (Order_Date)
);



-- Create Master Table by Joining Fact Table and Dimensions
CREATE TABLE Master_Table AS
SELECT
    of.Order_Id,
    of.Qty AS Quantity,
    of.Subtotal,
    of.Tax,
    pd.Prod_Id AS Product_Id,
    pd.Prod_Name AS Product_Name,
    pd.Price AS Price_Per_Unit,
    cd.Customer_Id,
    cd.Customer_Name,
    cd.Shipping_Address,
    cd.Billing_Address,
    sd.Store_Id,
    sd.Store_Name,
    bd.Biller_Id,
    bd.Biller_Name,
    dd.Order_Date
FROM
    Order_Fact of
    JOIN Product_Dim pd ON of.Prod_Id = pd.Prod_Id
    JOIN Customer_Dim cd ON of.Customer_Id = cd.Customer_Id
    JOIN Store_Dim sd ON of.Store_Id = sd.Store_Id
    JOIN Biller_Dim bd ON of.Biller_Id = bd.Biller_Id
    JOIN Date_Dim dd ON of.Order_Date = dd.Order_Date;

-- View the Master Table
SELECT * FROM Master_Table;