import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
Future<void> saveCategoryItem() async{
  final CollectionReference ref = FirebaseFirestore.instance.collection('AppCategory');
  
  for (final CategoryModel category in listOfCategory ) {
    // final String id = 
    // DateTime.now().toIso8601String() + Random().nextInt(1000).toString();
    // ref.doc('das');
    try{
      await ref.doc(category.categoryId).set(category.toMap());
    }catch(e){
      print('Error saving category $e');
    }
    

  }
}


class CategoryModel{
  final String categoryId;
  final String title;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryModel({
    required this.categoryId,
    required this.title,
    required this.image,
    required this.createdAt,
    required this.updatedAt
  });

  Map<String, dynamic> toMap(){
  return {
    'categoryId': categoryId,
    'title': title,
    'image': image,
    'createdAt': Timestamp.fromDate(createdAt),
    'updatedAt': Timestamp.fromDate(updatedAt)
  };
}

factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId'] ?? '',
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
}


}

final List<CategoryModel> listOfCategory = [
  CategoryModel(
    categoryId: uuid.v4(),
    title: 'Vacation', 
    image: 'https://images.pexels.com/photos/460740/pexels-photo-460740.jpeg?auto=compress&cs=tinysrgb&w=600', 
    createdAt: DateTime.now(), 
    updatedAt: DateTime.now()
    ),
     CategoryModel(
      categoryId: uuid.v4(),
    title: 'Business', 
    image: 'https://images.pexels.com/photos/14468094/pexels-photo-14468094.jpeg?auto=compress&cs=tinysrgb&w=600', 
    createdAt: DateTime.now(), 
    updatedAt: DateTime.now()
    ),
     CategoryModel(
      categoryId: uuid.v4(),
    title: 'Adventure', 
    image: 'https://images.pexels.com/photos/3889919/pexels-photo-3889919.jpeg?auto=compress&cs=tinysrgb&w=600', 
    createdAt: DateTime.now(), 
    updatedAt: DateTime.now()
    ),
     CategoryModel(
      categoryId: uuid.v4(),
    title: 'Holiday', 
    image: 'https://images.pexels.com/photos/3811073/pexels-photo-3811073.jpeg?auto=compress&cs=tinysrgb&w=600', 
    createdAt: DateTime.now(), 
    updatedAt: DateTime.now()
    ),
];


