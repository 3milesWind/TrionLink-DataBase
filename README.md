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

insert into student values('A1005','5','Kevin','','L','California resident','Current enrolled','Undergraduate');
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
	primary key(Student_ID,Course_ID),
	Foreign Key (Course_ID,SectionId) references Section on Delete CASCADE on update CASCADE,
	Foreign Key (Student_ID) references student(student_id) on Delete CASCADE on update CASCADE,
	Foreign Key (Course_ID) references course(courseid) on Delete CASCADE on update CASCADE
);
create table GRADE_CONVERSION(
      LETTER_GRADE CHAR(2) NOT NULL,
      NUMBER_GRADE DECIMAL(2,1)
 );
 insert into grade_conversion values('A+', 4.3);
 insert into grade_conversion values('A', 4);
 insert into grade_conversion values('A-', 3.7);
 insert into grade_conversion values('B+', 3.4);
 insert into grade_conversion values('B', 3.1);
 insert into grade_conversion values('B-', 2.8);
 insert into grade_conversion values('C+', 2.5);
 insert into grade_conversion values('C', 2.2);
 insert into grade_conversion values('C-', 1.9);
 insert into grade_conversion values('D', 1.6)
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
 	Degree_Name Text not null,
	Degree_Type text not null,
	Department text not null,
	Total_unit int default 0,
	lowerDivisionUnit int default 0,
	UpperDivisionUnit int default 0,
	ElectiveUnit int default 0,
	primary key(Degree_Name,Degree_Type)
);

create table GRADE_CONVERSION(
      LETTER_GRADE CHAR(2) NOT NULL,
      NUMBER_GRADE DECIMAL(2,1)
 );
 insert into grade_conversion values('A+', 4.3);
 insert into grade_conversion values('A', 4);
 insert into grade_conversion values('A-', 3.7);
 insert into grade_conversion values('B+', 3.4);
 insert into grade_conversion values('B', 3.1);
 insert into grade_conversion values('B-', 2.8);
 insert into grade_conversion values('C+', 2.5);
 insert into grade_conversion values('C', 2.2);
 insert into grade_conversion values('C-', 1.9);
 insert into grade_conversion values('D', 1.6)

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


