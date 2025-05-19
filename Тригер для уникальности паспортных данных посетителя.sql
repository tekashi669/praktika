CREATE TRIGGER tr_CheckVisitorPassportUniqueness
ON Visitor
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted i
        JOIN Visitor v ON i.������� = v.������� AND i.VisitorID <> v.VisitorID
        WHERE i.Request <> v.Request
    )
    BEGIN
        RAISERROR('���������� ������ ������ ���� ����������� ��� ������ ������', 16, 1)
        ROLLBACK TRANSACTION
    END
END