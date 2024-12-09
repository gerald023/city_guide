import 'package:cloud_firestore/cloud_firestore.dart';

class AttractionsModel{
  final String attractionId;
  final String category;
  final String name;
  final String cityId;
  final double lng;
  final double lat;
  final List<String> images;
  final String description;
  final int rating;
  final DateTime createdAt;
  final DateTime updatedAt;


  AttractionsModel({
    required this.attractionId,
    required this.category,
    required this.name,
    required this.cityId,
    required this.lng,
    required this.lat,
    required this.description,
    required this.images,
    required this.rating,
    required this.createdAt,
    required this.updatedAt
  });


  Map<String, dynamic> toMap(){
    return {
      'attractionId': attractionId,
      'category': category,
      'name': name,
      'cityId': cityId,
      'longitude': lng,
      'latitude': lat,
      'images': images,
      'rating': rating,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }


  factory AttractionsModel.fromMap(Map<String, dynamic> map){
    return AttractionsModel(
      attractionId: map['attractionId'] ?? '', 
      category: map['category'] ?? '', 
      name: map['name'] ?? '', 
      cityId: map['cityId'] ?? '', 
      lng: map['longitude'] ?? 0.0,
      lat: map['latitude'] ?? 0.0,
      description: map['description'] ?? '', 
      images: List<String>.from(map['images'] ?? []), 
      rating: map['rating'] ?? 0, 
      createdAt: (map['openingTIme'] as Timestamp).toDate(),
      updatedAt: (map['openingTIme'] as Timestamp).toDate()
      );
  }
}