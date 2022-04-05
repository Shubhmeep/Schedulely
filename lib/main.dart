import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:gym/pages/signinpage.dart';
import 'package:gym/pages/homepage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //for binding widgets and firebase
  await Firebase.initializeApp();//this will initialise the firebase on our fultter app

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);


  @override
  State<MyApp> createState() => _State();
}

class _State extends State<MyApp> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;  //initialising the firebase auth variable (basically yaha object baanaya hai auth package ka)
  // void signup() async{
  //   try{
  //     await firebaseAuth.createUserWithEmailAndPassword(email: 'shubh.sehgal2506@gmail.com', password: 'password');
  //
  //   }
  //   catch(e){
  //     print(e);
  //   }
  // }


  final storage = new FlutterSecureStorage();
  Future<bool> checkLoginStatus() async{
    String? value = await storage.read(key: 'uid');
    if(value == null){
      return false;
    }
    return true;

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: FutureBuilder(
      future: checkLoginStatus(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot)
      {
        if (snapshot.data == false){
          return signinpage();
        }
        if (snapshot.connectionState == ConnectionState.waiting){
          return Container(color:Colors.white,child: Center(child: CircularProgressIndicator(),));
        }

        return homepage();


      },

    ),

    );
  }
}
