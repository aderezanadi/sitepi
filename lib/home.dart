import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sitepi/login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void doLogout() async {
    FirebaseAuth.instance.signOut()
    .then((e){
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Sitepi"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app, size: 30.0,),
            onPressed: (){
              doLogout();
            },
          )
        ],
      ),
      body: Container(),
    );
  }
}