import 'package:flutter/material.dart';
import 'package:wisata_cirebon/model/tourism_place.dart';
import 'dart:convert';

import 'model/tourism_place.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wisata_cirebon/model/photo.dart';

var informationTextStyle = TextStyle(fontFamily: 'Oxygen');

class DetailScreen extends StatelessWidget {
  final TourismPlace place;
  final Photo photo;

  DetailScreen({required this.place, required this.photo});
  

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode('${photo.photoName}');

    var imageUrls;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(children: [
              Image.asset(place.imageAsset),
              Image.memory(bytes),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                      FavoriteButton(),
                    ],
                  ),
                ),
              )
            ]),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Text(
                place.name,
                semanticsLabel: '${photo.wisata}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Staatliches',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(Icons.calendar_today),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        place.openDays,
                        semanticsLabel: '${photo.hari}',
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.access_time),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        place.openTime,
                        semanticsLabel: '${photo.jam}',
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.monetization_on),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        place.ticketPrice,
                        semanticsLabel: 'Rp. ${photo.harga}',
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                place.description,
                semanticsLabel: '${photo.deskripsi}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Oxygen',
                ),
              ),
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: place.imageUrls.map((url) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(url),
                    ),
                  );
                }).toList(),
              ),
            ),
             Container(
               height: 150,
               child: ListView(
                 scrollDirection: Axis.horizontal,
                 children: photo.imageUrls.map((url) {
                   return Padding(
                     padding: const EdgeInsets.all(4.0),
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(10),
                       child: Image.network(url),
                     ),
                   );
                 }).toList(),
               ),
             ),
          ],
        ),
      ),
    );
  }
}
class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}
class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}