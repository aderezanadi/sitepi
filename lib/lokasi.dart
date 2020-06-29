import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sitepi/lokasi_add.dart';
import 'package:sitepi/lokasi_edit.dart';

class Lokasi extends StatefulWidget {
  @override
  _LokasiState createState() => _LokasiState();
}

class _LokasiState extends State<Lokasi> {
  final dbRef = FirebaseDatabase.instance.reference();

  delete(String key) async{
    dbRef.child(key).remove();
  }

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: Text("List Lokasi"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: dbRef.onValue,
          builder: (context, snap){
            if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {
              Map data = snap.data.snapshot.value;
              List item = [];

              data.forEach((index, data) => item.add({"key": index, ...data}));
              return ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(item[index]['lokasi']['alamat'], style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                          subtitle: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text("Langitude : " + item[index]['lokasi']['lang'].toString())
                              ),
                              Expanded(
                                flex: 2,
                                child: Text("Langitude : " + item[index]['lokasi']['lat'].toString())
                              ),
                            ],
                          ),
                      ),
                    ),
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Edit',
                        color: Colors.blue,
                        icon: Icons.edit,
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return LokasiEdit(id: item[index]['key'].toString());
                            }),
                          );
                        },
                      ),
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: (){
                          delete(item[index]['key'].toString());
                        },
                      ),
                    ],
                  );
                },
              );
            }else{
              return Center(child: Text("No data"));
            }
          }
        ),        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) {
              return LokasiAdd();
            }),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}