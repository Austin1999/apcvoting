// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:webapp/User.dart';
// import 'package:webapp/admin_page.dart';
// class UserManagement {

//   Future getPeopleList() async{
//     List itemList = [];
//     var item;
//     try {
//       await Firestore.instance.collection('APC-VOTING').getDocuments().then((value){
//         value.documents.forEach((element) {
//           itemList.add(element.data());
//           for(  item in itemList);
//           return item;
//         });
//       });
//       return itemList;
//     } catch (e){
//       print(e);
//     }
//   }

//   StoreNewUser(user,context){
//     Firestore.instance.collection('/apc-users').add({
//       'email' : FirebaseAuth.instance.currentUser.email,
//       'uid' : FirebaseAuth.instance.currentUser.uid,
//       'role' : 'Admin',
//     }).then((value) {
//       Navigator.pop(context);
//       authorizeAccess(context);
//     }).catchError((e){
//       print(e);
//     });
//   }

//   Future authorizeAccess(BuildContext context) async{
//     await FirebaseAuth.instance.currentUser;{
//      await Firestore.instance.collection('/apc-users').where('email',isEqualTo: FirebaseAuth.instance.currentUser.email).getDocuments().then((docs){
//         if(docs.documents[0].exists){
//           if( docs.documents[0].get('role')=='Admin'){
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     AdminPage1(),
//               ),
//             );
//           }else
//           {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                    UserPage(),
//               ),
//             );
//           }
//         }
//       });
//     }
//   }
// }
