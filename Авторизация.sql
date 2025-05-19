USE HranitelPRO;

CREATE PROCEDURE AuthenticateUser (
    @email VARCHAR(255),
    @password VARCHAR(255)
)
AS
BEGIN
    -- ��������� ������� ������������ � ��������� email
    IF EXISTS (SELECT 1 FROM Users WHERE email = @email)
    BEGIN
        -- �������� ��� ������ �� ���� ������
        DECLARE @stored_password_hash VARCHAR(255);
        SELECT @stored_password_hash = password_hash FROM Users WHERE email = @email;

        -- ���������� ��������� ������ � ����� �� ���� ������
        IF HASHBYTES('SHA2_512', @password + CAST(Salt AS VARCHAR(36))) = @stored_password_hash
        BEGIN
            -- �������������� �������
            SELECT 'Authentication successful' AS Result;
        END
        ELSE
        BEGIN
            -- �������� ������
            SELECT 'Incorrect password' AS Result;
        END
    END
    ELSE
    BEGIN
        -- ������������ �� ������
        SELECT 'User not found' AS Result;
    END
END;