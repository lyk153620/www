<%@ page contentType="text/html; charset=utf-8" %><%@ include file="init.jsp" %><%

ProductDao productDao = new ProductDao();
BoardDao boardDao = new BoardDao();
PostDao postDao = new PostDao();
CartDao cart = new CartDao();
// cart.setDebug(out);

int id = m.ri("id");
int purpose = m.ri("purpose");

DataSet products = productDao.find("id = "+ id);
if (!products.next()) {
    m.jsError("해당 품목은 존재하지 않습니다.");
    return;
} else {
    products.put("price_conv", m.nf(products.i("price")));
    products.put("retail_price_conv", m.nf(products.i("retail_price")));
}

DataSet info = boardDao.find("id = " + purpose);

DataSet productCount1 = productDao.query("SELECT product_id 'name', COUNT(product_id) 'count' FROM tb_post WHERE purpose = 4 AND product_id = " + id + " AND status = 1");
DataSet productCount2 = productDao.query("SELECT product_id 'name', COUNT(product_id) 'count' FROM tb_post WHERE purpose = 5 AND product_id = " + id + " AND status = 1");

ListManager lm = new ListManager();
lm.setRequest(request);

    p.setVar("info", info);
    lm.setListNum(info.i("list_num"));

lm.setTable(postDao.table); 
lm.setOrderBy("id DESC");
lm.addWhere("purpose = " + purpose + " AND product_id = " + id + " AND status = 1");

DataSet productReview = lm.getDataSet();
while (productReview.next()) {
    productReview.put("reg_date_conv", m.time("yyyy" + "-" + "MM" + "-" + "dd " + "hh" 
    + ":" +"mm" + ":" + "ss", productReview.getString("reg_date")));
}

p.setLayout("main");
p.setBody("main.product");
p.setLoop("productReview", productReview);
p.setVar("products", products);
p.setVar("productCount1", productCount1);
p.setVar("productCount2", productCount2);
p.setVar("form_script", f.getScript());
p.display();
%>