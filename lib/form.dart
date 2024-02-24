import 'package:alert_dialog/alert_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wisata_cirebon/helper/Utility.dart';
import 'package:wisata_cirebon/helper/dbHelper.dart';
import 'package:wisata_cirebon/helper/helperData.dart';
import 'package:wisata_cirebon/main_screen.dart';
import 'package:wisata_cirebon/model/photo.dart';

class FormPage extends StatefulWidget {
  FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController cWisata = TextEditingController();
  TextEditingController cAlamat = TextEditingController();
  TextEditingController cDeskripsi = TextEditingController();
  TextEditingController cHari = TextEditingController();
  TextEditingController cJam = TextEditingController();
  TextEditingController cHarga = TextEditingController();
  TextEditingController cPhoto = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  var dbhelper = HelperData();
  pickImageFromGallery() {
    _picker.pickImage(source: ImageSource.gallery).then((imgFile) async {
      String imgString = Utility.base64String(await imgFile!.readAsBytes());
      // print(imgString);
      Photo photo = Photo(
          wisata: cWisata.text,
          alamat: cAlamat.text,
          deskripsi: cDeskripsi.text,
          hari: cHari.text,
          jam: cJam.text,
          harga: cHarga.text,
          photoName: imgString);
      dbhelper.savePhoto(photo);
      // refreshImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Form Tambah Wisata',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: TextField(
                controller: cWisata,
                decoration: InputDecoration(
                    hintText: 'Wisata',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                controller: cAlamat,
                decoration: const InputDecoration(
                    hintText: 'Alamat',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                controller: cDeskripsi,
                decoration: const InputDecoration(
                    hintText: 'Deskripsi',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                controller: cHari,
                decoration: const InputDecoration(
                    hintText: 'Hari Buka',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                controller: cJam,
                decoration: const InputDecoration(
                    hintText: 'Jam Kerja',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextField(
                controller: cHarga,
                decoration: const InputDecoration(
                    hintText: 'Harga Masuk',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(6),
                    backgroundColor: Colors.blueAccent),
                child: Text('Tambah Foto + Data'),
                onPressed: () async {
                  await pickImageFromGallery();

                  Navigator.pushReplacement( 
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(), 
                      ),);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void simpanData() async {
    String uWisata = cWisata.text;
    String uAlamat = cAlamat.text;
    String uDeskripsi = cDeskripsi.text;
    String uHari = cHarga.text;
    String uJam = cJam.text;
    String uHarga = cHarga.text;
    String uPhoto = cPhoto.text;

    Photo uModel = Photo(
        wisata: uWisata,
        alamat: uAlamat,
        deskripsi: uDeskripsi,
        hari: uHari,
        jam: uJam,
        harga: uHarga,
        photoName: uPhoto);
    await dbhelper.savePhoto(uModel).then((userData) {
      print('succes');
      // print(userData);
      alert(context, content: Text('Data berhasil disimpan'));
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ));
    }).catchError((error) {
      print(error);
      alert(context, content: Text('Register Gagal'));
    });
  }
}
