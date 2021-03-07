import 'package:captainpassword/levendr/enums/column_condition.dart';

class QuerySearchItem {
  String name;
  dynamic value;
  ColumnCondition condition;
  bool caseSensitive;

  QuerySearchItem({this.name, this.value, this.condition, this.caseSensitive});

  QuerySearchItem.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    value = json['Value'];
    condition = json['Condition'];
    caseSensitive = json['CaseSensitive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Value'] = this.value;
    data['Condition'] = this.condition.index;
    data['CaseSensitive'] = this.caseSensitive;
    return data;
  }
}
