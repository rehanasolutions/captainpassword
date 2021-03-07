class Role {
  int id;
  String name;
  String description;
  int level;

  Role({this.id, this.name, this.description, this.level});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    description = json['Description'];
    level = json['Level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['Level'] = this.level;
    return data;
  }
}
