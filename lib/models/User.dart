class User {
  String id;
  String name;
  String numbercard;
  String type;
  int balance;

  User({this.id, this.name, this.numbercard, this.type, this.balance});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    numbercard = json['number_card'];
    type = json['type'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['number_card'] = this.numbercard;
    data['type'] = this.type;
    data['balance'] = this.balance;
    return data;
  }
}