-- Agents
INSERT INTO Agents (first_name, last_name, email, phone, hire_date)
VALUES 
('John', 'Doe', 'john.doe@example.com', '1234567890', '2022-01-10'),
('Alice', 'Smith', 'alice.smith@example.com', '2345678901', '2021-06-15'),
('Robert', 'Brown', 'robert.brown@example.com', '3456789012', '2023-03-20');

-- Buyers
INSERT INTO Buyers (first_name, last_name, email, phone)
VALUES
('Michael', 'Johnson', 'michael.j@example.com', '4567890123'),
('Emily', 'Davis', 'emily.davis@example.com', '5678901234'),
('Sophia', 'Wilson', 'sophia.w@example.com', '6789012345');

-- Properties
INSERT INTO Properties (agent_id, address, city, state, zip_code, property_type, bedrooms, bathrooms, area_sqft, price, listed_date)
VALUES
(1, '123 Maple St', 'New York', 'NY', '10001', 'Apartment', 3, 2, 1200, 850000, '2025-01-15'),
(2, '456 Oak Ave', 'Los Angeles', 'CA', '90001', 'House', 4, 3, 2500, 1200000, '2025-02-20'),
(3, '789 Pine Rd', 'Chicago', 'IL', '60601', 'Condo', 2, 2, 950, 600000, '2025-03-05');

-- Transactions
INSERT INTO Transactions (property_id, buyer_id, sale_price, sale_date)
VALUES
(1, 1, 840000, '2025-03-10'),
(2, 2, 1180000, '2025-04-15'),
(3, 3, 590000, '2025-05-01');

-- Reviews
INSERT INTO Reviews (buyer_id, agent_id, rating, comments)
VALUES
(1, 1, 5, 'Excellent service!'),
(2, 2, 4, 'Good, but room for improvement'),
(3, 3, 5, 'Very professional');

-- Property Features
INSERT INTO Property_Features (property_id, feature_name)
VALUES
(1, 'Pool'), (1, 'Garage'),
(2, 'Garden'), (2, 'Basement'),
(3, 'Balcony');


