<%@ page contentType="text/html; charset=utf-8" %><%@ include file="init.jsp" %><%

OrderDao order = new OrderDao();
OrderItemDao orderItem = new OrderItemDao();
ProductDao product = new ProductDao();

ListManager lm = new ListManager();
lm.setRequest(request);

lm.setListNum(9999);
// lm.setDebug(out);
lm.setTable(order.table + " a JOIN " + orderItem.table + " b ON a.id = b.order_id JOIN " + product.table + " p ON b.product_id = p.id");
lm.setFields("a.id order_id, a.status, b.*, p.name product_name, a.progress, a.total");
lm.addWhere("a.status = 1");
DataSet myPage = lm.getDataSet();

while(myPage.next()){
    myPage.put("total_conv", m.nf(myPage.i("total"))+"원");
}

p.setLayout("main");
p.setBody("main.mypage_shoping_list");
p.setLoop("myPage", myPage);
p.display();

%>