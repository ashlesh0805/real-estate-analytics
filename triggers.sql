-- Trigger: update updated_at when a property is updated
CREATE TRIGGER update_property_timestamp
ON dbo.Properties
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the updated_at column for rows that were updated.
    -- Replace 'id' with the actual primary key column name if different.
    UPDATE p
    SET updated_at = SYSUTCDATETIME()
    FROM dbo.Properties p
    INNER JOIN inserted i ON p.id = i.id;
END;
GO
