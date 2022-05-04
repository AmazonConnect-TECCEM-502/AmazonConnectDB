-- DROP DATABASE `capstone`;
CREATE DATABASE IF NOT EXISTS `capstone`;
USE capstone;

-- User table
/*
Constraints:
- Primary key: agent_id
- Check: user_type IN ('agent','manager','admin')
*/
CREATE TABLE IF NOT EXISTS `User` (
	user_id INT NOT NULL AUTO_INCREMENT,
	first_name NVARCHAR(50) NOT NULL,
	last_name NVARCHAR(50) NOT NULL,
    email NVARCHAR(320) NOT NULL,
    user_type NVARCHAR(20) NOT NULL,
    cognito_uuid NVARCHAR(255) NOT NULL,
    manager_id  INT,
    PRIMARY KEY (user_id),
    CHECK (LOWER(user_type) IN ('agent','manager','admin')),
    FOREIGN KEY (manager_id) REFERENCES User(user_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Client table
/*
Constraints:
- Primary key: client_id
*/
CREATE TABLE IF NOT EXISTS `Client` (
	client_id INT NOT NULL AUTO_INCREMENT,
	first_name NVARCHAR(50) NOT NULL,
	last_name NVARCHAR(50) NOT NULL,
    email NVARCHAR(320) NOT NULL,
    manager_id INT NOT NULL,
    PRIMARY KEY (client_id)
);

-- Call table
/*
Constraints:
- Primary key: call_id
- Rating:
  * Unrated call = 0
  * Rated call = 1-5
- Duration should be more than 0 seconds
Relationships:
- One call should have ONLY ONE agent
- One call should have ONLY ONE client
*/
CREATE TABLE IF NOT EXISTS `Call` (
	call_id INT NOT NULL AUTO_INCREMENT,
	agent_id INT NOT NULL,
	client_id INT NOT NULL,
	created DATETIME DEFAULT CURRENT_TIMESTAMP,
    duration FLOAT NOT NULL,
    rating INT NOT NULL DEFAULT 0,
    video_url TEXT,
    transcription_url TEXT,
    PRIMARY KEY (call_id),
    FOREIGN KEY (agent_id) REFERENCES User(user_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES Client(client_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CHECK(rating BETWEEN 0 AND 5),
    CHECK(duration > 0)
);

-- Problem table
/*
Constraints:
- Primary key: problem_id
Relationships:
- One problem should have ONLY ONE creator (Agent).
*/
CREATE TABLE IF NOT EXISTS `Problem` (
	problem_id INT NOT NULL AUTO_INCREMENT,
	problem_description TEXT,
    submitted_by INT NOT NULL,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (problem_id),
    FOREIGN KEY (submitted_by) REFERENCES `User`(user_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Call-Problem (join) table
/*
Constraints:
- Primary key:
  * call_problem_id
  * problem_id
  * call_id
Relationships:
Join table:
 * One call can have many problems.
 * Same problem can be in many calls.
*/
CREATE TABLE IF NOT EXISTS `Call-Problem` (
	call_problem_id INT NOT NULL AUTO_INCREMENT,
	call_id INT NOT NULL,
    problem_id INT NOT NULL,
    PRIMARY KEY (call_problem_id),
    FOREIGN KEY (call_id) REFERENCES `Call`(call_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (problem_id) REFERENCES Problem(problem_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Solution table
/*
Constraints:
- Primary key: solution_id
Relationships:
- One solution can be approved by ZERO OR ONE manager
- One solution should be submitted by ONLY ONE agent
- One solution should be related to ONLY ONE problem
*/
CREATE TABLE IF NOT EXISTS `Solution` (
	solution_id INT NOT NULL AUTO_INCREMENT,
    problem_id INT NOT NULL,
	solution_description TEXT NOT NULL,
    submitted_by INT NOT NULL,
    approved BIT DEFAULT 0,
    approved_by INT,
    PRIMARY KEY (solution_id),
    FOREIGN KEY (submitted_by) REFERENCES `User`(user_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (problem_id) REFERENCES Problem(problem_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (approved_by) REFERENCES User(user_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Problem_category table
/*
Constraints:
- Primary key: category_id
*/
CREATE TABLE IF NOT EXISTS `Problem_category` (
	category_id INT NOT NULL AUTO_INCREMENT,
    category_name nvarchar(25) NOT NULL,
    category_description TEXT,
    PRIMARY KEY (category_id)
);

-- Category-Problem (join) table
/*
Constraints:
- Primary key:
  * category_problem_id
  * category_id
  * problem_id
Relationships:
Join table:
 * One problem can have many categories.
 * Same category can be in many problems.
*/
CREATE TABLE IF NOT EXISTS `Category-Problem` (
	category_problem_id INT NOT NULL AUTO_INCREMENT,
	category_id INT NOT NULL,
    problem_id INT NOT NULL,
    PRIMARY KEY (category_problem_id),
    FOREIGN KEY (category_id) REFERENCES Problem_category(category_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (problem_id) REFERENCES Problem(problem_id) ON UPDATE CASCADE ON DELETE CASCADE   
);

-- Product 
/*
Constraints:
- Primary key: product_id
*/
CREATE TABLE IF NOT EXISTS `Product` (
	product_id INT NOT NULL AUTO_INCREMENT,
    product_name NVARCHAR(50) NOT NULL,
    product_description TEXT,
    category INT NOT NULL,
    price FLOAT DEFAULT 0,
    stock INT DEFAULT 0,
    PRIMARY KEY (product_id)
);

-- Product_category table
/*
Constraints:
- Primary key: category_id
*/
CREATE TABLE IF NOT EXISTS `Product_category` (
	category_id INT NOT NULL AUTO_INCREMENT,
    category_name nvarchar(25) NOT NULL,
    category_description TEXT,
    PRIMARY KEY (category_id)
);

-- Category-Product (join) table
/*
Constraints:
- Primary key:
  * category_product_id
  * category_id
  * product_id
Relationships:
Join table:
 * One product can have many categories.
 * Same category can be in many products.
*/
CREATE TABLE IF NOT EXISTS `Category-Product` (
	category_product_id INT NOT NULL AUTO_INCREMENT,
	category_id INT NOT NULL,
    product_id INT NOT NULL,
    PRIMARY KEY (category_product_id),
    FOREIGN KEY (category_id) REFERENCES Product_category(category_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Orders table
/*
Constraints:
- Primary key: order_id
Relationships:
- One order should have ONE client
- One order should have ONE product
*/
CREATE TABLE IF NOT EXISTS `Order` (
	order_id INT NOT NULL AUTO_INCREMENT,
	client_id INT NOT NULL,
    product_id INT NOT NULL,
    purchased_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total FLOAT NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (client_id) REFERENCES `Client`(client_id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON UPDATE CASCADE ON DELETE CASCADE
);


