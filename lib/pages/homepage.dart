import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/pages/create.dart';
import 'package:gym/pages/nav.dart';
import 'package:gym/pages/todocard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym/pages/update.dart';

class homepage extends StatefulWidget {


  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  User? user = FirebaseAuth.instance.currentUser;

  //final Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection('Todo').doc(user!.uid).collection('Todo').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      drawer: nav(),
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0E21),
          title: new Row
            (
            mainAxisAlignment: MainAxisAlignment.end,
            children:
            [
            IconButton(icon: Icon(Icons.add), onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => create_new_todo()), (route) => false);
            }),
              Container(padding: const EdgeInsets.all(8.0),)
            ],
          )

      ),

      body: StreamBuilder<QuerySnapshot>(        //If we need to build a widget based on the result of a Stream , you can use the StreamBuilder widget
        stream: FirebaseFirestore.instance.collection('Todo').doc(user!.uid).collection('Todo').snapshots(),                    //stream is the source of our data which is firestore
        builder: (context, AsyncSnapshot snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                IconData del;
                IconData iconData;
                Color iconColor;
                Map<String, dynamic> document = (snapshot.data! as QuerySnapshot).docs[index].data() as Map<String,dynamic>;


                switch(document['body part']){
                 case "Notes":
                   iconData = (Icons.book);
                   iconColor = Colors.orange;
                   break;

                 case "Code":
                   iconData = (Icons.computer);
                   iconColor =Colors.blueGrey;
                   break;

                 case "Project":
                   iconData = (Icons.work);
                   iconColor =Colors.black87;
                   break;

                 case "Class":
                   iconData = (Icons.add_chart );
                   iconColor =Colors.pink;
                   break;

                 case "Workout":
                   iconData = (Icons.sports_gymnastics);
                   iconColor =Colors.green;
                   break;

                 default:
                   iconData = (Icons.alarm_add);
                   iconColor =Colors.red;

               }

            return InkWell(
              onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => updatedata(
                  document: document,
                  id: snapshot.data.docs[index].id
                )),
                        (route) => false);
              },
              child: ToDoCard(
                title: document['title'],
                Iconbgcolor: Colors.white,
                IconColor: iconColor,
                icondata: iconData,
                time: document['time']==""?'No Time Added':document['time'],
                  del:Icons.delete,
                document: document,
                id: snapshot.data.docs[index].id,

              ),
            );
          });
        }
      ),

    );
  }
}
