import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/pages/homepage.dart';
import 'package:gym/pages/signuppage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class signinpage extends StatefulWidget {
  const signinpage({Key? key}) : super(key: key);

  @override
  State<signinpage> createState() => _signinpageState();
}

class _signinpageState extends State<signinpage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;  //initialising the firebase auth variable (basically yaha object baanaya hai auth package ka)
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  final storage = new FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(

        child: Container(

          height: MediaQuery.of(context).size.height,  //calc the pixel val of screen height
          width: MediaQuery.of(context).size.width,    //calc the pixel value of screen width
          color: Color(0xFF0A0E21),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/123-removebg-preview.png',height: 230,width: 200,),

              SizedBox(height: 15,),
              Container(
                width:MediaQuery.of(context).size.width-60 ,
                height: 60,
                child: Card(
                  color: Color(0xFF1D1E33),
                  child: TextFormField(
                    controller: _emailcontroller,
                    style: TextStyle(color: Colors.white70),
                    decoration: InputDecoration(

                      labelText: "Email ...",
                      labelStyle: TextStyle(color: Colors.white70),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.5,
                            color: Colors.lightGreen
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 13,),
              Container(
                width:MediaQuery.of(context).size.width-60 ,
                height: 60,
                child: Card(
                  color: Color(0xFF1D1E33),
                  child: TextFormField(
                    controller: _passwordcontroller,
                    style: TextStyle(color: Colors.white70),
                    obscureText: true ,
                    decoration: InputDecoration(

                      labelText: "Password ...",
                      labelStyle: TextStyle(color: Colors.white70),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.5,
                            color: Colors.lightGreen
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40,),
              InkWell(
                onTap: () async {

                  try{
                    firebase_auth.UserCredential usercredential =  await firebaseAuth.signInWithEmailAndPassword(
                        email: _emailcontroller.text,
                        password: _passwordcontroller.text);

                    storage.write(key:'uid',value:usercredential.user?.uid);





                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => homepage()),
                            (route) => false);

                  }
                  catch(e){
                    final snackbar = SnackBar(content: Text(e.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);

                  }


                },
                child: Container(
                  width:MediaQuery.of(context).size.width-90 ,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors:[Color(0xfffd746c),Color(0xffff9068),Color(0xfffd746c)])
                  ),

                  child: Center(child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("If you don't have an Account? ",style: TextStyle(color: Colors.white70),),
                  InkWell(
                      onTap: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => signuppage()), (route) => false);
                      },
                      child: Text('Sign up',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),))
                ],
              )



            ],
          ),
        ),
      ),
    );
  }


}
