CREATE TRIGGER tr_CheckVisitorPassportUniqueness
ON Visitor
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted i
        JOIN Visitor v ON i.Паспорт = v.Паспорт AND i.VisitorID <> v.VisitorID
        WHERE i.Request <> v.Request
    )
    BEGIN
        RAISERROR('Паспортные данные должны быть уникальными для разных заявок', 16, 1)
        ROLLBACK TRANSACTION
    END
END