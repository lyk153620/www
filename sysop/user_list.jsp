<%@ page contentType="text/html; charset=utf-8" %><%@ include file="/init.jsp" %><%

UserDao userDao = new UserDao();

ListManager lm = new ListManager();
lm.setRequest(request);
// lm.setDebug(out);

lm.setTable(userDao.table);
lm.setListNum(10);
lm.setFields("id, uid, name, reg_date, usage_status, birthday, gender, email, phone");
lm.setOrderBy("id desc");
lm.addWhere("status = 1");

DataSet users = lm.getDataSet();
if (!users.next()){
    m.jsError("error");
    return;
} else {
    users.first();
    while (users.next()){
        users.put("reg_date_conv", m.time("yyyy" + "/" + "MM" + "/" + "dd " + "HH" + ":" + "mm", users.getString("reg_date")));
    }
}

p.setLayout("sysop");
p.setBody("sysop.user_list");
p.setLoop("users", users);
p.setVar("pagebar", lm.getPaging());
p.display();
%>