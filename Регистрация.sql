CREATE PROCEDURE RegisterUser (
    @email VARCHAR(255),
    @password VARCHAR(255),
    @first_name VARCHAR(50),
    @last_name VARCHAR(50),
    @middle_name VARCHAR(50),
    @phone VARCHAR(20),
    @date_of_birth DATE,
    @purpose VARCHAR(255)
)
AS
BEGIN
    -- ���������, �� ���������� �� ������������ � ����� email
    IF NOT EXISTS (SELECT 1 FROM Users WHERE email = @email)
    BEGIN
        -- ���������� ��������� ���� (salt)
        DECLARE @salt UNIQUEIDENTIFIER = NEWID();

        -- �������� ������ � �������������� ����
        DECLARE @password_hash VARBINARY(64) = HASHBYTES('SHA2_512', @password + CAST(@salt AS VARCHAR(36)));

        -- ��������� ������ ������������ � ���� ������
        INSERT INTO Users (email, password_hash, first_name, last_name, middle_name, phone, date_of_birth, purpose, Salt)
        VALUES (@email, @password_hash, @first_name, @last_name, @middle_name, @phone, @date_of_birth, @purpose, @salt);

        -- ���������� ��������� �� �������� �����������
        SELECT 'Registration successful' AS Result;
    END
    ELSE
    BEGIN
        -- ���������� ���������, ��� ������������ � ����� email ��� ����������
        SELECT 'User with this email already exists' AS Result;
    END
END;