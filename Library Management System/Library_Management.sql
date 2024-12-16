CREATE DATABASE library_db;
USE library_db;

CREATE TABLE books(
	book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    year_published INT,
    status VARCHAR(50) DEFAULT 'available'
);

CREATE TABLE members(
	member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    join_date DATE
);

CREATE TABLE loans(
	loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO books
(title, author, genre, year_published)
VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925),
('1984', 'George Orewell', 'Dystopian', 1949),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960);

INSERT INTO members
(name, email, join_date)
VALUES
('John Doe', 'john.doe@example.com', '2024-01-15'),
('Jane Smith', 'jane.smith@example.com', '2024-02-20');

INSERT INTO loans
(book_id, member_id, loan_date)
VALUES
(1,1, CURDATE());
UPDATE books SET status = 'loaned' WHERE book_id = 1;

UPDATE loans SET return_date = CURDATE() WHERE loan_id = 1;
UPDATE books SET status = 'available' WHERE book_id = 1;

DELIMITER $$
CREATE TRIGGER after_loan_insert AFTER INSERT ON loans
FOR EACH ROW
BEGIN
	UPDATE books SET status = 'loaned'
WHERE book_id = NEW.book_id;
END $$
DELIMITER ;

DELIMITER //
CREATE PROCEDURE return_book(IN loanID INT)
BEGIN
	UPDATE loans SET return_date = CURDATE() WHERE loan_id = loanID;
    UPDATE books SET status = 'available' WHERE book_id = (SELECT book_id FROM loans WHERE loan_id = loanID);
END //
DELIMITER ;

SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM loans;