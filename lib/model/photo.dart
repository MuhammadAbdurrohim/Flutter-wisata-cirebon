class Photo {
  int? id;
  String? wisata;
  String? alamat;
  String? deskripsi;
  String? hari;
  String? jam;
  String? harga;
  String? photoName;

  

  Photo(
      {this.id,
      required this.wisata,
      required this.alamat,
      required this.deskripsi,
      required this.hari,
      required this.jam,
      required this.harga,
      required this.photoName});

  get imageUrls => null;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'wisata': wisata,
      'alamat': alamat,
      'deskripsi': deskripsi,
      'hari': hari,
      'jam': jam,
      'harga': harga,
      'photoName': photoName
    };
    return map;
  }

  Photo.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    wisata = map['wisata'];
    alamat = map['alamat'];
    deskripsi = map['deskripsi'];
    hari = map['hari'];
    jam = map['jam'];
    harga = map['harga'];
    photoName = map['photoName'];
  }
}
