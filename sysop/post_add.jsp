<%@ page contentType="text/html; charset=utf-8" %><%@ include file="init.jsp" %><%

PostDao post = new PostDao();
ProductDao productDao = new ProductDao();
CategoryDao categoryDao = new CategoryDao();
BoardDao boardDao = new BoardDao();
// post.setDebug(out);

// DataSet post = postDao.query("SELECT DISTINCT a.id post_id, a.purpose, a.title, a.writer, a.usage_status, a.reg_date, b.id board_id, b.name board_name FROM " + postDao.table + " a RIGHT JOIN " + boardDao.table + " b ON a.purpose = b.id");

DataSet board = boardDao.find("status = 1");
DataSet product = productDao.find("status = 1");
DataSet category = categoryDao.find("depth = 2 AND status = 1");

f.addElement("purpose", null, "");
f.addElement("title", null, "");
f.addElement("writer", null, "");
f.addElement("usage_status", null, "");
f.addElement("content", null, "");
f.addElement("pw", null, "");
f.addElement("product_id", null, "");
f.addElement("cid", null, "");

if (m.isPost() && f.validate()){
    
    post.item("uid", userId);
    post.item("purpose", f.get("purpose"));
    post.item("title", f.get("title"));
    post.item("writer", f.get("writer"));
    post.item("pw", f.get("pw"));
    post.item("usage_status", f.get("usage_status"));
    
    if(f.get("cid") != null && !"".equals(f.get("cid"))){
        if(f.get("product_id") != null && !"".equals(f.get("product_id"))){
            post.item("product_id", f.get("product_id"));
        }
            else {
                m.jsError("error");
                return;
            }
    }
    post.item("content", f.get("content"));
    post.item("status", 1);
    post.item("reg_date", m.time("yyyyMMddHHmmss"));

    if(!post.insert()){
        m.jsError("error");
        return;
    }
    m.redirect("/sysop/post_list.jsp");
    return;
}

p.setLayout("sysop");
p.setBody("sysop.post_add");
p.setLoop("board", board);
p.setLoop("product", product);
p.setLoop("category", category);
p.display();
%>