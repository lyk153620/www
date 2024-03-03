<%@ page contentType="text/html; charset=utf-8" %><%@ include file="init.jsp" %><%

OrderDao orderDao = new OrderDao();
// orderDao.setDebug(out);
CartDao cartDao = new CartDao();
OrderItemDao orderItemDao = new OrderItemDao();
ProductDao productDao = new ProductDao();
AddressDao address = new AddressDao();

String name = userName;

DataSet order = orderDao.query("SELECT a.*, c.order_id, c.product_id, c.product_price, c.count, b.id, b.name, b.price FROM tb_order a LEFT JOIN tb_order_item c ON a.id = c.order_id LEFT JOIN tb_product b ON c.product_id = b.id WHERE a.status = 1 AND a.progress = 1 AND a.user_id = 1");

if (!order.next()) {
    m.jsError("해당 주문은 존재하지 않습니다.");
    return;
} else {        
    order.first();
    while (order.next()) {
    order.put("price_conv", m.nf(order.i("price")));
    order.put("product_price_conv", m.nf(order.i("product_price")));
    }
}

f.addElement("name", null, "required:'Y'");
f.addElement("recipient", null, "required:'Y'");
f.addElement("zone_code", null, "required:'Y'");
f.addElement("road_address", null, "required:'Y'");
f.addElement("detail_address", null, "required:'Y'");
f.addElement("phone1", null, "required:'Y', maxbyte:'3'");
f.addElement("phone2", null, "required:'Y', maxbyte:'4'");
f.addElement("phone3", null, "required:'Y', maxbyte:'4'");

if(m.isPost() && f.validate()) {
    
    if(f.getInt("delivery_location") == 1) {
        address.item("name", f.get("name"));
        address.item("user_id", userId);
        address.item("recipient", f.get("recipient"));
        address.item("zone_code", f.get("zone_code"));
        address.item("road_address", f.get("road_address"));
        address.item("detail_address", f.get("detail_address"));
        address.item("phone", f.glue("-","phone1, phone2, phone3"));
        address.item("status", 1);
        address.item("reg_date", m.time("yyyyMMddHHmmss"));
        
        if(!address.insert()){
            m.jsError("error1");
            return;
        }
    } else {

    }

    orderDao.item("address_name", f.get("name"));
    orderDao.item("recipient", f.get("recipient"));
    orderDao.item("zone_code", f.get("zone_code"));
    orderDao.item("road_address", f.get("road_address"));
    orderDao.item("detail_address", f.get("detail_address"));
    orderDao.item("phone", f.glue("-","phone1, phone2, phone3"));
    orderDao.item("progress", 2);
    
    if(!orderDao.update("status = 1 AND user_id = " + userId)){
        m.jsError("error2");
        return;
    }
    m.redirect("/main/pay.jsp");
    return;
}
p.setLayout("main");
p.setBody("main.order");
p.setLoop("order", order);
p.setVar("userName", name);
p.setVar("form_script", f.getScript());
p.display();

%>