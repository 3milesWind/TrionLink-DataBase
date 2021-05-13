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
1. Past_course 目前只连接了course,section并未链接.
2. Past_course condition check 只对student ID做了
   并未检查courseID的正确和SectionID的正确
3. 完成基本功能Past_course
```
```MD
- General
1. attributes(ex. year, units, enrollmentlimit,
waitlist): should check if numeric (but not yet)

- Course
1. table should check minunits <= maxunits, 
but I didn't catch error, so insert invalid values
might mess up
2. should check if minunits & maxunits are numeric

- Section
1. check if enrollmentlimit and waitlist are numeric

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
	Section_ID TEXT not Null,
	Grade TEXT not null,
	Taken_Quarter TEXT not null,
	Foreign Key (Student_ID) references student(student_id) on Delete CASCADE on update CASCADE,
	Foreign Key (Course_ID) references course(course_id) on Delete CASCADE on update CASCADE

);

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
	Primary key       (MeetingId),
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
	Primary key       (ReviewId),
	Foreign key       (CourseId) references Course on Delete CASCADE on update CASCADE,
	Foreign key       (CourseId, SectionId) references Section on Delete CASCADE on update CASCADE
);

create Table DegreeInfo(
 	Degree_Name Text not null,
	Degree_Type text not null,
	Total_unit int default 120,
	primary key(Degree_Name,Degree_Type)
);

Create table degreeCate (
	degree_name text not null,
	degree_type text not null,
	department text not null,
	minimum_units int default 0,
	average_grade DECIMAL default 3.0,
	concentration text,
	primary key(degree_name,degree_type,department),
	Foreign Key (degree_name,degree_type) references degreeinfo(degree_name,degree_type) on Delete CASCADE on update CASCADE
);


