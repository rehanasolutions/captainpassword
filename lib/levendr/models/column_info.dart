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
    name = json['Name'];
    datatype = json['Datatype'];
    isRequired = json['IsRequired'];
    isUnique = json['IsUnique'];
    isForeignKey = json['IsForeignKey'];
    foreignSchema = json['ForeignSchema'];
    foreignTable = json['ForeignTable'];
    foreignName = json['ForeignName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Datatype'] = this.datatype.index;
    data['IsRequired'] = this.isRequired;
    data['IsUnique'] = this.isUnique;
    data['IsForeignKey'] = this.isForeignKey;
    data['ForeignSchema'] = this.foreignSchema;
    data['ForeignTable'] = this.foreignTable;
    data['ForeignName'] = this.foreignName;
    return data;
  }
}
