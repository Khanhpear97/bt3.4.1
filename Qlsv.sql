CREATE DATABASE QuanLySinhVien;
USE QuanLySinhVien;

CREATE TABLE Class(
	ClassID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME NOT NULL,
    Status BIT
);

CREATE TABLE Student(
	StudentID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(60),
    Address VARCHAR(50),
    Phone VARCHAR(20),
    Status BIT,
    ClassID INT NOT NULL,
    FOREIGN KEY (ClassID) REFERENCES Class (ClassID)
);

CREATE TABLE Subject(
	SubID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Subname VARCHAR(30),
    Credit TINYINT NOT NULL DEFAULT 1 CHECK (Credit >= 1),
    Status BIT DEFAULT 1
);

CREATE TABLE Mark (
	MarkId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	SubID INT NOT NULL,
	StudentID INT NOT NULL,
	Mark FLOAT DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
	ExamTimes TINYINT DEFAULT 1,
	UNIQUE (SubId, StudentId),
	FOREIGN KEY (SubId) REFERENCES Subject (SubId),
	FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);

INSERT INTO Class
VALUES (1, 'A1', '2008-12-20', 1);
INSERT INTO Class
VALUES (2, 'A2', '2008-12-22', 1);
INSERT INTO Class
VALUES (3, 'B3', CURRENT_DATE, 0);

INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1);
INSERT INTO Student (StudentName, Address, Status, ClassId)
VALUES ('Hoa', 'Hai phong', 1, 1);
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Manh', 'HCM', '0123123123', 0, 2);

INSERT INTO Subject
VALUES (1, 'CF', 5, 1),
(2, 'C', 6, 1),
(3, 'HDJ', 5, 1),
(4, 'RDBMS', 10, 1);

INSERT INTO Mark (SubID, StudentID, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
(1, 2, 10, 2),
(2, 1, 12, 1);

select *
from Subject
where credit = (select max(credit) from Subject);

select subject.*
from Subject join Mark on Subject.SubID = Mark.SubID
where Mark.mark = (select max(mark) from Mark);

select s.*, avg(m.mark) as average
from student s join Mark m on s.StudentID = m.StudentID
group by m.StudentID
order by average desc;

