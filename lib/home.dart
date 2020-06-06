import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sitepi/login.dart';
import 'package:sitepi/maps.dart';
import 'package:sitepi/trash.dart';
import 'package:sitepi/user.dart';


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
      appBar: new AppBar(
        title: Text("SITEPI"),
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app, size: 30.0,),
            onPressed: (){
              doLogout();
            },
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                   Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return Maps();
                    }),
                  );
                },
                splashColor: Colors.green,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.map, size: 70,),
                      Text( "Maps", style: new TextStyle(fontSize:17.0),)
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return Trash();
                    }),
                  );
                },
                splashColor: Colors.green,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.delete, size: 70,),
                      Text( "Trash", style: new TextStyle(fontSize:17.0),)
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return User();
                    }),
                  );
                },
                splashColor: Colors.green,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.person, size: 70,),
                      Text( "User", style: new TextStyle(fontSize:17.0),)
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}