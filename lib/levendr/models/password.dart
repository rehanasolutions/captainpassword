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
    createdBy = json['CreatedBy'];
    createdOn =
        json['CreatedOn'] != null ? DateTime.parse(json['CreatedOn']) : null;
    lastUpdatedBy = json['LastUpdatedBy'];
    lastUpdatedOn = json['LastUpdatedOn'] != null
        ? DateTime.parse(json['LastUpdatedOn'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Url'] = this.url;
    data['Login'] = this.login;
    data['Password'] = this.password;
    data['Folder'] = this.folder;
    data['Notes'] = this.notes;
    data['Encrypted'] = this.encrypted;
    data['CreatedBy'] = this.createdBy;
    data['CreatedOn'] =
        this.createdOn != null ? this.createdOn.toString() : null;
    data['LastUpdatedBy'] = this.lastUpdatedBy;
    data['LastUpdatedOn'] =
        this.lastUpdatedOn != null ? this.lastUpdatedOn.toString() : null;
    return data;
  }
}
