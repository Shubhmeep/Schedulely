import 'package:flutter/material.dart';
import 'package:gym/pages/homepage.dart';
import 'package:gym/pages/signinpage.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class nav extends StatelessWidget {
  final storage = new FlutterSecureStorage();
  final padding = EdgeInsets.symmetric(horizontal: 30,vertical: 30);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:Material(
        color: Color(0xFF0A0E21),
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(height: 40,),
            buildMenuItem(

              text:'Home',
              icon: Icons.home,
              onClicked: () => selectedItem(context,0),
            ),

            buildMenuItem(
              text:'Logout',
              icon: Icons.logout,
              onClicked: () async => {

                await firebase_auth.FirebaseAuth.instance.signOut(),
                await storage.delete(key:'uid'),
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => signinpage()), (route) => false)

              },
            ),


          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({required String text,required IconData icon, VoidCallback? onClicked,}){
    final color = Colors.white70;
    final hoverColor = Color(0xFFEB1555);
    return ListTile(
      //padding:padding,
      leading: Icon(icon,color: color,),
      title: Text(text,style:TextStyle(color: color)),
      hoverColor: hoverColor,

      onTap:onClicked,
    );
  }

  void selectedItem(BuildContext context, int index){

    switch (index){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => homepage(),
        ));
        break;



// for logout
    }

  }
}
