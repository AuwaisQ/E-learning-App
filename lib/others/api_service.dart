
import 'dart:convert';

class ApiService{

  Future getOrderListData() async {
    var convertDataToJson = '{"status":true,"orderList":[{"id":1024,"date":"12/12/2020","total_amount":720,"status":1,"itemList":[{"id":1,"productName":"Scesior ","quantity":2,"amount":170},{"id":1,"productName":"Frame","quantity":2,"amount":35}]},{"id":1024,"date":"12/12/2020","total_amount":1250,"status":1,"itemList":[{"id":1,"productName":"Glue Gun","quantity":3,"amount":957}]},{"id":1024,"date":"12/12/2020","total_amount":1920,"status":2,"itemList":[{"id":1,"productName":"Glue Gun","quantity":1,"amount":379}]}]}';//response.body;
    var status = json.decode(convertDataToJson)['status'];
    if (status) {
      var tag = json.decode(convertDataToJson); //['data'];
      print(tag);
      return tag;
    }
  }
}