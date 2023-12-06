import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

// Sample code from https://github.com/pythonhubpy/YouTube/blob/Firebae-CRUD-Part-1/lib/main.dart#L19
// video https://www.youtube.com/watch?v=SmmCMDSj8ZU&list=PLtr8DfMFkiJu0lr1OKTDaoj44g-GGnFsn&index=10&t=291s

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FireStore Demo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirebaseDemo(),
    );
  }
}

class FirebaseDemo extends StatefulWidget {
  @override
  _FirebaseDemoState createState() => _FirebaseDemoState();
}

class _FirebaseDemoState extends State<FirebaseDemo> {
  final TextEditingController _newItemTextField = TextEditingController();

  //List<String> itemList = [];
  final CollectionReference itemCollectionDB = FirebaseFirestore.instance.collection('ITEMS');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            inputRowWidget(context),
            SizedBox(height: 40,),
            ListItemsWidget(),
          ],
        ),
      ),
    );
  }

  Widget ListItemsWidget() {
    return Expanded(
        child: StreamBuilder(
            stream: itemCollectionDB.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int position) {
                    return Card(
                        child: listTileWidget(snapshot, position)
                    );
                  }
              );
            }
        )
    );
  }

  Widget listTileWidget(snapshot, position) {
    return ListTile(
      leading: Icon(Icons.check_box),
      title: Text(snapshot.data!.docs[position]['item_name']),
      onTap: () {
        setState(() {
          print("You tapped on items $position");
          String itemId = snapshot.data!.docs[position].id;
          itemCollectionDB.doc(itemId).delete();
        });
      },
    );
  }

  Widget inputRowWidget(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.7,
          child: TextField(
            controller: _newItemTextField,
            style: TextStyle(fontSize: 22, color: Colors.black),
            decoration: InputDecoration(
              hintText: "Name",
              hintStyle: TextStyle(fontSize: 22, color: Colors.black),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        SizedBox(
          child: ElevatedButton(
              onPressed: ()  {
                setState(() async {
                  //itemList.add(_newItemTextField.text);

                  await itemCollectionDB.add({'item_name': _newItemTextField.text});
                  _newItemTextField.clear();
                });
              },
              child: Text(
                'Add Data',
                style: TextStyle(fontSize: 20),
              )),
        ),
      ],
    );
  }
}

