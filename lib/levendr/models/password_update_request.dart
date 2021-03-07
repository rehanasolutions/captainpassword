import 'package:captainpassword/levendr/models/password.dart';
import 'package:captainpassword/levendr/models/query_search_item.dart';

class PasswordUpdateRequest {
  Password data;
  List<QuerySearchItem> parameters;

  PasswordUpdateRequest({this.data, this.parameters});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Data'] = this.data.toJson();

    List parameters = [];
    this.parameters.forEach((element) {
      parameters.add(element.toJson());
    });
    data['Parameters'] = parameters;

    return data;
  }
}
