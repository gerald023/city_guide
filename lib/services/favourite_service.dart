import 'dart:convert';
import 'dart:io';
import 'package:city_guide/models/cities.dart';
import 'package:uuid/uuid.dart';
import 'package:cloudinary_flutter/cloudinary_object.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
// import 'package:cloudinary_flutter/image/cld_image.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';

// used to add id for the models.
const uuid = Uuid();

class CityGuideServices{
  CityGuideServices._privateConstructor();

  static final _instance = CityGuideServices._privateConstructor();
  
  factory CityGuideServices(){
    return _instance;
  }


// firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // cloudinary instances
void cloudService(){
  CloudinaryObject.fromCloudName(cloudName: 'dbjehxk0f');
   Cloudinary.fromCloudName(cloudName: 'dbjehxk0f');
}

Future<void> addCityToFavorite(cityId) async{
  try{

  }catch(e){
    print('error while adding city to favorite $e');
  }
}

}