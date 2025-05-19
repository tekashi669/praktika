USE HranitelPRO;

CREATE PROCEDURE AuthenticateUser (
    @email VARCHAR(255),
    @password VARCHAR(255)
)
AS
BEGIN
    -- Проверяем наличие пользователя с указанным email
    IF EXISTS (SELECT 1 FROM Users WHERE email = @email)
    BEGIN
        -- Получаем хэш пароля из базы данных
        DECLARE @stored_password_hash VARCHAR(255);
        SELECT @stored_password_hash = password_hash FROM Users WHERE email = @email;

        -- Сравниваем введенный пароль с хэшем из базы данных
        IF HASHBYTES('SHA2_512', @password + CAST(Salt AS VARCHAR(36))) = @stored_password_hash
        BEGIN
            -- Аутентификация успешна
            SELECT 'Authentication successful' AS Result;
        END
        ELSE
        BEGIN
            -- Неверный пароль
            SELECT 'Incorrect password' AS Result;
        END
    END
    ELSE
    BEGIN
        -- Пользователь не найден
        SELECT 'User not found' AS Result;
    END
END;