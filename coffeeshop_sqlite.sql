-- SQLite version of the CoffeeShop database
-- Converted from MySQL schema for simplified setup

-- Table structure for table admin_account
CREATE TABLE IF NOT EXISTS admin_account (
  admin_username TEXT PRIMARY KEY NOT NULL,
  admin_password TEXT NOT NULL DEFAULT 'password',
  role TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'Offline'
);

-- Dumping data for table admin_account
INSERT INTO admin_account (admin_username, admin_password, role, status) VALUES
('Admin', '123', 'Admin', 'Offline'),
('Khun', 'password', 'Cashier', 'Offline'),
('Muny', 'password', 'Cashier', 'Offline'),
('Setha', 'password', 'Barista', 'Offline'),
('Sothirich', '123', 'Cashier', 'Offline'),
('test', 'password', 'Barista', 'Offline'),
('test1', 'password', 'Barista', 'Offline');

-- Table structure for table drink_list
CREATE TABLE IF NOT EXISTS drink_list (
  drink_id INTEGER PRIMARY KEY AUTOINCREMENT,
  drink_name TEXT NOT NULL,
  drink_hot_price REAL NOT NULL,
  drink_iced_price REAL NOT NULL,
  drink_frappee_price REAL NOT NULL,
  drink_img TEXT NOT NULL DEFAULT 'resources/img/temp_icon.png'
);

-- Dumping data for table drink_list
INSERT INTO drink_list (drink_id, drink_name, drink_hot_price, drink_iced_price, drink_frappee_price, drink_img) VALUES
(1, 'Latte', 1.25, 2.80, 3.15, 'resources/img/Latte.png'),
(2, 'Cappucino', 1.25, 2.50, 2.75, 'resources/img/Cappuccino.png'),
(3, 'Americano', 1.30, 2.25, 3.25, 'resources/img/Americano.png'),
(4, 'Caramel Macchiato', 1.25, 2.80, 3.75, 'resources/img/Macchiato.png'),
(5, 'Condensed Milk', 1.00, 2.50, 2.80, 'resources/img/Milk.png'),
(6, 'Mocha', 1.25, 2.15, 2.65, 'resources/img/Mocha.png'),
(7, 'Test1', 1.00, 2.00, 3.00, 'resources/img/temp_icon.png');

-- Table structure for table customers (for sign up/login)
CREATE TABLE IF NOT EXISTS customers (
  customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
  customer_name TEXT NOT NULL,
  customer_email TEXT UNIQUE NOT NULL,
  customer_password TEXT NOT NULL,
  created_date DATE NOT NULL DEFAULT (DATE('now')),
  status TEXT NOT NULL DEFAULT 'Active'
);

-- Sample customer data
INSERT OR IGNORE INTO customers (customer_name, customer_email, customer_password) VALUES
('John Doe', 'john@example.com', 'password123'),
('Jane Smith', 'jane@example.com', 'password123');

-- Table structure for table feedback
CREATE TABLE IF NOT EXISTS feedback (
  feedback_id INTEGER PRIMARY KEY AUTOINCREMENT,
  customer_id INTEGER NOT NULL,
  order_id INTEGER,
  rating INTEGER NOT NULL CHECK(rating >= 1 AND rating <= 5),
  comment TEXT,
  feedback_date DATE NOT NULL DEFAULT (DATE('now')),
  feedback_time TIME NOT NULL DEFAULT (TIME('now')),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Table structure for table history
CREATE TABLE IF NOT EXISTS history (
  Nº INTEGER PRIMARY KEY AUTOINCREMENT,
  customer_id INTEGER NOT NULL,
  drink_name TEXT NOT NULL,
  drink_type TEXT NOT NULL,
  drink_price REAL NOT NULL,
  drink_quantity INTEGER NOT NULL,
  total_price REAL NOT NULL,
  date DATE NOT NULL DEFAULT (DATE('now')),
  time TIME NOT NULL DEFAULT (TIME('now')),
  status TEXT NOT NULL DEFAULT 'Ordered',
  confirmed_by TEXT,
  accepted_by TEXT
);

-- Sample data for table history
INSERT INTO history (customer_id, drink_name, drink_type, drink_price, drink_quantity, total_price, date, time, status, confirmed_by, accepted_by) VALUES
(1, 'Latte', 'Iced', 2.80, 2, 5.60, '2022-04-01', '09:28:45', 'Ordered', 'Sothirich', NULL),
(2, 'Condensed Milk', 'Hot', 1.00, 1, 1.00, '2022-04-02', '09:37:29', 'Completed', 'Sothirich', 'Sothirich'),
(2, 'Cappucino', 'Hot', 1.25, 1, 1.25, '2022-04-02', '09:37:29', 'Completed', 'Sothirich', 'Sothirich'),
(2, 'Mocha', 'Hot', 1.25, 1, 1.25, '2022-04-02', '09:37:29', 'Completed', 'Sothirich', 'Sothirich');

-- Table structure for table temp_admin
CREATE TABLE IF NOT EXISTS temp_admin (
  Nº INTEGER PRIMARY KEY AUTOINCREMENT,
  admin_username TEXT NOT NULL,
  admin_password TEXT NOT NULL DEFAULT 'password',
  role TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'Offline'
);

-- Sample data for table temp_admin
INSERT INTO temp_admin (admin_username, admin_password, role, status) VALUES
('Admin', '123', 'Admin', 'Active'),
('Khun', 'password', 'Cashier', 'Offline'),
('Muny', 'password', 'Cashier', 'Offline'),
('Setha', 'password', 'Barista', 'Offline'),
('Sothirich', '123', 'Cashier', 'Offline'),
('test', 'password', 'Barista', 'Offline'),
('test1', 'password', 'Barista', 'Offline');

-- Table structure for table temp_customer
CREATE TABLE IF NOT EXISTS temp_customer (
  Nº INTEGER PRIMARY KEY AUTOINCREMENT,
  customer_id INTEGER NOT NULL,
  drink_name TEXT NOT NULL,
  drink_type TEXT NOT NULL,
  drink_price REAL NOT NULL,
  drink_quantity INTEGER NOT NULL,
  total_price REAL NOT NULL
);

-- Sample data for table temp_customer
INSERT INTO temp_customer (customer_id, drink_name, drink_type, drink_price, drink_quantity, total_price) VALUES
(24, 'Caramel Macchiato', 'Hot', 1.25, 2, 2.50),
(24, 'Condensed Milk', 'Hot', 1.00, 1, 1.00);

-- Table structure for table temp_drinklist
CREATE TABLE IF NOT EXISTS temp_drinklist (
  drink_id INTEGER PRIMARY KEY AUTOINCREMENT,
  drink_name TEXT NOT NULL,
  drink_hot_price REAL NOT NULL,
  drink_iced_price REAL NOT NULL,
  drink_frappee_price REAL NOT NULL,
  drink_img TEXT NOT NULL DEFAULT 'resources/img/temp_icon.png'
);

-- Sample data for table temp_drinklist
INSERT INTO temp_drinklist (drink_id, drink_name, drink_hot_price, drink_iced_price, drink_frappee_price, drink_img) VALUES
(1, 'Latte', 1.25, 2.80, 3.15, 'resources/img/Latte.png'),
(2, 'Cappucino', 1.25, 2.50, 2.75, 'resources/img/Cappuccino.png'),
(3, 'Americano', 1.30, 2.25, 3.25, 'resources/img/Americano.png'),
(4, 'Caramel Macchiato', 1.25, 2.80, 3.75, 'resources/img/Macchiato.png'),
(5, 'Condensed Milk', 1.00, 2.50, 2.80, 'resources/img/Milk.png'),
(6, 'Mocha', 1.25, 2.15, 2.65, 'resources/img/Mocha.png'),
(7, 'Test1', 1.00, 2.00, 3.00, 'resources/img/temp_icon.png');