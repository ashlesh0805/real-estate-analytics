-- 1️⃣ Average property price by city
SELECT city, ROUND(AVG(price), 2) AS avg_price
FROM dbo.Properties
GROUP BY city
ORDER BY avg_price DESC;

-- 2️⃣ Top 3 agents by total sales
SELECT a.agent_id, a.first_name + ' ' + a.last_name AS agent_name,
       SUM(t.sale_price) AS total_sales
FROM dbo.Agents a
JOIN dbo.Properties p ON a.agent_id = p.agent_id
JOIN dbo.Transactions t ON p.property_id = t.property_id
GROUP BY a.agent_id, a.first_name, a.last_name
ORDER BY total_sales DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

-- 3️⃣ Recent 5 property listings
SELECT TOP 5 property_id, address, city, price, listed_date
FROM dbo.Properties
ORDER BY listed_date DESC;

-- 4️⃣ Properties with highest demand (most transactions)
SELECT p.property_id, p.address, COUNT(t.transaction_id) AS transactions_count
FROM dbo.Properties p
LEFT JOIN dbo.Transactions t ON p.property_id = t.property_id
GROUP BY p.property_id, p.address
ORDER BY transactions_count DESC;

-- 5️⃣ Average rating per agent
SELECT a.agent_id, a.first_name + ' ' + a.last_name AS agent_name,
       ROUND(AVG(r.rating), 2) AS avg_rating
FROM dbo.Agents a
JOIN dbo.Reviews r ON a.agent_id = r.agent_id
GROUP BY a.agent_id, a.first_name, a.last_name
ORDER BY avg_rating DESC;

-- 6️⃣ Properties sold above average price
SELECT p.property_id, p.address, t.sale_price
FROM dbo.Properties p
JOIN dbo.Transactions t ON p.property_id = t.property_id
WHERE t.sale_price > (SELECT AVG(sale_price) FROM dbo.Transactions)
ORDER BY t.sale_price DESC;

-- 7️⃣ Monthly sales summary for the current year
SELECT MONTH(sale_date) AS sale_month, COUNT(*) AS total_sales,
       SUM(sale_price) AS total_revenue
FROM dbo.Transactions
WHERE YEAR(sale_date) = YEAR(GETDATE())
GROUP BY MONTH(sale_date)
ORDER BY sale_month;

-- 8️⃣ Buyer transaction history
SELECT b.buyer_id, b.first_name + ' ' + b.last_name AS buyer_name,
       p.address, t.sale_price, t.sale_date
FROM dbo.Buyers b
JOIN dbo.Transactions t ON b.buyer_id = t.buyer_id
JOIN dbo.Properties p ON t.property_id = p.property_id
ORDER BY t.sale_date DESC;

-- 9️⃣ Agent performance with average sale price
SELECT a.agent_id, a.first_name + ' ' + a.last_name AS agent_name,
       COUNT(t.transaction_id) AS total_sales,
       ROUND(AVG(t.sale_price), 2) AS avg_sale_price
FROM dbo.Agents a
JOIN dbo.Properties p ON a.agent_id = p.agent_id
JOIN dbo.Transactions t ON p.property_id = t.property_id
GROUP BY a.agent_id, a.first_name, a.last_name
ORDER BY total_sales DESC;

-- 🔟 High-demand cities by number of properties sold
SELECT p.city, COUNT(t.transaction_id) AS total_properties_sold,
       ROUND(AVG(t.sale_price), 2) AS avg_sale_price
FROM dbo.Properties p
JOIN dbo.Transactions t ON p.property_id = t.property_id
GROUP BY p.city
ORDER BY total_properties_sold DESC;

-- 11️⃣ Properties with specific features (e.g., Pool or Garage)
SELECT p.property_id, p.address, pf.feature_name
FROM dbo.Properties p
JOIN dbo.Property_Features pf ON p.property_id = pf.property_id
WHERE pf.feature_name IN ('Pool', 'Garage')
ORDER BY p.property_id;

-- 12️⃣ Top-rated agents with at least 2 reviews
SELECT a.agent_id, a.first_name + ' ' + a.last_name AS agent_name,
       ROUND(AVG(r.rating), 2) AS avg_rating, COUNT(r.review_id) AS review_count
FROM dbo.Agents a
JOIN dbo.Reviews r ON a.agent_id = r.agent_id
GROUP BY a.agent_id, a.first_name, a.last_name
HAVING COUNT(r.review_id) >= 2
ORDER BY avg_rating DESC;

-- 13️⃣ Price trends per property type
SELECT property_type, YEAR(listed_date) AS year, MONTH(listed_date) AS month,
       ROUND(AVG(price), 2) AS avg_price
FROM dbo.Properties
GROUP BY property_type, YEAR(listed_date), MONTH(listed_date)
ORDER BY property_type, year, month;

-- 14️⃣ Buyer with highest total purchase value
SELECT TOP 1 b.buyer_id, b.first_name + ' ' + b.last_name AS buyer_name,
       SUM(t.sale_price) AS total_spent
FROM dbo.Buyers b
JOIN dbo.Transactions t ON b.buyer_id = t.buyer_id
GROUP BY b.buyer_id, b.first_name, b.last_name
ORDER BY total_spent DESC;

-- 15️⃣ Agent ranking by total sales using window functions
SELECT agent_id, agent_name, total_sales,
       RANK() OVER(ORDER BY total_sales DESC) AS sales_rank
FROM (
    SELECT a.agent_id, a.first_name + ' ' + a.last_name AS agent_name,
           SUM(t.sale_price) AS total_sales
    FROM dbo.Agents a
    JOIN dbo.Properties p ON a.agent_id = p.agent_id
    JOIN dbo.Transactions t ON p.property_id = t.property_id
    GROUP BY a.agent_id, a.first_name, a.last_name
) AS AgentSales;