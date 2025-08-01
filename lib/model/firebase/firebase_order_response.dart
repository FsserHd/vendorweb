
class FirebaseOrderResponse {
  String? message;
  String? orderid;
  String? type;

  FirebaseOrderResponse({this.message, this.orderid});

  FirebaseOrderResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    orderid = json['orderid'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['orderid'] = this.orderid;
    data['type'] = this.type;
    return data;
  }
}
