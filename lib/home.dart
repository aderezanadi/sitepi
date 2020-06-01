import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sitepi/login.dart';
import 'package:latlong/latlong.dart';

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

  getMarker(){
    try {
      List<Marker> marker = [];
      FirebaseDatabase.instance.reference().once().then((DataSnapshot snapshot){
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key,values) {
          marker.add(
            new Marker(
              width: 45.0,
              height: 45.0,
              point: new LatLng(values['lokasi']['lat'],values['lokasi']['lang']),/* (-8.7004,115.2207)(-8.6582,115.2081) */
              builder: (ctx) =>
              new Container(
                child: IconButton(
                  icon: Icon(Icons.location_on),
                  color: Colors.red,
                  iconSize: 45.0,
                  onPressed: (){
                    showModalBottomSheet(context: context, builder: (BuildContext bc){
                      return Container(
                        height: MediaQuery.of(context).size.height * .30,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(values['lokasi']['alamat'], style: TextStyle(fontSize: 25, color: Colors.blue),)
                            ),
                          ]
                        ),
                        
                      );
                    });
                  }),
              ),
            )
          );
        });
      });
      return new MarkerLayerOptions(
        markers: marker
      );    
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
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
      body: new FlutterMap(
        options: new MapOptions(
          center: new LatLng(-8.7004,115.2207),
          zoom: 13.50,
        ),
        layers: [
          new TileLayerOptions(
            urlTemplate: "https://api.mapbox.com/styles/v1/adityadarma/ckav73s6rd90n1io1vagquve5/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYWRpdHlhZGFybWEiLCJhIjoiY2s3bjlheTB1MHFqMzNmbzB4dnNxcXNsYiJ9.hp7Hswgy29gHzNvEmK-YGg",
            additionalOptions: {
              'accessToken': 'pk.eyJ1IjoiYWRpdHlhZGFybWEiLCJhIjoiY2s3bjlheTB1MHFqMzNmbzB4dnNxcXNsYiJ9.hp7Hswgy29gHzNvEmK-YGg',
              'id': 'mapbox.mapbox-streets-v7',
            },
          ),
          getMarker()
        ],
      ),
    );
  }
}