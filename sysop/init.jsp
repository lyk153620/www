<%@ include file="../init.jsp" %><%

UserDao userDao = new UserDao();
auth.loginURL = "/sysop/login/login.jsp";

DataSet user = userDao.find("id = " + userId + " AND type = 2");

if(!user.next()) { 
    m.jsError("해당 정보가 없습니다."); 
    return;
}

%>