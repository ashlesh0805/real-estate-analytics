-- View: High-demand properties


USE real_estate_analytics;

IF OBJECT_ID('dbo.HighDemandProperties', 'V') IS NOT NULL
    DROP VIEW dbo.HighDemandProperties;
GO
CREATE VIEW dbo.HighDemandProperties AS
SELECT
    p.property_id,
    p.address,
    p.city,
    COUNT(t.transaction_id) AS total_sales
FROM dbo.Properties p
JOIN dbo.Transactions t ON p.property_id = t.property_id
GROUP BY
    p.property_id,
    p.address,
    p.city
HAVING COUNT(t.transaction_id) >= 1;
GO

-- View: Top agents
IF OBJECT_ID('dbo.TopAgents', 'V') IS NOT NULL
    DROP VIEW dbo.TopAgents;
GO
CREATE VIEW dbo.TopAgents AS
SELECT
    a.agent_id,
    a.first_name + ' ' + a.last_name AS agent_name,
    SUM(t.sale_price) AS total_sales
FROM dbo.Agents a
JOIN dbo.Properties p ON a.agent_id = p.agent_id
JOIN dbo.Transactions t ON p.property_id = t.property_id
GROUP BY
    a.agent_id,
    a.first_name,
    a.last_name;
GO
