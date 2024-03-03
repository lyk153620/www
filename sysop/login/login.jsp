<%@ page contentType="text/html; charset=utf-8" %><%@ include file="init.jsp" %><%

//로그인 여부
if(userId != 0) {
	m.redirect("/sysop/index.jsp"); 
	return;
}

//객체
UserDao user = new UserDao();
// user.setDebug(out);

String returl = m.rs("returl", "/sysop/index.jsp");

//로그인 
String uid = m.rs("uid");
String upw = m.rs("upw");

f.addElement("uid", null, "required: true");
f.addElement("upw", null, "required: true");


//폼입력
if(m.isPost() && f.validate()){

	upw = m.sha256(upw);
	DataSet info = user.find("uid = '" + uid + "' AND upw = '" + upw + "' AND status = 1 AND type = 2");
	
    if(info.next()) {
		auth.put("id", info.i("id"));
		auth.put("name", info.s("name"));
		auth.put("uid", info.s("uid"));
		auth.put("birthday", info.i("birthday"));
		auth.save();

		out.print("success");
        return;

	}

	out.print("아이디 또는 비밀번호를 확인하세요.");
	return;
}

//출력
p.setLayout(null);
p.setBody("sysop.login");
p.setVar("form_script", f.getScript());
p.display();

%>