class AttractionListModel{
  final String attractionListId;
  final String cityId;
  final List <String> attractions;

  AttractionListModel({
    required this.attractionListId,
    required this.cityId,
    required this.attractions
  });

  Map<String, dynamic> toMap(){
    return {
      'attractionListId': attractionListId,
      'cityId': cityId,
      'attractions': attractions
    };
  }

  factory AttractionListModel.fromMap(Map<String, dynamic> map){
    return AttractionListModel(
      attractionListId: map['attractionListId'] ?? '', 
      cityId: map['cityId'] ?? '', 
      attractions: List<String>.from(map['attractions']) ?? []
    );
  }
}