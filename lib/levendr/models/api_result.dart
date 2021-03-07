class APIResult {
  bool success;
  String message;
  dynamic data;

  APIResult({this.success, this.message, this.data});

  APIResult.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    message = json['Message'];
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Message'] = this.message;
    data['Data'] = this.data;
    return data;
  }
}
