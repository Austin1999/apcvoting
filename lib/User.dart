import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool ischecked = false;
  int pageindex = 0;
  int stepCounter = 0;
  PageController controller = PageController(viewportFraction: 0.7);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('APC-VOTING').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: controller,
                        physics: NeverScrollableScrollPhysics(),
                        onPageChanged: (int index) {
                          setState(() {
                            pageindex = index;
                          });
                        },
                        children: [
                          for (MapEntry j in snapshot.data.docs.asMap().entries)
                            Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                clipBehavior: Clip.antiAlias,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          snapshot.data.docs[j.key]
                                              .get('HEADING'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline,
                                        ),
                                      ),
                                      RadioGroup(snapshot, j),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                              color: Colors.white,
                              child: Center(child: Text('Back')),
                              onPressed: () {
                                controller.previousPage(
                                    duration: Duration(milliseconds: 1000),
                                    curve: Curves.easeOutQuad);
                              })),
                      FlatButton(
                        color: Colors.pink,
                        child: Center(
                            child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        )),
                        onPressed: () {
                          controller.nextPage(
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.easeOutQuad);
                        },
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class RadioGroup extends StatefulWidget {
  final snapshot, j;
  RadioGroup(this.snapshot, this.j);
  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  String people;
  List disabled = [];
  @override
  Widget build(BuildContext context) {
    return RadioButtonGroup(
        labels: widget.snapshot.data.docs[widget.j.key].get('PEOPLES'),
        picked: people,
        disabled: disabled,
        onSelected: (String selected) {
          setState(() {
            people = selected;
            disabled = widget.snapshot.data.docs[widget.j.key].get('PEOPLES');
            FirebaseFirestore.instance
                .collection('APC-VOTING')
                .doc(widget.snapshot.data.docs[widget.j.key])
                .update({
              people: FieldValue.increment(1),
            });
          });
        });
  }
}
