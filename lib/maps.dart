import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Maps"),
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.reference().onValue,
        builder: (context, AsyncSnapshot<Event> snap) {
          if (snap.hasData) {
            List<Marker> marker = [];
            Map<dynamic, dynamic> data = snap.data.snapshot.value;
            data.forEach((key, value) {
              marker.add(
                new Marker(
                  width: 45.0,
                  height: 45.0,
                  point: new LatLng(value['lokasi']['lat'],value['lokasi']['lang']),
                  builder: (ctx) =>
                  new Container(
                    child: IconButton(
                      icon: Icon(Icons.location_on),
                      color: Colors.green,
                      iconSize: 35.0,
                      onPressed: (){
                        showModalBottomSheet(context: context, builder: (BuildContext bc){
                          return Container(
                            height: MediaQuery.of(context).size.height * .30,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(value['lokasi']['alamat'], style: TextStyle(fontSize: 25, color: Colors.blue),)
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Isi sampah : " + value['atas'], style: TextStyle(fontSize: 20, color: Colors.black),)
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Kiri : " + value['kiri'], style: TextStyle(fontSize: 20, color: Colors.black),)
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Kanan : " + value['kanan'], style: TextStyle(fontSize: 20, color: Colors.black),)
                                ),
                              ]
                            ),
                          );
                        });
                      }
                    ),
                  ),
                )
              );
            });
            
            return FlutterMap(
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
                new MarkerLayerOptions(
                  markers: marker
                )
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}