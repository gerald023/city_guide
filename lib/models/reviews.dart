import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';


const uuid = Uuid();

class ReviewModel{
  final String reviewId;
  final String userId;
  final String cityId;
  final String message;
  final int  rating;
  final bool show;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReviewModel({
    required this.reviewId,
    required this.userId,
    required this.cityId,
    required this.message,
    required this.rating,
    required this.show,
     required this.createdAt,
    required this.updatedAt
  });

  Map<String, dynamic> toMap(){
    return {
      'reviewId': reviewId,
      'userId': userId,
      'cityId': cityId,
      'message': message,
      'rating': rating,
      'show': show,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt)
    };
  }


  factory ReviewModel.fromMap(Map<String, dynamic> map){
    return ReviewModel(
      reviewId: map['reviewId'] ?? '', 
      userId: map['userId'] ?? '', 
      cityId: map['cityId'] ?? '', 
      message: map['message'] ?? '', 
      rating: map['rating'] ?? 0,
      show: map['show'] ?? false,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      );
  }
}



final List<ReviewModel> listOfReview = [
  ReviewModel(
    reviewId: uuid.v4(), 
    userId: 'pCBtv2udgDXcR5kqq2lBNJhd1Kz2', 
    cityId: '0f0dd2c2-d424-4a45-be62-65bccf041e8d', 
    message: 'the best place to be in the world. was a enjoyable trip we had here.', 
    rating: 5, 
    show: true, 
    createdAt: DateTime.now(), 
    updatedAt: DateTime.now()
    ),
   ReviewModel(
    reviewId: uuid.v4(), 
    userId: 'pCBtv2udgDXcR5kqq2lBNJhd1Kz2', 
    cityId: '0f0dd2c2-d424-4a45-be62-65bccf041e8d', 
    message: 'London is the best place in the world. was a enjoyable trip we had here.', 
    rating: 5, 
    show: true, 
    createdAt: DateTime.now(), 
    updatedAt: DateTime.now()
    ),
     ReviewModel(
    reviewId: uuid.v4(), 
    userId: 'pCBtv2udgDXcR5kqq2lBNJhd1Kz2', 
    cityId: '9aedea29-acdf-48a8-8e1c-9de758975bdf', 
    message: 'Want to enjoy the best place in the Arab world, Dubai is the place to be.', 
    rating: 5, 
    show: true, 
    createdAt: DateTime.now(), 
    updatedAt: DateTime.now()
    ),
];


Future<void> saveReviewsToFirestore() async{
  final CollectionReference ref = FirebaseFirestore.instance.collection('Reviews');

  for(final ReviewModel review in listOfReview){
    try{
      await ref.doc(review.cityId).set(review.toMap());
    }catch(e){
      print('Error while saving cities $e');
    }
  }
}
