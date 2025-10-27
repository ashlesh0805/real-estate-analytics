-- Procedure: Monthly sales report
CREATE PROCEDURE MonthlySalesReport
    @report_month INT,
    @report_year INT
AS
BEGIN
    SELECT p.property_id, p.address, t.sale_price, t.sale_date
    FROM Properties p
    JOIN Transactions t ON p.property_id = t.property_id
    WHERE MONTH(t.sale_date) = @report_month AND YEAR(t.sale_date) = @report_year
    ORDER BY t.sale_date;
END;
