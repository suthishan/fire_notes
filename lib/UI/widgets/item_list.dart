// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase_task/UI/addNotes/edit_screen.dart';
// import 'package:flutter_firebase_task/services/database.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ItemList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
     
//     return StreamBuilder<QuerySnapshot>(
//       stream: Database.readItems(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         } else if (snapshot.hasData || snapshot.data != null) {
//           return ListView.separated(
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             separatorBuilder: (context, index) => SizedBox(height: 1.0),
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               var noteInfo = snapshot.data!.docs[index].data()! as Map;
//               String docID = snapshot.data!.docs[index].id;
//               String title = noteInfo['title'];
//               String description = noteInfo['description'];

//               return Padding(
//                 padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
//                 child: Ink(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                           blurRadius: 1.5, color: Colors.grey.withOpacity(0.5))
//                     ],
//                     borderRadius: BorderRadius.circular(5.0),
//                     border: Border.all(color: Colors.white, width: 1.0),
//                   ),
//                   child: ListTile(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => EditScreen(
//                             currentTitle: title,
//                             currentDescription: description,
//                             documentId: docID,
//                           ),
//                         ),
//                       );

//                       debugPrint(docID);
//                     },
//                     title: Text(
//                       title,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     subtitle: Text(
//                       description,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         }

//         return Center(
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(
//               Color(0xFFF57C00),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
