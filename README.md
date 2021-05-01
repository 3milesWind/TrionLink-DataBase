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
CREATE TABLE Student(
    Student_ID TEXT,
    SSN TEXT NOT NULL UNIQUE,
    FirstName TEXT NOT NULL,
    MiddleName TEXT,
    LastName TEXT NOT NULL,
    Residency TEXT NOT NULL,
    Enrollment TEXT NOT NULL,
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
)

create table Thesis_committee (
	Student_id Text not null,
	Stu_Program text not null,
	Faculty_name text not null,
	Faculty_Dep text not null,
	Foreign Key (Student_id) references student(student_id) on Delete CASCADE on update CASCADE,
	Foreign Key (Faculty_name) references faculty(faculty_name) on Delete CASCADE on update CASCADE
)
```