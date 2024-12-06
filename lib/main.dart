import 'package:city_guide/admin/city/screen/create_city_screen.dart';
import 'package:city_guide/firebase_options.dart';
import 'package:city_guide/models/categories.dart';
import 'package:city_guide/models/cities.dart';
import 'package:city_guide/screens/authentication/screens/login_screen.dart';
import 'package:city_guide/screens/authentication/screens/new_sign_up.dart';
import 'package:city_guide/screens/city/screens/city_screen.dart';
import 'package:city_guide/screens/rating/screens/rating_screen.dart';
import 'package:city_guide/screens/unboarding/screens/onboarding_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:city_guide/screens/authentication/screens/sign_up_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:city_guide/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  try{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
  persistenceEnabled: true, // Enable offline persistence
);
  
  final bool hasOnboarded = prefs.getBool('hasOnboarded') ?? false;
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
   ProviderScope(
    child: GetMaterialApp(
      initialRoute: hasOnboarded
          ? (isLoggedIn ? '/main' : '/login')
          : '/splash',
      themeMode: ThemeMode.system,
      getPages: [
        GetPage(
          name: '/splash', 
          page: ()=> const OnboardingScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 250)
        ),
         GetPage(
          name: '/signup', 
          page: ()=> NewSignUp(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 250)
        ),
         GetPage(
          name: '/login', 
          page: ()=> LoginScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 250)
        ),
         GetPage(
          name: '/main', 
          page: ()=> const MainScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 250)
        ),
         GetPage(
          name: '/CityScreen', 
          page: ()=>  CityScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 250)
        ),
        GetPage(
          name: '/rating', 
          page: ()=> const RatingScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 250)
        ),
        GetPage(
          name: '/upload', 
          page: ()=> const UploadToFirestore(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 250)
        ),
         GetPage(
          name: '/admin-main', 
          page: ()=> const CreateCityScreen(),
          transition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 250)
        ),
        
      ],
    )
    )
  );
  }catch(e){
     debugPrint('Firebase initialization failed: $e');
  }

}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

//   // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}


class UploadToFirestore extends StatelessWidget {
  const UploadToFirestore({super.key});

  @override
  Widget build(BuildContext context) {
    print('widget built');
    return  Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            print('Button pressed');
            saveCitiesToFireStore();
          }, 
          child: const Text('Add items')),
      )
    );
  }
}
