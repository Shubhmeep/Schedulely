import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ToDoCard extends StatelessWidget {
  ToDoCard({required this.title,required this.icondata, required this.IconColor, required this.Iconbgcolor, required this.time,required this.del, required this.document, required this.id});
  final String title;
  final IconData icondata;
  final Color IconColor;
  final Color Iconbgcolor;
  final String time;
  final IconData del;
  final Map<String, dynamic> document;
  final String id;

  User? user = FirebaseAuth.instance.currentUser;

  delete() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection("Todo").doc(user!.uid).collection("Todo").doc(id);

    documentReference.delete();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 100,
              child: Card(
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xFF1D1E33),
                child: Row(
                  children: [
                    SizedBox(width: 15,),
                    Container(
                      height: 30,
                      width: 30,
                      decoration:BoxDecoration(
                        color: Iconbgcolor,
                        borderRadius: BorderRadius.circular(8),
                      ) ,
                      child: Icon(icondata,color: IconColor,),
                    ),
                    SizedBox(width: 20,),
                    Expanded(child: Text(title,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white70),)),
                    Expanded(child: Text(time,style: TextStyle(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.white70),)),
                    Expanded(child: Text(document['days'],style: TextStyle(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.white70),)),
                    Expanded(child: Text(document['body part'],style: TextStyle(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.white70),)),
                    Expanded(
                      child: InkWell(onTap:(){
                        delete();
                      },child: Icon(del,color:Colors.red,)),
                    ),
                  ],

                ),

              ),
            ),
          ),
        ],

      ),
    );
  }
}
