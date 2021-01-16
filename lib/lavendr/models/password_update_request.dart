import 'package:captainpassword/lavendr/models/password.dart';
import 'package:captainpassword/lavendr/models/query_search_item.dart';

class PasswordUpdateRequest {
  Password data;
  List<QuerySearchItem> parameters;

  PasswordUpdateRequest({this.data, this.parameters});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data.toJson();

    List parameters = [];
    this.parameters.forEach((element) {
      parameters.add(element.toJson());
    });
    data['parameters'] = parameters;

    return data;
  }
}
