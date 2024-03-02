<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

int id = m.ri("id");

UserDao userDao = new UserDao();
DataSet users = userDao.find("id = " + id);

if(!users.next()){
    m.jsError("해당 정보가 없습니다."); 
    return;
}

userDao.item("status", -1);
userDao.item("edit_date", m.time("yyyyMMddHHmmss"));
if(!userDao.update("id = " + id)) {
    m.jsError("삭제하던 중 오류가 발생했습니다."); 
    return; 
}

m.redirect("/sysop/user_list.jsp");
%>