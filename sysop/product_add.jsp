<%@ page contentType="text/html; charset=utf-8" %><%@ include file="init.jsp" %><%

CategoryDao categoryDao = new CategoryDao();
ProductDao product = new ProductDao();
// product.setDebug(out);

int id = m.ri("id");

f.addElement("cid", null, "required:'Y'");
f.addElement("name", null, "required:'Y'");
f.addElement("series", null, "required:'Y'");
f.addElement("img", null, "required:'Y'");
f.addElement("content", null, "");
f.addElement("retail_price", null, "required:'Y'");
f.addElement("price", null, "required:'Y'");
f.addElement("sale", null, "required:'Y'");
f.addElement("sort", null, "");
f.addElement("best", null, "");

if(m.isPost() && f.validate()){
    
    product.item("cid", f.get("cid"));
    product.item("series", f.get("series"));
    product.item("name", f.get("name"));
    product.item("img", m.getWebUrl() + "/html/image/product/" + f.get("img"));
    product.item("content", f.get("content"));
    // product.item("content_file", f.get("content_file"));
    product.item("retail_price", f.get("retail_price"));
    product.item("price", f.get("price"));
    product.item("sale", f.get("sale"));
    product.item("sort", f.get("sort"));
    product.item("best", f.get("best"));
    product.item("status", 1);
    product.item("reg_date", m.time("yyyyMMddHHmmss"));
    
    if(!product.insert()){
        m.jsError("error");
        return;
    }
    m.redirect("/sysop/product_list.jsp?cid=1&pid=0");
    return;
}

DataSet category_list = categoryDao.find("depth = 2 AND status = 1");

p.setLayout("sysop");
p.setBody("sysop.product_add");
p.setLoop("category_list", category_list);
p.setVar("form_script", f.getScript());
p.display();
%>