class Role {
  int id;
  String name;
  String description;
  int level;

  Role({this.id, this.name, this.description, this.level});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['level'] = this.level;
    return data;
  }
}
