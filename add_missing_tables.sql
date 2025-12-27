-- Add missing tables to existing database
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
  feedback_time TIME NOT NULL DEFAULT (TIME('now'))
);