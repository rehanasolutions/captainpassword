import 'package:captainpassword/levendr/enums/column_data_type.dart';

class ColumnInfo {
  String name;
  ColumnDataType datatype;
  bool isRequired;
  bool isUnique;
  bool isForeignKey;
  String foreignSchema;
  String foreignTable;
  String foreignName;

  ColumnInfo(
      {this.name,
      this.datatype,
      this.isRequired,
      this.isUnique,
      this.isForeignKey,
      this.foreignSchema,
      this.foreignTable,
      this.foreignName});

  ColumnInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    datatype = json['datatype'];
    isRequired = json['isRequired'];
    isUnique = json['isUnique'];
    isForeignKey = json['isForeignKey'];
    foreignSchema = json['foreignSchema'];
    foreignTable = json['foreignTable'];
    foreignName = json['foreignName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['datatype'] = this.datatype.index;
    data['isRequired'] = this.isRequired;
    data['isUnique'] = this.isUnique;
    data['isForeignKey'] = this.isForeignKey;
    data['foreignSchema'] = this.foreignSchema;
    data['foreignTable'] = this.foreignTable;
    data['foreignName'] = this.foreignName;
    return data;
  }
}
