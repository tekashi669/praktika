CREATE TRIGGER tr_UpdateRequestStatusOnVisitorAdd
ON Visitor
AFTER INSERT
AS
BEGIN
    UPDATE AccessRequests
    SET Status = '����������'
    WHERE RequestID IN (SELECT Request FROM inserted)
    AND Status = '�����'
    AND RequestType = '������'
END