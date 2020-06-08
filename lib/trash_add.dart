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
  bool isLoading = false;

  void save(){
    setState(() {
        isLoading = true;
      });
    try{
      FirebaseDatabase.instance.reference().push().set({
        'atas':'kosong',
        'kiri':'kosong',
        'kanan':'kosong',
        'lokasi':{
          'alamat': alamat.text,
          'lang':num.parse(lang.text),
          'lat':num.parse(lat.text)
        }
      }).then((_) {
        Fluttertoast.showToast(
          msg: "Lokasi ditambahkan!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 3,
          backgroundColor: Colors.grey[400],
          textColor: Colors.white,
          fontSize: 16.0
        );
        Navigator.of(context).pop(
          MaterialPageRoute(builder: (_) {
            return Trash();
          }),
        );
      }).catchError((onError) {
        setState(() {
          isLoading = false;
        });
        print(onError);
      });
    }catch(e){
      setState(() {
        isLoading = false;
      });
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
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white
                        ),
                      )
                    : RaisedButton(
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
  