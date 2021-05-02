<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1 align="center"><%= "CSE132B Demo" %> </h1>
<br/>
Select the Entry you want to Modify
<br/><br/>
Student Entry:
<a href="Student/Insert/Student_Entry.jsp"><button>Insert</button></a>
<a href="Student/Update/FindTheIDInfo.jsp"><button>Update</button></a>
<a href="Student/Delete/DeleteByStudentID.jsp"><button>Delete</button></a>
<a href="Student/Student_DataBase_Info.jsp"><button>Data Entry</button></a>
<br/><br/>
Probation Entry:
<a href="Probation_Info_Submission/Probation_Entry_Submission.jsp"><button>Probation Info Submission</button></a>
<a href="Probation_Info_Submission/Probation_find_ID.jsp"><button>Probation Info Database</button></a>
<br/><br/>
Faculty Entry:
<a href="Faculty/Faculty_insert/Faculty_Insert_Page.jsp"><button>Insert</button></a>
<a href="Faculty/Faculty_Update/Faculty_Update_Page.jsp"><button>Update</button></a>
<a href="Faculty/Faculty_Delete/Faculty_Delete_Page.jsp"><button>Delete</button></a>
<a href="Faculty/Faculty_DataBase.jsp"><button>Data Entry</button></a>
<br/><br/>
Thesis Committee Submission:
<a href="Thesis_Committee/Thesis_Committee_Submission.jsp"><button>Submission</button></a>
<a href="Thesis_Committee/Thesis_Committee_DataBase.jsp"><button>Thesis Committee DataBase</button></a>
<br/><br/>
Past Courses:
<a href="Past_Course/Past_Course_Submission.jsp"><button>Classes taken in the Past</button></a>
<a href="Past_Course/Past_Course_DataBase.jsp"><button>Past Course DataBase</button></a>
<a href="Past_Course/Past_Course_Search_ByID.jsp"><button>Past Course DataBase By ID</button></a>
<br/><br/>
Degree Requirements:
<a href="./Deg_Requirement/DegreePage.jsp"><button>Degree Requirements’ Submission</button></a>
<a href="./Deg_Requirement/DegreeCate.jsp"><button>Degree Categories’ Submission</button></a>
<a href="./Deg_Requirement/DegreeDataBase.jsp"><button>Degree DataBase</button></a>
<br/><br/>
<a href="#"><button>Course Entry Form</button></a>
<br/><br/>
<a href="#"><button>Class Entry Form</button></a>
<br/><br/>
<a href="#"><button>Course Enrollment:</button></a>
<br/><br/>
<a href="#"><button>Review Session Info Submission</button></a>
<br/><br/>

</body>
</html>