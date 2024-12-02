import 'dart:convert';
import 'dart:io';
import 'package:city_guide/models/cities.dart';
import 'package:uuid/uuid.dart';
import 'package:cloudinary_flutter/cloudinary_object.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
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

  // CloudinaryContext.cloudinary = Cloudinary.fromCloudName(cloudName: 'dbjehxk0f');
  // var data=await upload();


    String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
  }) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      if (user != null) {
        String hashedPassword = _hashPassword(password);

        Map<String, dynamic> data = {
          'userId': user.uid,
          'name': name,
          'email': email,
          'password': hashedPassword,
          'admin': false,
          'signInMethod': 'email-pass',
          'profilePicture':
              'https://res.cloudinary.com/dn7xnr4ll/image/upload/v1722866767/notionistsNeutral-1722866616198_iu61hw.png',
        };
        await _firestore.collection('Users').doc(user.uid).set(data);

         // Update display name
        await user.updateDisplayName(name);
        await user.updatePhotoURL(
            'https://res.cloudinary.com/dn7xnr4ll/image/upload/v1722866767/notionistsNeutral-1722866616198_iu61hw.png');
        await user.reload();

        // Send email verification
        await user.sendEmailVerification();
        return null;
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak.';
        case 'email-already-in-use':
          return 'An account already exists with this email.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'network-request-failed':
          return 'Network error occurred. Please check your connection.';
        default:
          return 'An unknown error occurred. Please try again.';
      }
    }catch(e){
      return 'An unexpected error occurred. Please try again.';
    }
    return 'Sign up failed. Please try again';
  }

  Future<Map<String, dynamic>?> signIn({
    required String email,
    required String password
  }) async{
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('Users').doc(user.uid).get();
        if (userDoc.exists) {
          bool isAdmin = userDoc.get('admin') ?? false;
          return {
            'isAdmin': isAdmin,
            'message': null
          };
        }else {
          return {
            'isAdmin': false,
            'message': 'User data not found.',
          };
        }
      }else {
        return {
          'isAdmin': false,
          'message': 'Login failed. Please try again.',
        };
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          return {'isAdmin': false, 'message': 'Invalid email or password.'};
        case 'user-disabled':
          return {'isAdmin': false, 'message': 'This user has been disabled.'};
        case 'user-not-found':
          return {
            'isAdmin': false,
            'message': 'No user found with this email.'
          };
        case 'wrong-password':
          return {
            'isAdmin': false,
            'message': 'The password is incorrect. Please try again.'
          };
        default:
          return {
            'isAdmin': false,
            'message': 'An error occurred. Please try again.'
          };
      }
    }catch (e) {
       return {
        'isAdmin': false,
        'message': 'An unexpected error occurred. Please try again.'
      };
    }
  }

  // sign out method
  Future<void> signOut() async {
    try{
      await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasOnboarded', true);
    await prefs.setBool('isLoggedIn', false);
    if (prefs.getBool('isLoggedIn')!) {
        print('user is logged in did not change');
    }else{
      print('user is logged in did change');
    }
    print('user is logged out');
    } on FirebaseAuthException catch(e){
      print(e.code);
    }catch(e){
      print(e);
    }
  }

  Future<String?> createCity({
    required String cityName,
    required List<File> images,
    required String category,
    required String country,
    required int rating
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

      for (File image in images) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://api.cloudinary.com/v1_1/dbjehxk0f/image/upload')
        );

        request.fields['upload_preset'] = 'dbjehxk0f';

        request.files.add(
          await http.MultipartFile.fromPath('file', image.path)
        );

        var response = await request.send();

        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          var jsonData = json.decode(responseData);
          imagesUrls.add(jsonData['secure_url']);
        }else {
          return 'Failed to upload image to Cloudinary';
        }

      String cityId = uuid.v4();

      // create city
      await _firestore.collection('Cities').doc(cityId).set({
        'id':  cityId,
        'cityName': cityName,
        'category': category,
        'country': country,
        'rating': rating,
        'images': imagesUrls,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return null;

      }
    }catch(e){
      print('error creating city $e');
      return 'An error occurred while creating the product. Please try again.';
    }
  }


  Future<CitiesModel?> getCity(String cityId) async{
    try{
      DocumentSnapshot cityDoc = await _firestore.collection('Cities').doc(cityId).get();

      if (cityDoc.exists) {
        return CitiesModel.fromMap(cityDoc.data() as Map<String, dynamic>); 
      }else{
        return null;
      }
    }catch(e){
      print('error geting the city $e');
      return null;
    }
  }

  Future<List<CitiesModel>> getAllCities() async {
    try{
      QuerySnapshot citySnapshot = await _firestore.collection('Cities').get();
      print('Raw document data: ${citySnapshot.docs.map((doc) => doc.data()).toList()}');
      return citySnapshot.docs.map((doc) {
        // return CitiesModel.fromMap(doc.data() as Map<String, dynamic>);
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Add the document ID to the map
        print('Mapped data: $data'); 
        return CitiesModel.fromMap(data);
      }).toList();
    }catch(e){
      print('Error while getting all cities $e');
      return [];
    } 
  }
}