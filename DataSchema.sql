-- Створення таблиці HumidityLimits
CREATE TABLE humidity_limits (
    humidity_limits_id INT PRIMARY KEY,
    min_limit FLOAT CHECK (min_limit BETWEEN 20 AND 40),
    max_limit FLOAT CHECK (max_limit BETWEEN 60 AND 80)
);

-- Створення таблиці NotificationSettings
CREATE TABLE notification_settings (
    notification_settings_id INT PRIMARY KEY,
    settings VARCHAR(255)
);

-- Створення таблиці Users
-- Обмеження для username: регулярний вираз для допустимих символів
-- Обмеження для email: регулярний вираз для формату email
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL CHECK (username ~ '^[a-zA-Z0-9_]{3,50}$'),
    email VARCHAR(100) NOT NULL
    CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    notification_settings_id INT,
    FOREIGN KEY (notification_settings_id)
    REFERENCES notification_settings (notification_settings_id)
);

-- Створення таблиці HumidityLevel
CREATE TABLE humidity_level (
    humidity_level_id INT PRIMARY KEY,
    user_id INT,
    humidity_limits_id INT,
    value_of_level FLOAT CHECK (value BETWEEN 0 AND 100),
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (humidity_limits_id)
    REFERENCES humidity_limits (humidity_limits_id)
);

-- Створення таблиці Notification
CREATE TABLE notification (
    notification_id INT PRIMARY KEY,
    user_id INT,
    notification_settings_id INT,
    type_of_notification VARCHAR(50),
    notification_date DATE,
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    FOREIGN KEY (notification_settings_id)
    REFERENCES notification_settings (notification_settings_id)
);
