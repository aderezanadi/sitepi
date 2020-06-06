import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sitepi/trash_add.dart';

class Trash extends StatefulWidget {
  @override
  _TrashState createState() => _TrashState();
}

class _TrashState extends State<Trash> {
  final dbRef = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text("Trash"),
      ),
      body: Container(
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) {
              return TrashAdd();
            }),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class DataTrash {
  String key;
  int atas;
  int kanan;
  int kiri;
  String alamat;
  num lang;
  num lat;

  DataTrash(this.atas, this.kanan, this.kiri ,this.alamat, this.lang, this.lat);

  DataTrash.fromSnapshot(snapshot) :
    key = snapshot.key,
    atas = snapshot.value["atas"],
    kanan = snapshot.value["kanan"],
    kiri = snapshot.value["kiri"],
    alamat = snapshot.value["lokasi"]["alamat"],
    lang = snapshot.value["lokasi"]["lang"],
    lat = snapshot.value["lokasi"]["lat"];
  DataTrash.map(dynamic obj) {
    this.atas = obj['atas'];
    this.kanan = obj['kanan'];
    this.kiri = obj['kiri'];
  }
  toJson() {
    return {
      "atas": atas,
      "kanan": kanan,
      "kiri": kiri,
      "alamat": alamat,
      "lang": lang,
      "lat": lat,
    };
  }
}