USE HranitelPRO;

-- Таблица пользователей
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    phone VARCHAR(20),
    date_of_birth DATE NOT NULL,
    purpose VARCHAR(255) NOT NULL -- Назначение
);

-- Таблица отделов
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Таблица подразделений
CREATE TABLE Subdivision (
    subdivision_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id) -- Связь с таблицей отделов
);

-- Таблица статусов заявок
CREATE TABLE RequestStatus (
    status_id INT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL -- Например, 'pending', 'approved', 'denied'
);

-- Таблица сотрудников
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    subdivision_id INT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    employee_code VARCHAR(20), -- Код сотрудника
    FOREIGN KEY (subdivision_id) REFERENCES Subdivision(subdivision_id) -- Связь с таблицей подразделений
);

-- Таблица заявок
CREATE TABLE Request (
    request_id INT PRIMARY KEY,
    user_id INT,
    request_type VARCHAR(50) NOT NULL, -- Изменено на VARCHAR(50) для поддержки более длинных значений
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    purpose VARCHAR(255) NOT NULL,
    subdivision_id INT,
    employee_id INT,
    status_id INT, -- Изменено на внешний ключ для статуса
    denial_reason VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (subdivision_id) REFERENCES Subdivision(subdivision_id), -- Связь с таблицей подразделений
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (status_id) REFERENCES RequestStatus(status_id) -- Связь с таблицей статусов
);

-- Таблица посетителей
CREATE TABLE Visitor (
    visitor_id INT PRIMARY KEY,
    request_id INT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    passport_series VARCHAR(4) NOT NULL,
    passport_number VARCHAR(6) NOT NULL,
    login VARCHAR(50) NOT NULL, -- Логин
    password VARCHAR(255) NOT NULL, -- Пароль
    purpose VARCHAR(255) NOT NULL, -- Назначение
    FOREIGN KEY (request_id) REFERENCES Request(request_id)
);

-- Таблица групповых посетителей
CREATE TABLE GroupVisitor (
    group_visitor_id INT PRIMARY KEY,
    request_id INT,
    order_number INT NOT NULL, -- Порядковый номер в группе
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    passport_series VARCHAR(4) NOT NULL,
    passport_number VARCHAR(6) NOT NULL,
    group_name VARCHAR(255) NOT NULL, -- Группа
    login VARCHAR(50) NOT NULL, -- Логин
    password VARCHAR(255) NOT NULL, -- Пароль
    purpose VARCHAR(255) NOT NULL, -- Назначение
    FOREIGN KEY (request_id) REFERENCES Request(request_id)
);
