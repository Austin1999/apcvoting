import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'user_management.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  var asd;
  List ite = [];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // FetchData();
  // }

  // FetchData() async {
  //   dynamic resultant = await UserManagement().getPeopleList();
  //   if (resultant == null) {
  //     print('unable to fetch data');
  //   } else {
  //     setState(() {
  //       ite = resultant;
  //       print(asd);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 600,
            width: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(35)),
              color: Color(0xFFedeeef),
            ),
            child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('APC-VOTING').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: ite.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data.docs[index];
                        print(data.get('HEADING'));
                        return GridTile(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                data.get('HEADING'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              for (var asd in ite[index]['PEOPLES']
                                  .toString()
                                  .replaceAll('[', '')
                                  .replaceAll(']', '')
                                  .split(','))
                                // Text( ite[index]['HEADING'].toString()),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FlatButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      // var indexval = ite[index]['PEOPLES'].indexOf(asd);
                                      print(asd);
                                      print('${data.get(index)}');
                                      FirebaseFirestore.instance
                                          .collection('APC-VOTING')
                                          .doc(data.id)
                                          .update(
                                              {asd: FieldValue.increment(1)});
                                    },
                                    child: Text(
                                      asd,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ));
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
