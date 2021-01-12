class Qrcode {
  List<Qrs> qrs;

  Qrcode({this.qrs});

  Qrcode.fromJson(Map<String, dynamic> json) {
    if (json['qrs'] != null) {
      qrs = new List<Qrs>();
      json['qrs'].forEach((v) {
        qrs.add(new Qrs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.qrs != null) {
      data['qrs'] = this.qrs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Qrs {
  String sId;
  String qrCode;
  int balance;
  String user;
  String dateCreate;
  int iV;

  Qrs(
      {this.sId,
      this.qrCode,
      this.balance,
      this.user,
      this.dateCreate,
      this.iV});

  Qrs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    qrCode = json['qr_code'];
    balance = json['balance'];
    user = json['user'];
    dateCreate = json['date_create'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['qr_code'] = this.qrCode;
    data['balance'] = this.balance;
    data['user'] = this.user;
    data['date_create'] = this.dateCreate;
    data['__v'] = this.iV;
    return data;
  }
}