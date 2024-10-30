-- Видалення таблиць з каскадним видаленням можливих описів цілісності
DROP TABLE Notification CASCADE CONSTRAINTS;
DROP TABLE HumidityLevel CASCADE CONSTRAINTS;
DROP TABLE HumidityLimits CASCADE CONSTRAINTS;
DROP TABLE User CASCADE CONSTRAINTS;
DROP TABLE NotificationSettings CASCADE CONSTRAINTS;

-- Створення таблиці HumidityLimits
CREATE TABLE HumidityLimits (
    humidityLimitsId INT PRIMARY KEY,
    minLimit FLOAT CHECK (minLimit BETWEEN 20 AND 40),
    maxLimit FLOAT CHECK (maxLimit BETWEEN 60 AND 80)
);

-- Створення таблиці NotificationSettings
CREATE TABLE NotificationSettings (
    notificationSettingsId INT PRIMARY KEY,
    settings VARCHAR(255)
);

-- Створення таблиці User з обмеженнями цілісності
CREATE TABLE User (
    userId INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    notificationSettingsId INT,
    FOREIGN KEY (notificationSettingsId) REFERENCES NotificationSettings(notificationSettingsId)
);

-- Обмеження для username: регулярний вираз для допустимих символів
ALTER TABLE User ADD CONSTRAINT username_format CHECK (username ~ '^[a-zA-Z0-9_]{3,50}$');

-- Обмеження для email: регулярний вираз для формату email
ALTER TABLE User ADD CONSTRAINT email_format CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');

-- Створення таблиці HumidityLevel з обмеженнями цілісності
CREATE TABLE HumidityLevel (
    humidityLevelId INT PRIMARY KEY,
    userId INT,
    humidityLimitsId INT,
    value FLOAT CHECK (value BETWEEN 0 AND 100),
    FOREIGN KEY (userId) REFERENCES User(userId),
    FOREIGN KEY (humidityLimitsId) REFERENCES HumidityLimits(humidityLimitsId)
);

-- Створення таблиці Notification з обмеженнями цілісності
CREATE TABLE Notification (
    notificationId INT PRIMARY KEY,
    userId INT,
    notificationSettingsId INT,
    type VARCHAR(50),
    notificationDate DATE,
    FOREIGN KEY (userId) REFERENCES User(userId),
    FOREIGN KEY (notificationSettingsId) REFERENCES NotificationSettings(notificationSettingsId)
);
