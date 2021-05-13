公用的url
<p style="color:red" >ReadMe</p>
localHost: 5432 <br/>
dataBase: postgres<br/>
user: postgres<br/>
password: 4645<br/>

```Java
String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
```
```MD
## 我update Degree, concenration, past_course, Grade_conversion -- checkout 
下面是我修改过的Sql,我也update到总的sql 文档哪里儿！
删掉了旧的degree 我重新按照database写了一个  外加 concentration，GRADE_CONVERSION 这两个table
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
	Taken_Quarter TEXT not null,
	primary key(Student_ID,Course_ID),
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
	Taken_Quarter TEXT not null,
	primary key(Student_ID,Course_ID),
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


create table ReviewSession(
	CourseId          Text Not Null,
    SectionId         Text Not Null,
    ReviewId          Text Not Null,
	Review_date       Text Not Null,
	Start_time        Text Not Null,
	End_time          Text Not Null,
	Review_room       Text Not Null,
	Primary key       (ReviewId),
	Foreign key       (CourseId) references Course on Delete CASCADE on update CASCADE,
	Foreign key       (CourseId, SectionId) references Section on Delete CASCADE on update CASCADE
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
	Primary key       (StudentId, CourseId),
    Foreign key       (StudentId) references Student on Delete CASCADE on update CASCADE,
	Foreign key       (CourseId) references Course on Delete CASCADE on update CASCADE,
	Foreign key       (CourseId, SectionId) references Section on Delete CASCADE on update CASCADE
);

create table Meeting(
	CourseId          Text Not Null,
	SectionId         Text Not Null,	
	MeetingId         Text Not Null,
	Meet_required     Text Not Null,
	Meet_type	      Text Not Null,
	Meet_day          Text Not Null,
	Start_time        Text Not Null,
	End_time          Text Not Null,
	Meet_room         Text Not Null,
	Primary key       (CourseId, MeetingId),
	Foreign key       (CourseId, SectionId) references Section on Delete CASCADE on update CASCADE,
	Check (Meet_type IN ('LE', 'DI', 'LA'))
);

create table ReviewSession(
	CourseId          Text Not Null,
    SectionId         Text Not Null,
    ReviewId          Text Not Null,
	Review_date       Text Not Null,
	Start_time        Text Not Null,
	End_time          Text Not Null,
	Review_room       Text Not Null,
	Primary key       (CourseId, ReviewId),
	Foreign key       (CourseId) references Course on Delete CASCADE on update CASCADE,
	Foreign key       (CourseId, SectionId) references Section on Delete CASCADE on update CASCADE
);


