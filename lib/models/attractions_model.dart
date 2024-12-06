import 'package:cloud_firestore/cloud_firestore.dart';

class AttractionsModel{
  final String attractionId;
  final String attractionListId;
  final String name;
  final String logo;
  final List<String> images;
  final String description;
  final int rating;
  final String location;
  final DateTime openingTime;
  final DateTime? closingTime;
  final DateTime createdAt;
  final DateTime updatedAt;


  AttractionsModel({
    required this.attractionId,
    required this.attractionListId,
    required this.name,
    required this.logo,
    required this.description,
    required this.images,
    required this.location,
    required this.openingTime,
    this.closingTime,
    required this.rating,
    required this.createdAt,
    required this.updatedAt
  });


  Map<String, dynamic> toMap(){
    return {
      'attractionId': attractionId,
      'attractionListId': attractionListId,
      'name': name,
      'logo': logo,
      'images': images,
      'rating': rating,
      'description': description,
      'location': location,
      'closingTime': closingTime,
      'openingTime': openingTime,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }


  factory AttractionsModel.fromMap(Map<String, dynamic> map){
    return AttractionsModel(
      attractionId: map['attractionId'] ?? '', 
      attractionListId: map['attractionListId'] ?? '', 
      name: map['name'] ?? '', 
      logo: map['logo'] ?? '', 
      description: map['description'] ?? '', 
      images: List<String>.from(map['images'] ?? []), 
      location: map['location'] ?? '', 
      openingTime: (map['openingTIme'] as Timestamp).toDate(),
      closingTime: (map['openingTIme'] as Timestamp).toDate(), 
      rating: map['rating'] ?? 0, 
      createdAt: (map['openingTIme'] as Timestamp).toDate(),
      updatedAt: (map['openingTIme'] as Timestamp).toDate()
      );
  }
}