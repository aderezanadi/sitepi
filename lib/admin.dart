import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final _formKey = new GlobalKey<FormState>();

  var email = TextEditingController();
  var password = TextEditingController();

  Future<void> getEmail() async {
    FirebaseAuth.instance
    .currentUser()
    .then((currentUser) => {
          setState(() {
            email = new TextEditingController(text: currentUser.email);
          })
    })
    .catchError((err) => print(err));
  }

  Future<void> save() async {
    try{
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      user.updatePassword(password.text).then((_){
        Fluttertoast.showToast(
          msg: "Password Update!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 3,
          backgroundColor: Colors.grey[400],
          textColor: Colors.white,
          fontSize: 16.0
        );
        password.clear();
      }).catchError((error){
        Fluttertoast.showToast(
          msg: "Password can't be changed!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 3,
          backgroundColor: Colors.grey[400],
          textColor: Colors.white,
          fontSize: 16.0
        );
      });
    }catch(e){
      print(e.message);
    }
  }

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text("User"),
      ),
      body: Container(
        child: new Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(height: 20.0),
              //Email
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Email',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
              SizedBox(height: 8.0),

              //Password
              TextFormField(
                controller: password,
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Password',
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