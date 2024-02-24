class dataModel {
  late String email;
  late String username;
  late String password;

  dataModel(this.email, this.username, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'email': email,
      'username': username,
      'password': password
    };
    return map;
  }

  dataModel.fromMap(Map<String, dynamic> map) {
    email = map['email'];
    username = map['username'];
    password = map['password']; 
  }
}
