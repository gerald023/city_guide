import 'dart:convert';
import 'dart:io';
import 'package:city_guide/models/attraction_list_model.dart';
import 'package:city_guide/models/cities.dart';
import 'package:city_guide/services/city_guide_services.dart';
import 'package:city_guide/services/cloudinary_upload_service.dart';
import 'package:image_picker/image_picker.dart';
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

class AttractionService{
  AttractionService._privateConstructor();

  static final _instance = AttractionService._privateConstructor();
  
  factory AttractionService(){
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

Future<void> createAttractionList(AttractionListModel attractionList) async{
  try{
    await _firestore.collection('AttractionList').doc(attractionList.attractionListId).set(attractionList.toMap());

  }catch(e){
    print('error while adding city to favorite $e');
  }
}

Future<String?> createAttraction({
  // required String attractionId,
  required String category,
  required String name,
  required List<XFile> images,
  required String description,
  required String cityId,
  required double lat,
  required double lng,
  required int rating,
}) async{
  try{
     User? user = _auth.currentUser;
       if (user == null) {
        return 'User not logged in.';
      }

      DocumentSnapshot userDoc = await _firestore.collection('Users').doc(user.uid).get();

      bool isAdmin = userDoc.get('admin') ?? false;

      if (!isAdmin) {
        return 'only admin can add cities';
      }

      List<String> imagesUrls = [];
     try{
      final cloudinary_upload = CloudinaryUploadService();
       for (XFile image in images) {
        String? uploadUrl = await cloudinary_upload.uploadImageToCloudinary(image);

        if (uploadUrl != null) {
          imagesUrls.add(uploadUrl);
        }
        print(imagesUrls);
        String attractionId = uuid.v4();
        
        await _firestore.collection('Attractions').doc(attractionId).set({
          'attractionId': attractionId,
          'category': category,
          'name': name,
          'rating': rating,
          'images': imagesUrls,
          'cityId': cityId,
          'longitude': lng,
          'latitude': lat,
          'description': description,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });

        // await _firestore .collection('AttractionList').doc(attractionListId).update({
        //   'attractions': FieldValue.arrayUnion([attractionId]),
        // });

      }
     }catch(e){
      print('image upload failed $e');
     }

  }catch(e){
    print(e);
    return 'error creating attraction $e';
  }
}

}