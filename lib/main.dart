import 'package:flutter/material.dart';

// Sample code from https://github.com/pythonhubpy/YouTube/blob/Firebae-CRUD-Part-1/lib/main.dart#L19
// video https://www.youtube.com/watch?v=SmmCMDSj8ZU&list=PLtr8DfMFkiJu0lr1OKTDaoj44g-GGnFsn&index=10&t=291s

void main() {
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

  List<String> itemList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
            Row(
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
                    onPressed: () async {
                      setState(() {
                        itemList.add(_newItemTextField.text);
                        _newItemTextField.clear();
                      });
                    },
                    child: Text(
                      'Add Data',
                      style: TextStyle(fontSize: 20),
                    )),
              ),
            ],
          ),
              SizedBox(height: 40,),
              Expanded(
                child: ListView.builder(
                  itemCount: itemList.length,
                  itemBuilder: (BuildContext context, int position) {
                    return Card(
                        child: ListTile(
                          leading: Icon(Icons.check_box),
                          title: Text(itemList[position]),
                          onTap: () {
                            setState(() {
                              print("You tapped on items $position");
                              itemList.removeAt(position);
                            });
                          },
                        )
                    );
                  }
                )
              ),
            ],
          ),
        ),
      );
  }
}

