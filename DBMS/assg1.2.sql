CREATE TABLE Publisher(PublisherName varchar(20), City varchar(20), Country varchar(20), TelephoneNumber number(10), YearOfFoundation number(4));
CREATE TABLE Author(AuthorNumber number(5), AuthorName varchar(20), DateOfBirth date);
CREATE TABLE Book(BookNumber number(5), BookName varchar(20), PublishedYear number(5), Pages number(5), Cost number(5), PublisherName varchar(20));
CREATE TABLE BookCust(CustomerNumber varchar(20), CustomerName varchar(20), Street varchar(50), City varchar(20), State varchar(20), Country varchar(20)); 
CREATE TABLE Writing(BookNumber number(5), AuthorNumber number(5));
CREATE TABLE Sale(BookNumber number(5), CustomerNumber number(5), DateOfSale date, Quantity number(5));


SELECT BookNumber, BookName, Pages FROM Book WHERE PublisherName = 'London Publishing Ltd.'
ORDER BY bookname ASC;

SELECT COUNT(BookNumber) FROM Book, Publisher WHERE pages > 400 AND book.publishername = publisher.publishername AND publisher.city = 'Paris' AND publisher.country = 'France';

SELECT DISTINCT publisher.PublisherName FROM Publisher, Author, Writing, Book 
WHERE Publisher.publishername = Book.publishername AND Book.booknumber = Writing.booknumber AND Writing.authornumber = Author.authornumber AND Author.dateofbirth < '01-JAN-1920' AND (Publisher.country = 'Belgium' OR Publisher.country = 'Brazil' OR Publisher.country = 'Singapore');

SELECT publisher.publishername, COUNT(*) FROM publisher, book
WHERE (publisher.city = 'Oslo' AND publisher.country='Norway') OR (publisher.city = 'Nairobi' AND publisher.country = 'Kenya') OR (publisher.city = 'Auckland' AND publisher.country = 'New Zealand') AND book.publishername=publisher.publishername AND book.publishedyear = 2001
GROUP BY publisher.publishername;

SELECT publisher.publishername FROM publisher, book WHERE publisher.publishername = book.publishername AND book.publishedyear = (SELECT MIN(book.publishedyear) FROM book);

COMMIT;