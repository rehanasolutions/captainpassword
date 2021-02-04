class Password {
  int id;
  String name;
  String url;
  String login;
  String password;
  String folder;
  String notes;
  bool encrypted;
  int createdBy;
  DateTime createdOn;
  int lastUpdatedBy;
  DateTime lastUpdatedOn;

  Password(
      {this.id,
      this.name,
      this.url,
      this.login,
      this.password,
      this.folder,
      this.notes,
      this.encrypted,
      this.createdBy,
      this.createdOn,
      this.lastUpdatedBy,
      this.lastUpdatedOn});

  Password.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    url = json['Url'];
    login = json['Login'];
    password = json['Password'];
    folder = json['Folder'];
    notes = json['Notes'];
    encrypted = json['Encrypted'];
    createdBy = json['createdBy'];
    createdOn =
        json['createdOn'] != null ? DateTime.parse(json['createdOn']) : null;
    lastUpdatedBy = json['lastUpdatedBy'];
    lastUpdatedOn = json['lastUpdatedOn'] != null
        ? DateTime.parse(json['lastUpdatedOn'])
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
    data['createdBy'] = this.createdBy;
    data['createdOn'] =
        this.createdOn != null ? this.createdOn.toString() : null;
    data['lastUpdatedBy'] = this.lastUpdatedBy;
    data['lastUpdatedOn'] =
        this.lastUpdatedOn != null ? this.lastUpdatedOn.toString() : null;
    return data;
  }
}
