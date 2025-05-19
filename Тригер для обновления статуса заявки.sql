CREATE TRIGGER tr_UpdateRequestStatusOnVisitorAdd
ON Visitor
AFTER INSERT
AS
BEGIN
    UPDATE AccessRequests
    SET Status = 'Обработана'
    WHERE RequestID IN (SELECT Request FROM inserted)
    AND Status = 'Новая'
    AND RequestType = 'Личная'
END