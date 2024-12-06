import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const uuid = Uuid();


Future<void> saveCitiesToFireStore() async{
  final CollectionReference ref = FirebaseFirestore.instance.collection('Cities');
  for (final FavoriteCityModel cities in listOfFavoriteCities) {
    // final String id = uuid.v4();
    // print(id);
    try{
      await ref.doc(cities.cityId).set(cities.toMap());
    }catch(e){
      print('Error while saving cities $e');
  }
  }
 

}

class FavoriteCityModel{
  final String favoriteId;
  final String cityId;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  FavoriteCityModel({
    required this.favoriteId,
    required this.cityId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt
  });

  Map<String, dynamic> toMap(){
    return{
      'favoriteId': favoriteId,
      'cityId': cityId,
      'userId': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }

  factory FavoriteCityModel.fromMap(Map<String, dynamic> map){
    return FavoriteCityModel(
      favoriteId: map['favoriteId'] ?? '',
      cityId: map['cityId'] ?? '',
      userId: map['userId'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate()
    );
  }

}

final List<FavoriteCityModel> listOfFavoriteCities = [
  FavoriteCityModel(
    favoriteId: uuid.v4(),
    cityId:'',
    userId: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now()
    )
];