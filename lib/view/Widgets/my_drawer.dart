import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sellers_app/global/global_instances.dart';
import 'package:sellers_app/global/global_vars.dart';
import 'package:sellers_app/view/Splash/splash_screen.dart';
import 'package:sellers_app/view/mainScreen/home_screen.dart';

class MyDrawer extends StatefulWidget {

  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [

          // header
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              children: [
                // image
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(81)),
                  elevation: 8,
                  child: SizedBox(
                    height: 158,
                    width: 158,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        sharedPreferences!.getString('imageUrl').toString()
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                Text(sharedPreferences!.getString('name').toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),)
                
              ],
            ),
          ),

          const SizedBox(height: 12,),

          Container(
            child: Column(
              children: [

                const Divider(
                  color: Colors.grey,
                  height: 10,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.white,),
                  title: const Text('Home',
                  style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
                  },
                ),
                const Divider(
                  color: Colors.grey,
                  height: 10,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.monetization_on, color: Colors.white,),
                  title: const Text('My Earnings',
                    style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
                  },
                ),
                const Divider(
                  color: Colors.grey,
                  height: 10,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.reorder, color: Colors.white,),
                  title: const Text('New Orders',
                    style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
                  },
                ),
                const Divider(
                  color: Colors.grey,
                  height: 10,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.local_shipping, color: Colors.white,),
                  title: const Text('History - Orders',
                    style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
                  },
                ),
                const Divider(
                  color: Colors.grey,
                  height: 10,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.share_location, color: Colors.white,),
                  title: const Text('Update My Location',
                    style: TextStyle(color: Colors.white),),
                  onTap: (){

                    commonViewModel.updateLocationInDatabase();
                    commonViewModel.showSnackBar("your restaurant/cafe address update successfully", context);
                  },
                ),
                const Divider(
                  color: Colors.grey,
                  height: 10,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.white,),
                  title: const Text('Sign Out',
                    style: TextStyle(color: Colors.white),),
                  onTap: (){

                    FirebaseAuth.instance.signOut();

                    Navigator.push(context, MaterialPageRoute(builder: (_)=> SplashScreen()));
                  },
                ),
                const Divider(
                  color: Colors.grey,
                  height: 10,
                  thickness: 2,
                ),

              ],
            ),
          )

        ],
      ),
    );
  }
}
