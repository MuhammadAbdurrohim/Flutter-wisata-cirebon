import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toast/toast.dart';
import 'package:wisata_cirebon/helper/dbHelper.dart';
import 'package:wisata_cirebon/main.dart';
import 'package:wisata_cirebon/main_screen.dart';
import 'package:wisata_cirebon/model/user_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = new GlobalKey<FormState>();

  TextEditingController c_username = TextEditingController();
  TextEditingController c_password = TextEditingController();
  TextEditingController c_userId = TextEditingController();
  TextEditingController c_email = TextEditingController();
  var dbhelper = dbHelper();

  @override
  void initState() {
    dbhelper = dbhelper = dbHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("SELAMAT DATANG.. Register"),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: c_email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Silahkan masukan email",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: c_username,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Silahkan masukan username",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: c_password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Silahkan masukan password",
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    signUp();
                  },
                  child: Text("Register")),
              Padding(padding: EdgeInsets.all(20)),
            ],
          ),
        ),
      ),
    );
  }

  void signUp() async {
    String umail = c_email.text;
    String uname = c_username.text;
    String upassword = c_password.text;
    if (umail.isEmpty) {
      Toast.show(
        "Masukan Email",
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
      );
    } else if (uname.isEmpty) {
      Toast.show("Masukan Username",
          duration: Toast.lengthLong, gravity: Toast.bottom);
    } else if (upassword.isEmpty) {
      Toast.show("Masukan Password",
          duration: Toast.lengthLong, gravity: Toast.bottom);
    } else {
      formKey.currentState!.save();

      UserModel uModel = UserModel(umail, uname, upassword);
      await dbhelper.saveData(uModel).then((userData) {
        print(userData);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ));
        alert(context, content: Text('Register Sukses'));
      }).catchError((error) {
        print(error);
        alert(context, content: Text('Register Gagal'));
      });
    }
  }
}
