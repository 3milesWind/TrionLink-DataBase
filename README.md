公用的url
<p style="color:red" >ReadMe</p>
localHost: 5432 <br/>
dataBase: postgres<br/>
user: postgres<br/>
password: 4645<br/>

```Java
String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
```
```sql
// undergrauate
insert into student values('A1001','1','Benjamin','','B','California resident','Current enrolled','Undergraduate');
insert into Undergraduate values('A1001','Computer Science','','Warren');

insert into student values('A1002','2','Kristen','','W','California resident','Current enrolled','Undergraduate');
insert into Undergraduate values('A1002','Computer Science','','Warren');

insert into student values('A1003','3','Daniel','','F','California resident','Current enrolled','Undergraduate');
insert into Undergraduate values('A1003','Computer Science','','Warren');

insert into student values('A1004','4','Claire','','J','California resident','Current enrolled','Undergraduate');
insert into Undergraduate values('A1004','Computer Science','','Warren');

insert into student values('A1005','5','Julie','','C','California resident','Current enrolled','Undergraduate');
insert into Undergraduate values('A1005','Computer Science','','Warren');

insert into student values('A1006','6','Kevin','','L','California resident','Current enrolled','Undergraduate');
insert into Undergraduate values('A1006','Mechanical Engineering','','Warren');

insert into student values('A1007','7','Michael','','B','California resident','Current enrolled','Undergraduate');
insert into Undergraduate values('A1007','Mechanical Engineering','','Warren');

insert into student values('A1008','8','Joseph','','J','California resident','Current enrolled','Undergraduate');
insert into Undergraduate values('A1008','Mechanical Engineering','','Warren');

insert into student values('A1009','9','Devin','','P','California resident','Current enrolled','Undergraduate');
insert into Undergraduate values('A1009','Mechanical Engineering','','Warren');

insert into student values('A1010','10','Logan','','F','California resident','Current enrolled','Undergraduate');
insert into Undergraduate values('A1010','Mechanical Engineering','','Warren');

insert into student values('A1011','11','Vikram','','N','California resident','Current enrolled','Undergraduate');
insert into Undergraduate values('A1011','Philosophy','','Warren');

insert into student values('A1012','12','Rachel','','Z','California resident','Current enrolled','Undergraduate');
insert into Undergraduate values('A1012','Philosophy','','Warren');

insert into student values('A1013','13','Zach','','M','California resident','Current enrolled','Undergraduate');
insert into Undergraduate values('A1013','Philosophy','','Warren');

insert into student values('A1014','14','Justin','','H','California resident','Current enrolled','Undergraduate');
insert into Undergraduate values('A1014','Philosophy','','Warren');

insert into student values('A1015','15','Rahul','','R','California resident','Current enrolled','Undergraduate');
insert into Undergraduate values('A1015','Philosophy','','Warren');

// master
insert into student values('A1016','16','Dave','','C','Non-CA US','Current enrolled','Master');
insert into master values('A1016','Master','CSE',0);

insert into student values('A1017','17','Nelson','','H','Non-CA US','Current enrolled','Master');
insert into master values('A1017','Master','CSE',0);

insert into student values('A1018','18','Andrew','','P','Non-CA US','Current enrolled','Master');
insert into master values('A1018','Master','CSE',0);

insert into student values('A1019','19','Nathan','','S','Non-CA US','Current enrolled','Master');
insert into master values('A1019','Master','CSE',0);

insert into student values('A1020','20','John','','H','Non-CA US','Current enrolled','Master');
insert into master values('A1020','Master','CSE',0);

insert into student values('A1021','21','Anwell','','W','Non-CA US','Current enrolled','Master');
insert into master values('A1021','Master','CSE',0);

insert into student values('A1022','22','Tim','','K','Non-CA US','Current enrolled','Master');
insert into master values('A1022','Master','CSE',0);


// faculty
insert into faculty values('Justin Bieber','Associate Professor','CSE');
insert into faculty values('Flo Rida','Professor','CSE');
insert into faculty values('Selena Gomez','Professor','CSE');
insert into faculty values('Adele','Professorr','CSE');
insert into faculty values('Taylor Swift','Professor','CSE');
insert into faculty values('Kelly Clarkson','Professor','CSE');
insert into faculty values('Adam Levine','Professor','CSE');
insert into faculty values('Bjork','Professor','CSE');

//degree

INSERT into degree values('B.S.','Computer Science','CSE',40,10,15,15);
INSERT into degree values('B.A.','Philosophy','CSE',35,15,20,0);
INSERT into degree values('B.S.','Mechanical Engineering','CSE',50,20,20,10);
INSERT into degree values('M.S.','Computer Science','CSE',45,0,0,0);

// concentration
Insert into concentration values('M.S.','Database','Computer Science','CSE232A','CSE250A,CSE221,CSE105,MAE107,MAE3',3,4);
Insert into concentration values('M.S.','AI','Computer Science','CSE255,CSE250A','CSE250A,CSE221,CSE105,MAE107,MAE3',3.1,8);
Insert into concentration values('M.S.','System','Computer Science','CSE221','CSE250A,CSE221,CSE105,MAE107,MAE3',3.3,4);

//past_couse
insert into past_course values('A1001','CSE8A',4,'A-','Winter','2017','CSE8A-wi17-1','Letter Grade');
insert into past_course values('A1003','CSE8A',4,'B+','Winter','2017','CSE8A-wi17-1','Letter Grade');
insert into past_course values('A1002','CSE8A',4,'C-','Fall','2017','CSE8A-fa17-1','Letter Grade');
insert into past_course values('A1004','CSE8A',4,'A-','Winter','2018','CSE8A-wi18-1','Letter Grade');
insert into past_course values('A1005','CSE8A',4,'B','Winter','2018','CSE8A-wi18-1','Letter Grade');

insert into past_course values('A1001','CSE105',4,'A-','Spring','2017','CSE105-sp17-1','Letter Grade');
insert into past_course values('A1005','CSE105',4,'B+','Spring','2017','CSE105-sp17-1','Letter Grade');
insert into past_course values('A1004','CSE105',4,'C','Spring','2017','CSE105-sp17-1','Letter Grade');

insert into past_course values('A1016','CSE250A',4,'C','Winter','2017','CSE250A-wi17-1','Letter Grade');
insert into past_course values('A1022','CSE250A',4,'B+','Winter','2018','CSE250A-wi18-1','Letter Grade');
insert into past_course values('A1018','CSE250A',4,'D','Winter','2018','CSE250A-wi18-1','Letter Grade');
insert into past_course values('A1019','CSE250A',4,'F','Winter','2018','CSE250A-wi18-1','Letter Grade');

insert into past_course values('A1017','CSE250B',4,'A','Spring','2017','CSE250B-sp17-1','Letter Grade');
insert into past_course values('A1019','CSE250B',4,'A','Spring','2017','CSE250B-sp17-1','Letter Grade');

insert into past_course values('A1020','CSE255',4,'B-','Winter','2018','CSE255-wi18-1','Letter Grade');
insert into past_course values('A1018','CSE255',4,'B','Winter','2018','CSE255-wi18-1','Letter Grade');
insert into past_course values('A1021','CSE255',4,'F','Winter','2018','CSE255-wi18-1','Letter Grade');

insert into past_course values('A1017','CSE232A',4,'A-','Winter','2018','CSE232A-wi18-1','Letter Grade');

insert into past_course values('A1022','CSE221',4,'A','Fall','2017','CSE221-fa17-1','Letter Grade');
insert into past_course values('A1020','CSE221',4,'A','Fall','2017','CSE221-fa17-1','Letter Grade');

insert into past_course values('A1010','MAE107',4,'B+','Fall','2017','MAE107-fa17-1','Letter Grade');

insert into past_course values('A1008','MAE108',2,'B-','Winter','2017','MAE108-wi17-1','Letter Grade');
insert into past_course values('A1007','MAE108',2,'A-','Winter','2017','MAE108-wi17-1','Letter Grade');
insert into past_course values('A1006','MAE108',2,'B','Spring','2017','MAE108-sp17-1','Letter Grade');
insert into past_course values('A1010','MAE108',2,'B+','Spring','2017','MAE108-sp17-1','Letter Grade');

insert into past_course values('A1011','PHIL10',4,'A','Winter','2018','PHIL10-wi18-1','Letter Grade');
insert into past_course values('A1012','PHIL10',4,'A','Winter','2018','PHIL10-wi18-1','Letter Grade');
insert into past_course values('A1013','PHIL10',4,'C-','Winter','2018','PHIL10-wi18-1','Letter Grade');
insert into past_course values('A1014','PHIL10',4,'C+','Winter','2018','PHIL10-wi18-1','Letter Grade');

insert into past_course values('A1015','PHIL165',2,'F','Fall','2017','PHIL165-fa17-1','Letter Grade');
insert into past_course values('A1012','PHIL165',2,'D','Fall','2017','PHIL165-fa17-1','Letter Grade');
insert into past_course values('A1011','PHIL165',2,'A-','Winter','2018','PHIL165-wi18-1','Letter Grade');

// course
insert into Course values ('CSE8A', '.', 'CSE', '.', 'Letter or S/U', 'No', '4', '5'),
('CSE105', '.', 'CSE', '.', 'Letter or S/U', 'No', '4', '5'),
('CSE123', '.', 'CSE', '.', 'Letter or S/U', 'No', '4', '5'),
('CSE250A', '.', 'CSE', '.', 'Letter or S/U', 'No', '4', '5'),
('CSE250B', '.', 'CSE', '.', 'Letter or S/U', 'No', '4', '5'),
('CSE255', '.', 'CSE', '.', 'Letter or S/U', 'No', '4', '4'),
('CSE232A', '.', 'CSE', '.', 'Letter or S/U', 'No', '4', '4'),
('CSE221', '.', 'CSE', '.', 'Letter or S/U', 'No', '4', '4'),
('MAE3', '.', 'CSE', '.', 'Letter or S/U', 'No', '4', '5'),
('MAE107', '.', 'CSE', '.', 'Letter or S/U', 'No', '4', '5'),
('MAE108', '.', 'CSE', '.', 'Letter or S/U', 'No', '4', '5'),
('PHIL10', '.', 'CSE', '.', 'Letter or S/U', 'No', '2', '2'),
('PHIL12', '.', 'CSE', '.', 'Letter or S/U', 'No', '4', '5'),
('PHIL165', '.', 'CSE', '.', 'Letter or S/U', 'No', '2', '5'),
('PHIL167', '.', 'CSE', '.', 'Letter or S/U', 'No', '2', '5');

// class
insert into Class values ('CSE8A-wi17', 'CSE8A', 'Introduction to Computer Science: Java', 'Winter', '2017', '2', 'Spring,2022'),
('CSE8A-fa17', 'CSE8A', 'Introduction to Computer Science: Java', 'Fall', '2017', '2', 'Spring,2022'),
('CSE8A-wi18', 'CSE8A', 'Introduction to Computer Science: Java', 'Winter', '2018', '2', 'Spring,2022'),
('CSE105-sp17', 'CSE105', 'Intro to Theory', 'Spring', '2017', '2', 'Fall,2021'),
('CSE250A-wi17', 'CSE250A', 'Probabilistic Reasoning', 'Winter', '2017', '2', 'Winter,2022'),
('CSE250A-wi18', 'CSE250A', 'Probabilistic Reasoning', 'Winter', '2018', '2', 'Winter,2022'),
('CSE250B-sp17', 'CSE250B', 'Machine Learning', 'Spring', '2017', '2', 'Fall,2022'),
('CSE255-wi18', 'CSE255', 'Data Mining and Predictive Analytics', 'Winter', '2018', '2', 'Winter,2022'),
('CSE232A-wi18', 'CSE232A', 'Databases', 'Winter', '2018', '2', 'Spring,2022'),
('CSE221-fa17', 'CSE221', 'Operating Systems', 'Fall', '2017', '2', 'Fall,2021'),
('MAE107-fa17', 'MAE107', 'Computational Methods', 'Fall', '2017', '2', 'Spring,2022'),
('MAE108-wi17', 'MAE108', 'Probability and Statistics', 'Winter', '2017', '2', 'Fall,2021'),
('MAE108-sp17', 'MAE108', 'Probability and Statistics', 'Spring', '2017', '2', 'Fall,2021'),
('PHIL10-wi18', 'PHIL10', 'Intro to Logic', 'Winter', '2018', '2', 'Winter,2022'),
('PHIL165-fa17', 'PHIL165', 'Freedom, Equality, and the Law', 'Fall', '2017', '2', 'Spring,2022'),
('MAE108-sp21', 'MAE108', 'Probability and Statistics', 'Spring', '2021', '2', 'Fall,2021'),
('CSE255-sp21', 'CSE255', 'Data Mining and Predictive Analytics', 'Spring', '2021', '2', 'Winter,2022'),
('CSE8A-sp21', 'CSE8A', 'Introduction to Computer Science: Java', 'Spring', '2021', '2', 'Spring,2022'),
('CSE105-sp21', 'CSE105', 'Intro to Theory', 'Spring', '2021', '2', 'Fall,2021'),
('CSE221-sp21', 'CSE221', 'Operating Systems', 'Spring', '2021', '2', 'Fall,2021'),
('PHIL12-sp21', 'PHIL12', 'Scientific Reasoning', 'Spring', '2021', '2', 'Spring,2022'),
('PHIL165-sp21', 'PHIL165', 'Freedom, Equality, and the Law', 'Spring', '2021', '2', 'Spring,2022'),
('PHIL165-wi18', 'PHIL165', 'Freedom, Equality, and the Law', 'Winter', '2018', '2', 'Spring,2022');

// section
insert into section values ('CSE8A', 'CSE8A-wi17', 'CSE8A-wi17-1', 'Justin Bieber', '30', '5'),
('PHIL165', 'PHIL165-fa17', 'PHIL165-fa17-1', 'Flo Rida', '30', '5'),
('CSE8A', 'CSE8A-fa17', 'CSE8A-fa17-1', 'Selena Gomez', '30', '5'),
('MAE108', 'MAE108-sp21', 'MAE108-sp21-1', 'Adele', '30', '5'),
('CSE105', 'CSE105-sp17', 'CSE105-sp17-1', 'Taylor Swift', '30', '5'),
('CSE8A', 'CSE8A-wi18', 'CSE8A-wi18-1', 'Kelly Clarkson', '30', '5'),
('CSE250A', 'CSE250A-wi17', 'CSE250A-wi17-1', 'Bjork', '30', '5'),
('PHIL10', 'PHIL10-wi18', 'PHIL10-wi18-1', 'Bjork', '30', '5'),
('CSE250B', 'CSE250B-sp17', 'CSE250B-sp17-1', 'Justin Bieber', '30', '5'),
('CSE255', 'CSE255-sp21', 'CSE255-sp21-1', 'Flo Rida', '30', '5'),
('MAE108', 'MAE108-sp21', 'MAE108-sp21-2', 'Selena Gomez', '30', '5'),
('CSE8A', 'CSE8A-sp21', 'CSE8A-sp21-1', 'Adele', '30', '5'),
('CSE105', 'CSE105-sp21', 'CSE105-sp21-1', 'Taylor Swift', '30', '5'),
('CSE232A', 'CSE232A-wi18', 'CSE232A-wi18-1', 'Kelly Clarkson', '30', '5'),
('PHIL165', 'PHIL165-wi18', 'PHIL165-wi18-1', 'Adam Levine', '30', '5'),
('MAE107', 'MAE107-fa17', 'MAE107-fa17-1', 'Bjork', '30', '5'),
('CSE221', 'CSE221-sp21', 'CSE221-sp21-1', 'Justin Bieber', '30', '5'),
('MAE108', 'MAE108-wi17', 'MAE108-wi17-1', 'Selena Gomez', '30', '5'),
('PHIL12', 'PHIL12-sp21', 'PHIL12-sp21-1', 'Adam Levine', '30', '5'),
('CSE250A', 'CSE250A-wi18', 'CSE250A-wi18-1', 'Bjork', '30', '5'),
('PHIL165', 'PHIL165-sp21', 'PHIL165-sp21-1', 'Adam Levine', '30', '5'),
('CSE221', 'CSE221-sp21', 'CSE221-sp21-2', 'Kelly Clarkson', '30', '5'),
('CSE221', 'CSE221-sp21', 'CSE221-sp21-3', 'Kelly Clarkson', '30', '5'),
('CSE255', 'CSE255-wi18', 'CSE255-wi18-1', 'Justin Bieber', '30', '5'),
('CSE221', 'CSE221-fa17', 'CSE221-fa17-1', 'Justin Bieber', '30', '5'),
('MAE108', 'MAE108-sp17', 'MAE108-sp17-1', 'Selena Gomez', '30', '5');


// enrollment
insert into enrollment values ('A1016', 'CSE221', 'CSE221-sp21-2', '4', 'Letter Grade'),
('A1017', 'CSE221', 'CSE221-sp21-1', '4', 'S/U'),
('A1018', 'CSE221', 'CSE221-sp21-3', '4', 'Letter Grade'),
('A1019', 'CSE221', 'CSE221-sp21-2', '4', 'Letter Grade'),
('A1020', 'CSE221', 'CSE221-sp21-1', '4', 'Letter Grade'),
('A1021', 'CSE221', 'CSE221-sp21-3', '4', 'S/U'),
('A1022', 'CSE255', 'CSE255-sp21-1', '4', 'Letter Grade'),
('A1016', 'CSE255', 'CSE255-sp21-1', '4', 'Letter Grade'),
('A1017', 'CSE255', 'CSE255-sp21-1', '4', 'Letter Grade'),
('A1001', 'CSE8A', 'CSE8A-sp21-1', '4', 'S/U'),
('A1005', 'CSE8A', 'CSE8A-sp21-1', '4', 'Letter Grade'),
('A1003', 'CSE8A', 'CSE8A-sp21-1', '4', 'Letter Grade'),
('A1007', 'MAE108', 'MAE108-sp21-1', '4', 'Letter Grade'),
('A1008', 'MAE108', 'MAE108-sp21-1', '4', 'Letter Grade'),
('A1009', 'MAE108', 'MAE108-sp21-2', '4', 'Letter Grade'),
('A1004', 'CSE105', 'CSE105-sp21-1', '4', 'Letter Grade'),
('A1012', 'PHIL12', 'PHIL12-sp21-1', '4', 'Letter Grade'),
('A1013', 'PHIL165', 'PHIL165-sp21-1', '4', 'S/U'),
('A1014', 'PHIL12', 'PHIL12-sp21-1', '4', 'Letter Grade'),
('A1015', 'PHIL165', 'PHIL165-sp21-1', '4', 'Letter Grade');

// meeting
insert into meeting values ('MAE108', 'MAE108-sp21-1', 'MAE108-sp21-1-le', 'Yes', 'LE', 'Monday,Wednesday,Friday', '10:00', '11:00', 'R203'),
('MAE108', 'MAE108-sp21-1', 'MAE108-sp21-1-di', 'Yes', 'DI', 'Tuesday,Thursday', '10:00', '11:00', 'R203'),
('MAE108', 'MAE108-sp21-1', 'MAE108-sp21-1-la', 'Yes', 'LA', 'Friday', '18:00', '19:00', 'R203'),
('CSE221', 'CSE221-sp21-2', 'CSE221-sp21-2-le', 'Yes', 'LE', 'Monday,Wednesday,Friday', '10:00', '11:00', 'R203'),
('CSE221', 'CSE221-sp21-2', 'CSE221-sp21-2-di', 'Yes', 'DI', 'Tuesday,Thursday', '11:00', '12:00', 'R203'),
('CSE255', 'CSE255-sp21-1', 'CSE255-sp21-1-le', 'Yes', 'LE', 'Monday,Wednesday,Friday', '12:00', '13:00', 'R203'),
('PHIL12', 'PHIL12-sp21-1', 'PHIL12-sp21-1-le', 'Yes', 'LE', 'Monday,Wednesday,Friday', '12:00', '13:00', 'R203'),
('PHIL12', 'PHIL12-sp21-1', 'PHIL12-sp21-1-di', 'Yes', 'DI', 'Wednesday,Friday', '13:00', '14:00', 'R203'),
('CSE221', 'CSE221-sp21-3', 'CSE221-sp21-3-le', 'Yes', 'LE', 'Monday,Wednesday,Friday', '12:00', '13:00', 'R203'),
('CSE221', 'CSE221-sp21-3', 'CSE221-sp21-3-di', 'Yes', 'DI', 'Tuesday,Thursday', '12:00', '13:00', 'R203'),
('CSE105', 'CSE105-sp21-1', 'CSE105-sp21-1-le', 'Yes', 'LE', 'Tuesday,Thursday', '14:00', '15:00', 'R203'),
('CSE105', 'CSE105-sp21-1', 'CSE105-sp21-1-di', 'Yes', 'DI', 'Friday', '18:00', '19:00', 'R203'),
('PHIL165', 'PHIL165-sp21-1', 'PHIL165-sp21-1-le', 'Yes', 'LE', 'Tuesday,Thursday', '15:00', '16:00', 'R203'),
('PHIL165', 'PHIL165-sp21-1', 'PHIL165-sp21-1-di', 'Yes', 'DI', 'Tuesday', '13:00', '14:00', 'R203'),
('MAE108', 'MAE108-sp21-2', 'MAE108-sp21-2-le', 'Yes', 'LE', 'Tuesday,Thursday', '15:00', '16:00', 'R203'),
('MAE108', 'MAE108-sp21-2', 'MAE108-sp21-2-di', 'Yes', 'DI', 'Monday', '15:00', '16:00', 'R203'),
('MAE108', 'MAE108-sp21-2', 'MAE108-sp21-2-la', 'Yes', 'LA', 'Friday', '17:00', '18:00', 'R203'),
('CSE221', 'CSE221-sp21-1', 'CSE221-sp21-1-le', 'Yes', 'LE', 'Tuesday,Thursday', '17:00', '18:00', 'R203'),
('CSE221', 'CSE221-sp21-1', 'CSE221-sp21-1-di', 'Yes', 'DI', 'Monday,Friday', '09:00', '10:00', 'R203'),
('CSE8A', 'CSE8A-sp21-1', 'CSE8A-sp21-1-le', 'Yes', 'LE', 'Tuesday,Thursday', '17:00', '18:00', 'R203'),
('CSE8A', 'CSE8A-sp21-1', 'CSE8A-sp21-1-di', 'Yes', 'DI', 'Wednesday', '19:00', '20:00', 'R203'),
('CSE8A', 'CSE8A-sp21-1', 'CSE8A-sp21-1-la', 'Yes', 'LA', 'Tuesday,Thursday', '15:00', '16:00', 'R203');

```
```sql
create Table Degree(
 	Degree_Name Text not null,
	Degree_Type text not null,
	Department text not null,
	Total_unit int default 0,
	lowerDivisionUnit int default 0,
	UpperDivisionUnit int default 0,
	ElectiveUnit int default 0,
	primary key(Degree_Name,Degree_Type)
);
create table concentration (
	concen_Name text not null,
	Degree_Name Text not null,
	Degree_Type text not null,
	courses text not null,
	elective text not null,
	minGPA DECIMAL default 2.0,
	minUnit int default 0,
	primary key(concen_Name,degree_name,degree_type),
	Foreign Key (degree_name,degree_type) references degree(degree_name,degree_type) on Delete CASCADE on update CASCADE
)
Create Table past_course (
	Student_ID TEXT not NUll,
	Course_ID TEXT not null,
	Units int default 2,
	Grade TEXT not null,
	Quarter text not null,
	year text not null,
	SectionId text not null,
	grade_opt text not null,
	primary key(Student_ID,Course_ID),
	Foreign Key (Course_ID,SectionId) references Section on Delete CASCADE on update CASCADE,
	Foreign Key (Student_ID) references student(student_id) on Delete CASCADE on update CASCADE,
	Foreign Key (Course_ID) references course(courseid) on Delete CASCADE on update CASCADE
);
create table GRADE_CONVERSION
( LETTER_GRADE CHAR(2) NOT NULL,
NUMBER_GRADE DECIMAL(2,1)
);
insert into grade_conversion values('A+', 4.0);
insert into grade_conversion values('A', 4.0);
insert into grade_conversion values('A-', 3.7);
insert into grade_conversion values('B+', 3.3);
insert into grade_conversion values('B', 3.0);
insert into grade_conversion values('B-', 2.7);
insert into grade_conversion values('C+', 2.3);
insert into grade_conversion values('C', 2.0);
insert into grade_conversion values('C-', 1.7);
insert into grade_conversion values('D', 1.0);
insert into grade_conversion values('F', 0.0);
```
```MD
- General
1. attributes(ex. year, units, enrollmentlimit,
waitlist): should check if numeric (but not yet)
2. list some required formats on corresponding pages
3. Each button check duplicate

- Course
1. table should check minunits <= maxunits, 
but I didn't catch error, so insert invalid values
might mess up
2. should check if minunits & maxunits are numeric

- Class
1. current year should only be 2018?
2. attribute (nextOffer) should be if it is a duplicate (quarter,year)
with the same course id

- Meeting
1. time format (hh:mm) check for hh and mm

- Section
1. should check if enrollmentlimit and waitlist are numeric

- updated table creation code
1. Since I modified enrollment & meeting table, there might be errors
while testing the corresponding parts.
```

```sql

CREATE TABLE Student(
    Student_ID TEXT,
    SSN TEXT NOT NULL UNIQUE,
    FirstName TEXT NOT NULL,
    MiddleName TEXT,
    LastName TEXT NOT NULL,
    Residency TEXT NOT NULL,
    Enrollment TEXT NOT NULL,
		stu_type text not null,
    PRIMARY KEY (Student_ID)
);

CREATE TABLE Undergraduate (
  student_id TEXT,
  college TEXT NOT NULL,
  major TEXT NOT NULL,
	monir TEXT,
	Primary Key (student_id),
	Foreign Key (student_id) references student(student_id) on Delete CASCADE on update CASCADE
);

Create table Master(
	student_id TEXT,
  	Department TEXT NOT NULL,
  	Stu_type TEXT not null,
	Thesis_Committee int DEFAULT 0,
	Primary Key (student_id),
	Foreign Key (student_id) references student(student_id) on Delete CASCADE on update CASCADE
);

Create table phd(
	student_id TEXT,
  	Department TEXT NOT NULL,
  	Stu_type TEXT not null,
	advisor Text not null,
	Thesis_Committee int DEFAULT 0,
	diff_depart_thesis int DEFAULT 0,
	Primary Key (student_id),
	Foreign Key (student_id) references student(student_id) on Delete CASCADE on update CASCADE
);

CREATE TABLE Probation (
    student_id TEXT,
    start_date TEXT not null,
	end_date TEXT not null,
	Reason TEXT not null,
	Primary Key (start_date,end_date),
	Foreign Key (student_id) references student(student_id) on Delete CASCADE on update CASCADE
);

create table Faculty(
	faculty_name TEXT not NULL,
	Title TEXT not null,
	Department TEXT not null,
	primary key(faculty_name)
);

create table Thesis_committee (
	Student_id Text not null,
	Stu_Program text not null,
	Faculty_name text not null,
	Faculty_Dep text not null,
	Foreign Key (Student_id) references student(student_id) on Delete CASCADE on update CASCADE,
	Foreign Key (Faculty_name) references faculty(faculty_name) on Delete CASCADE on update CASCADE
);

Create Table past_course (
	Student_ID TEXT not NUll,
	Course_ID TEXT not null,
	Units int default 2,
	Grade TEXT not null,
	Quarter text not null,
	year text not null,
	SectionId text not null,
	grade_opt text not null,
	primary key(Student_ID,Course_ID),
	Foreign Key (Course_ID,SectionId) references Section on Delete CASCADE on update CASCADE,
	Foreign Key (Student_ID) references student(student_id) on Delete CASCADE on update CASCADE,
	Foreign Key (Course_ID) references course(courseid) on Delete CASCADE on update CASCADE
);

create table concentration (
	concen_Name text not null,
	Degree_Name Text not null,
	Degree_Type text not null,
	courses text not null,
	elective text not null,
	minGPA DECIMAL default 2.0,
	minUnit int default 0,
	primary key(concen_Name,degree_name,degree_type),
	Foreign Key (degree_name,degree_type) references degree(degree_name,degree_type) on Delete CASCADE on update CASCADE
)
create Table Degree(
 	Degree_Type Text not null,
	Degree_Name text not null,
	Department text not null,
	Total_unit int default 0,
	lowerDivisionUnit int default 0,
	UpperDivisionUnit int default 0,
	ElectiveUnit int default 0,
	primary key(Degree_Name,Degree_Type)
);

create table GRADE_CONVERSION
( LETTER_GRADE CHAR(2) NOT NULL,
NUMBER_GRADE DECIMAL(2,1)
);
insert into grade_conversion values('A+', 4.0);
insert into grade_conversion values('A', 4.0);
insert into grade_conversion values('A-', 3.7);
insert into grade_conversion values('B+', 3.3);
insert into grade_conversion values('B', 3.0);
insert into grade_conversion values('B-', 2.7);
insert into grade_conversion values('C+', 2.3);
insert into grade_conversion values('C', 2.0);
insert into grade_conversion values('C-', 1.7);
insert into grade_conversion values('D', 1.0);
insert into grade_conversion values('F', 0.0);

create table Course(
	CourseId          Text Not Null,
	Course_name       Text Not Null,
	Department        Text Not Null,
	Prerequisites     Text,
	// Units             Int
	GradeOption       Text Not Null,
	Lab               Text Not Null, // not sure
	MinUnits          Int Not Null,
	MaxUnits          Int Not Null,
	Primary key       (CourseId),
	Check (MinUnits <= MaxUnits)
);

create table Class(
	ClassId           Text Not Null,  
	CourseId          Text Not Null,
	Title             Text Not Null,
	Quarter           Text Not Null,
	Year              Text Not Null,
	NumberSec         Text Not Null,
	NextOffer         Text Not Null,
	Primary key       (ClassId),
	Foreign key       (CourseId) references Course on Delete CASCADE on update CASCADE,
	Check (Quarter In ('Fall', 'Winter', 'Spring', 'Summer'))
);


create table Section(
	CourseId          Text Not Null,
	ClassId           Text Not Null,	
	SectionId         Text Not Null,
	Faculty_name      TEXT not NULL,
	EnrollmentLimit   Text Not Null,
	WaitList          Text Not Null,
	Primary key       (CourseId, SectionId),
	Foreign key       (Faculty_name) references Faculty on Delete CASCADE on update CASCADE,
	Foreign key       (ClassId) references class on Delete CASCADE on update CASCADE,
	Foreign key       (CourseId) references Course on Delete CASCADE on update CASCADE
);

create table Enrollment(
	StudentId         Text Not Null,
	CourseId          Text Not Null,
	SectionId         Text Not Null,
	Units             Text Not Null,
    GradeOption       Text Not Null,
	Primary key       (StudentId, CourseId),
    Foreign key       (StudentId) references Student on Delete CASCADE on update CASCADE,
	Foreign key       (CourseId) references Course on Delete CASCADE on update CASCADE,
	Foreign key       (CourseId, SectionId) references Section on Delete CASCADE on update CASCADE
);

create table Meeting(
	CourseId          Text Not Null,
	SectionId         Text Not Null,	
	MeetingId         Text Not Null UNIQUE,
	Meet_required     Text Not Null,
	Meet_type	      Text Not Null,
	Meet_day          Text Not Null,
	Start_time        Text Not Null,
	End_time          Text Not Null,
	Meet_room         Text Not Null,
	Primary key       (MeetingId),
	Foreign key       (CourseId, SectionId) references Section on Delete CASCADE on update CASCADE,
	Check (Meet_type IN ('LE', 'DI', 'LA'))
);

create table ReviewSession(
	CourseId          Text Not Null,
    SectionId         Text Not Null,
    ReviewId          Text Not Null UNIQUE,
	Review_date       Text Not Null,
	Start_time        Text Not Null,
	End_time          Text Not Null,
	Review_room       Text Not Null,
	Primary key       (ReviewId),
	Foreign key       (CourseId) references Course on Delete CASCADE on update CASCADE,
	Foreign key       (CourseId, SectionId) references Section on Delete CASCADE on update CASCADE
);


