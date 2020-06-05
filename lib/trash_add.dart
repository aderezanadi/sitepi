import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sitepi/trash.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TrashAdd extends StatefulWidget {
  @override
  _TrashAddState createState() => _TrashAddState();
}

class _TrashAddState extends State<TrashAdd> {
  final _formKey = new GlobalKey<FormState>();

  final alamat = TextEditingController();
  final lang = TextEditingController();
  final lat = TextEditingController();

  void save(){
    try{
      
      FirebaseDatabase.instance.reference().push().set({
        'atas':0,
        'kiri':0,
        'kanan':0,
        'lokasi':{
          'alamat': alamat.text,
          'lang':double.parse(lang.text),
          'lat':double.parse(lat.text)
        }
      }).then((value){
        Navigator.of(context).pop(
          MaterialPageRoute(builder: (_) {
            return Trash();
          }),
        );
      });
    }catch(e){
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text("Add"),
      ),
      body: Container(
        child: new Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(height: 20.0),
              //Alamat
              TextFormField(
                controller: alamat,
                autofocus: false,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Alamat',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
              SizedBox(height: 8.0),

              //Langitude
              TextFormField(
                controller: lang,
                keyboardType: TextInputType.number,
                autofocus: false,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Langitude',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
              SizedBox(height: 8.0),

                //Latitude
              TextFormField(
                controller: lat,
                keyboardType: TextInputType.number,
                autofocus: false,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Latitude',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
              SizedBox(height: 8.0),

              //saveButton
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  onPressed: () {
                    save();
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  