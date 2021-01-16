import 'package:captainpassword/lavendr/enums/column_condition.dart';

class QuerySearchItem {
  String name;
  dynamic value;
  ColumnCondition condition;
  bool caseSensitive;

  QuerySearchItem({this.name, this.value, this.condition, this.caseSensitive});

  QuerySearchItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    condition = json['condition'];
    caseSensitive = json['caseSensitive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    data['condition'] = this.condition.index;
    data['caseSensitive'] = this.caseSensitive;
    return data;
  }
}
