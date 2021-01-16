class Password {
  int id;
  String name;
  String url;
  String login;
  String password;
  String folder;
  String notes;
  bool encrypted;
  int userId;
  DateTime created;
  DateTime lastUpdated;

  Password(
      {this.id,
      this.name,
      this.url,
      this.login,
      this.password,
      this.folder,
      this.notes,
      this.encrypted,
      this.userId,
      this.created,
      this.lastUpdated});

  Password.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    url = json['Url'];
    login = json['Login'];
    password = json['Password'];
    folder = json['Folder'];
    notes = json['Notes'];
    encrypted = json['Encrypted'];
    userId = json['UserId'];
    created = json['Created'] != null ? DateTime.parse(json['Created']) : null;
    lastUpdated = json['LastUpdated'] != null
        ? DateTime.parse(json['LastUpdated'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    data['login'] = this.login;
    data['password'] = this.password;
    data['folder'] = this.folder;
    data['notes'] = this.notes;
    data['encrypted'] = this.encrypted;
    data['userId'] = this.userId;
    data['created'] = this.created != null ? this.created.toString() : null;
    data['lastUpdated'] =
        this.lastUpdated != null ? this.lastUpdated.toString() : null;
    return data;
  }
}
