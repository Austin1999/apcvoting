import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webapp/user_management.dart';

final _firestore = FirebaseFirestore.instance;

class AdminPage1 extends StatefulWidget {
  @override
  _AdminPage1State createState() => _AdminPage1State();
}

class _AdminPage1State extends State<AdminPage1> {
  List<String> _peoples = List();
  List<Widget> people = List();
  List<String> total = List();
  List<String> _title = List();
  var item;
  TextEditingController title = TextEditingController();
  String name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.pink,
            onPressed: () {
              onpressed();
            },
            child: Icon(Icons.add),
          ),
          body: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: total.length,
              itemBuilder: (context, index) {
                print('Total : $item');
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFFFDF5E6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(_title[index],
                              style: Theme.of(context).textTheme.headline6),
                        ),
                        for (item in total[index]
                            .replaceAll('[', '')
                            .replaceAll('[', '')
                            .replaceAll(']', '')
                            .replaceAll('[', '')
                            .replaceAll(']', '')
                            .split(','))
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    item,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              )),
                      ],
                    ),
                  ),
                );
              })),
    );
  }

  onpressed() {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.80,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter stateSetter) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Enter Required data",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: title,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            hintText: 'Title'),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Widget widget = people.elementAt(index);
                          return Row(
                            children: [
                              widget,
                              IconButton(
                                  icon: Icon(
                                    Icons.close,
                                  ),
                                  onPressed: () {
                                    deleted(stateSetter, index);
                                  })
                            ],
                          );
                        },
                        itemCount: people.length,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        backgroundColor: Colors.pink,
                        onPressed: () {
                          updated(stateSetter);
                          name != null
                              ? _peoples.add(name)
                              : print('Null value');
                          print('Controller : $name');
                        },
                        child: new Icon(Icons.add),
                      ),
                    ),
                    Row(
                      children: [
                        FlatButton(
                          onPressed: () async {
                            _title.add(title.text);
                            _peoples.add(name);
                            print('Controller : $name');
                            total.add(_peoples.toString());
                            print('Total : ${total.toString()}');

                            await _firestore.collection('APC-VOTING').add({
                              'HEADING': title.text,
                              'PEOPLES': _peoples,
                            }).then((value) async {
                              for (var i in _peoples)
                                await _firestore
                                    .collection('APC-VOTING')
                                    .doc(value.id)
                                    .update({
                                  _peoples[_peoples.indexOf(i)]: 0,
                                });
                            });
                            _peoples.clear();
                            people.clear();
                            title.clear();
                            setState(() {
                              name = null;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text('Submit'),
                        ),
                        FlatButton(
                          onPressed: () {
                            // _peoples.clear();
                            // people.clear();
                            title.clear();
                            setState(() {
                              name = null;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
          );
        });
  }

  Future updated(StateSetter updateState) {
    updateState(() {
      people.add(Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new TextFormField(
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                hintText: '(${people.length + 1}) Candidate Name'),
          ),
        ),
      ));
      setState(() {});
    });
  }

  deleted(StateSetter updateState, index) {
    updateState(() {
      people.removeAt(index);
    });
  }
}
