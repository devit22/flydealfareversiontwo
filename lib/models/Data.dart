class Data {

  String? id;
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? username;
  String? password;
  String? passValue;
  String? dated;
  String? lastLogin;
  String? source;
  String? country;
  String? state;

  Data({
      this.id, 
      this.name, 
      this.email, 
      this.mobile, 
      this.address, 
      this.username, 
      this.password, 
      this.passValue, 
      this.dated, 
      this.lastLogin, 
      this.source,
  this.country,
    this.state

  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    username = json['username'];
    password = json['password'];
    passValue = json['passValue'];
    dated = json['dated'];
    lastLogin = json['lastLogin'];
    source = json['source'];
    country= json['country'];
    state = json['state'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['mobile'] = mobile;
    map['address'] = address;
    map['username'] = username;
    map['password'] = password;
    map['passValue'] = passValue;
    map['dated'] = dated;
    map['lastLogin'] = lastLogin;
    map['source'] = source;
    map['country']= country;
    map['state'] = state;
    return map;
  }

}