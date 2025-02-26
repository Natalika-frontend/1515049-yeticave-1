CREATE DATABASE yeticave
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_general_ci;

USE yeticave;

CREATE TABLE categories (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  symbol_code VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE users (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  email VARCHAR(50) NOT NULL UNIQUE,
  name VARCHAR(100) NOT NULL,
  password CHAR(60) NOT NULL,
  contacts VARCHAR(500)
);

CREATE TABLE lots (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  title VARCHAR(100) NOT NULL,
  description TEXT,
  image_url VARCHAR(255),
  start_price INT UNSIGNED NOT NULL,
  ended_at DATETIME NOT NULL,
  rate_step INT UNSIGNED NOT NULL,
  author_id INT UNSIGNED NOT NULL,
  winner_id INT UNSIGNED DEFAULT NULL,
  category_id INT UNSIGNED NOT NULL,
  FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (winner_id) REFERENCES users(id) ON DELETE SET NULL,
  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

CREATE TABLE rates (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  amount INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  lot_id INT UNSIGNED NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (lot_id) REFERENCES lots(id) ON DELETE CASCADE
);

CREATE FULLTEXT INDEX fulltext_title_description ON lots (title, description);
