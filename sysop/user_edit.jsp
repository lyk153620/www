<%@ page contentType="text/html; charset=utf-8" %><%@ include file="init.jsp" %><%

UserDao userDao = new UserDao();
int id = m.ri("id");

DataSet info = userDao.find("id = " + id);

f.addElement("type", null, "");
f.addElement("name", null, "required:'Y'");
f.addElement("uid", null, "required:'Y'");
f.addElement("upw", null, "");
f.addElement("gender", null, "");
f.addElement("birthday", null, "");
f.addElement("phone", null, "");
f.addElement("mobile_carrier", null, "");
f.addElement("email", null, "");
f.addElement("usage_status", null, "");

if(m.isPost() && f.validate()) {
    
    userDao.item("type", f.get("type"));
    userDao.item("name", f.get("name"));
    userDao.item("uid", f.get("uid"));
    userDao.item("upw", f.get("upw"));
    userDao.item("gender", f.get("gender"));
    userDao.item("birthday", f.get("birthday"));
    userDao.item("phone", f.get("phone"));
    userDao.item("mobile_carrier", f.get("mobile_carrier"));
    userDao.item("email", f.get("email"));
    userDao.item("usage_status", f.get("usage_status"));
    userDao.item("status", 1);
    userDao.item("reg_date", m.time("yyyyMMddHHmmss"));

    if (!userDao.update("id = " + id)){
        m.jsError("error");
        return;
    }
    m.redirect("/sysop/user_list.jsp");
    return;
}

p.setLayout("sysop");
p.setBody("sysop.user_edit");
p.setVar("form_script", f.getScript());
p.setVar("info", info);
p.display();
%>