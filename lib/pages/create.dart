import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/pages/homepage.dart';
import 'package:flutter/cupertino.dart';

class create_new_todo extends StatefulWidget {
  //const create_new_todo({Key? key}) : super(key: key);

  @override
  State<create_new_todo> createState() => _create_new_todoState();
}

class _create_new_todoState extends State<create_new_todo> {
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController timecontroller = TextEditingController();
  String daytype = "";
  String bodypart = "";

  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color(0xFF0A0E21),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              IconButton(onPressed: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => homepage()), (route) => false);}, icon:Icon(CupertinoIcons.arrow_left,color: Colors.white,size: 28,)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create',style: TextStyle(fontSize:33,color: Colors.white,fontWeight: FontWeight.bold ,letterSpacing: 5),),
                    SizedBox(height: 8,),
                    Text('Your Schedule',style: TextStyle(fontSize:33,color: Colors.white,fontWeight: FontWeight.bold ,letterSpacing: 5),),
                    //Text('Exercise Name',style: TextStyle(fontSize:16,color: Colors.white,fontWeight: FontWeight.w600 ,letterSpacing: 0.3),),
                    SizedBox(height: 23,),
                    label('Task Title'),
                    SizedBox(height: 12,),
                    box1(),
                    SizedBox(height: 23,),
                    label('Task Type'),
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        day1('Priority',0xfff44336),
                        SizedBox(width: 8,),
                        day1('Optional',0xffc51162),
                        SizedBox(width: 8,),
                        day1('Help',0xffff6d6e ),
                      ],

                    ),

                    SizedBox(height: 23,),
                    label('Time'),
                    SizedBox(height: 12,),
                    box2(),
                    SizedBox(height: 23,),
                    label('Label'),
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        day2('Notes',0xffff6d6e),
                        SizedBox(width: 8,),
                        day2('Code',0xffc51162),
                        SizedBox(width: 8,),
                        day2('Project',0xfff44336 ),

                      ],

                    ),
                    Row(
                      children: [
                        day2('Class', 0xffff9800),
                        SizedBox(width: 8,),
                        day2('Workout', 0xff448aff)
                      ],
                    ),
                    SizedBox(height: 40,),
                    button(),


                  ],
                ),
              ),

            ],
          ),

        ),
      ),

    );
  }

  Widget button(){
    return InkWell(
      onTap: (){
        firebaseFirestore.collection('Todo').doc(user!.uid).collection('Todo').add(
          {
            'title': titlecontroller.text,
            'time': timecontroller.text,
            'days': daytype,
            'body part': bodypart
          }
        );
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => homepage()), (route) => false);
      },
      child: Center(
        child: Container(

          height: 45,
          width: 200,
          decoration: BoxDecoration(color: Color(0xFF1D1E33),borderRadius:BorderRadius.circular(35),gradient: LinearGradient(colors:[Color(0xfffd746c),Color(0xffff9068),Color(0xfffd746c)]) ),
          child: Center(child: Text("Create",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),


        ),
      ),
    );
  }
  Widget day1(String days,int color){
    return InkWell(
      onTap: (){
        setState(() {
          daytype = days;
        });
      },
      child: Chip(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),backgroundColor:daytype==days?Colors.green:Color(color),label:Text(days,style: TextStyle(color: Colors.white70,fontSize: 17,fontWeight: FontWeight.w600),
      ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 4),
      ),
    );
  }

  Widget day2(String days,int color){
    return InkWell(
      onTap: (){
        setState(() {
          bodypart = days;
        });
      },
      child: Chip(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),backgroundColor:bodypart==days?Colors.green:Color(color),label:Text(days,style: TextStyle(color: Colors.white70,fontSize: 17,fontWeight: FontWeight.w600),
      ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 4),
      ),
    );
  }
  
  Widget label(String label){
    return Text(label,style: TextStyle(fontSize:15,color: Colors.white70,fontWeight: FontWeight.w600 ,letterSpacing: 0.3),);
  }
  Widget box1(){
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Color(0xFF1D1E33),borderRadius:BorderRadius.circular(15) ),
      child: TextFormField(

        controller:titlecontroller,style: TextStyle(color: Colors.grey,fontSize: 17),decoration: InputDecoration(border: InputBorder.none,contentPadding: EdgeInsets.all(15)),),

    );
  }
  Widget box2(){
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Color(0xFF1D1E33),borderRadius:BorderRadius.circular(15) ),
      child: TextFormField(

        controller:timecontroller,style: TextStyle(color: Colors.grey,fontSize: 17),decoration: InputDecoration(border: InputBorder.none,contentPadding: EdgeInsets.all(15)),),

    );
  }


}
