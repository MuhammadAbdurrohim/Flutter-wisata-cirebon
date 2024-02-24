class UserModel {
  late String email;
  late String username;
  late String password;

  UserModel(this.email, this.username, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'email': email,
      'username': username,
      'password': password
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    email = map['email'];
    username = map['username'];
    password = map['password']; 
  }
}
