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

