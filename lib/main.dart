import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:wisata_cirebon/helper/dbHelper.dart';
import 'package:wisata_cirebon/main_screen.dart';
import 'package:wisata_cirebon/main.dart';
import 'package:wisata_cirebon/register_page.dart';
import 'package:wisata_cirebon/testinglist.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  get place => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wisata Cirebon',
        theme: ThemeData(),
        home: Home());
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController c_username = TextEditingController();
  TextEditingController c_password = TextEditingController();
  final formKey = new GlobalKey<FormState>();

  var dbhelper = dbHelper();

  @override
  void initState() {
    dbhelper = dbhelper = dbHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("SELAMAT DATANG"),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: c_username,
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
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: Text("LOGIN")),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ));
                    },
                    child: Text("Create Accout")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    String uname = c_username.text;
    String upassword = c_password.text;
    if (uname.isEmpty) {
      Toast.show(
        "Masukan Email",
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
      );
    } else if (upassword.isEmpty) {
      Toast.show("Masukan Username",
          duration: Toast.lengthLong, gravity: Toast.bottom);
    } else {
      await dbhelper.getLogin(uname, upassword).then((userData) {
        if (userData != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        }
        print('---------------- ${userData.email}');
      }).catchError((error) {
        alert(
          context,
          content: Text('Login Gagal'),
        );
        print('---------------------$error');
      });
    }
  }
}
