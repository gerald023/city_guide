// import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


const uuid = Uuid();
Future<void> saveCitiesToFireStore() async{
  final CollectionReference ref = FirebaseFirestore.instance.collection('Cities');
  for (final CitiesModel cities in listOfCities) {
    // final String id = uuid.v4();
    // print(id);
    try{
      await ref.doc(cities.cityId).set(cities.toMap());
    }catch(e){
      print('Error while saving cities $e');
  }
  }
 

}

class CitiesModel{
  final String cityId;
  final String cityName;
  final List<String> images;
  final String category;
  final String country;
  final int rating;
  final bool isPopular;
  final DateTime createdAt;
  final DateTime updatedAt;

  CitiesModel({
    required this.cityId,
    required this.cityName,
    required this.images,
    required this.category,
    required this.country,
    required this.rating,
    required this.isPopular,
    required this.createdAt,
    required this.updatedAt
  });

   @override
  String toString() {
    return 'CitiesModel( cityId: $cityId, cityName: $cityName, isPopular: $isPopular, images: $images, category: $category, country: $country, rating: $rating, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  Map<String, dynamic> toMap(){
    return{
      'cityId': cityId,
      'cityName': cityName,
      'images': images,
      'category': category,
      'country': country,
      'rating': rating,
      'isPopular': isPopular,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt)
    };
  }

  factory CitiesModel.fromMap(Map<String, dynamic> map){
    print('Mapping data: $map'); 
    return CitiesModel(
      cityId: map['cityId'] ?? '',
      cityName: map['cityName'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      category: map['category'] ?? '',
      country: map['country'] ?? '',
      rating: map['rating'] ?? '',
      isPopular: map['isPopular'] ?? false,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }
}


final List<CitiesModel> listOfCities = [
  CitiesModel(
    cityId: uuid.v4(),
    cityName: 'Dubai', 
    images: [
      'https://i.postimg.cc/7L56DFBY/free-photo-of-museum-of-the-future-in-dubai-skyline.jpg',
      'https://i.postimg.cc/qMQMKJSv/pexels-photo-1470405.jpg',
      'https://i.postimg.cc/jSzcc162/pexels-photo-1707310.jpg',
      'https://i.postimg.cc/CKh2qYyS/istockphoto-527899020-612x612.webp',
      'https://i.postimg.cc/Y9jyd3qP/photo-1650728768250-29d1061bf84b.avif',
      'https://i.postimg.cc/L4c0Vjdy/photo-1518684079-3c830dcef090.avif',
      'https://i.postimg.cc/c4cM83dt/photo-1528702748617-c64d49f918af.avif'
    ], 
    category: 'cd217dfb-3b77-46a2-a8d0-08b05b6ee948', 
    country: 'United Arab Emirates', 
    rating: 4,
    isPopular: true,
    createdAt: DateTime.now(), 
    updatedAt: DateTime.now()
    ),
    CitiesModel(
      cityId: uuid.v4(),
    cityName: 'London', 
    images: [
      'https://i.postimg.cc/9M78ZffR/pexels-photo-77171.jpg',
      'https://i.postimg.cc/vZZ0XhBd/photo-1669543295816-9a12a6fd3513.avif',
      'https://i.postimg.cc/QdY0z79K/pexels-photo-460672.webp',
      'https://i.postimg.cc/wx5FpZRp/pexels-photo-1427581.jpg',
      'https://i.postimg.cc/159B5BDN/photo-1582581388879-65cdb825ec67.avif',
      'https://i.postimg.cc/cHyMqBsC/download.jpg',
      'https://i.postimg.cc/Gh5DwxKR/pexels-photo-10864070.jpg'
    ], 
    category: 'cd217dfb-3b77-46a2-a8d0-08b05b6ee948', 
    country: 'England', 
    rating: 5,
    isPopular: true,
    createdAt: DateTime.now(), 
    updatedAt: DateTime.now()
    ),
  CitiesModel(
    cityId: uuid.v4(),
    cityName: 'Dubai', 
    images: [
      'https://i.postimg.cc/7L56DFBY/free-photo-of-museum-of-the-future-in-dubai-skyline.jpg',
      'https://i.postimg.cc/qMQMKJSv/pexels-photo-1470405.jpg',
      'https://i.postimg.cc/jSzcc162/pexels-photo-1707310.jpg',
      'https://i.postimg.cc/CKh2qYyS/istockphoto-527899020-612x612.webp',
      'https://i.postimg.cc/Y9jyd3qP/photo-1650728768250-29d1061bf84b.avif',
      'https://i.postimg.cc/L4c0Vjdy/photo-1518684079-3c830dcef090.avif',
      'https://i.postimg.cc/c4cM83dt/photo-1528702748617-c64d49f918af.avif'
    ], 
    category: 'ed57fe3b-67fc-4c8b-9600-2874fa209b55', 
    country: 'United Arab Emirates', 
    rating: 4,
    isPopular: false,
    createdAt: DateTime.now(), 
    updatedAt: DateTime.now()
    ),
    CitiesModel(
    cityId: uuid.v4(),
    cityName: 'Abuja', 
    images: [
      'https://i.postimg.cc/SRgVsm5P/download.jpg',
      'https://i.postimg.cc/C5rH0mnT/download.jpg',
      'https://i.postimg.cc/8z6B8d19/download.jpg',
      'https://i.postimg.cc/vDRT5Vpx/images.jpg',
      'https://i.postimg.cc/0NHwbb2D/images.jpg',
      'https://i.postimg.cc/05Swy5gK/images.jpg',
      'https://i.postimg.cc/Y9Wh0RPB/images.jpg'
    ], 
    category: '8c3ff60e-da1d-4243-bfb1-5933b6c6110b', 
    country: 'Nigeria', 
    rating: 4,
    isPopular: false,
    createdAt: DateTime.now(), 
    updatedAt: DateTime.now()
    ),
    CitiesModel(
    cityId: uuid.v4(),
    cityName: 'Abuja', 
    images: [
      'https://i.postimg.cc/SRgVsm5P/download.jpg',
      'https://i.postimg.cc/C5rH0mnT/download.jpg',
      'https://i.postimg.cc/8z6B8d19/download.jpg',
      'https://i.postimg.cc/vDRT5Vpx/images.jpg',
      'https://i.postimg.cc/0NHwbb2D/images.jpg',
      'https://i.postimg.cc/05Swy5gK/images.jpg',
      'https://i.postimg.cc/Y9Wh0RPB/images.jpg'
    ], 
    category: 'ed57fe3b-67fc-4c8b-9600-2874fa209b55', 
    country: 'Nigeria', 
    rating: 4,
    isPopular: false,
    createdAt: DateTime.now(), 
    updatedAt: DateTime.now()
    ),
    CitiesModel(
    cityId: uuid.v4(),
    cityName: 'Venice', 
    images: [
      'https://i.postimg.cc/kGGYWVxC/istockphoto-479824818-612x612.jpg',
      'https://i.postimg.cc/bYVBpThw/pexels-photo-879537.jpg',
      'https://i.postimg.cc/9F4NM7mt/istockphoto-1176439818-612x612.jpg',
      'https://i.postimg.cc/9FvgqQz3/pexels-photo-2748019.jpg',
      'https://i.postimg.cc/QMqfPgms/istockphoto-491391396-612x612.jpg',
      'https://i.postimg.cc/8PPwJrTn/istockphoto-913722282-612x612.jpg',
      'https://i.postimg.cc/0jZfX90f/istockphoto-903175876-612x612.jpg'
    ], 
    category: 'ed57fe3b-67fc-4c8b-9600-2874fa209b55',
    country: 'Italy',
    rating: 4,
    isPopular: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now()
    ),
];