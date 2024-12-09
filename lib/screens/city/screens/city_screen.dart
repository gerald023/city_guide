import 'package:city_guide/constants/color_constant.dart';
import 'package:city_guide/screens/city/widgets/city_image_carousel.dart';
import 'package:city_guide/screens/city/widgets/similar_cities_widget.dart';
import 'package:city_guide/services/city_guide_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:city_guide/models/cities.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/city_attraction_list.dart';
import '../widgets/city_header_info.dart';
import '../widgets/city_ratings.dart';



class CityScreen extends StatefulWidget {
   CityScreen({super.key,  this.cityId});

  String? cityId;


  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
    CitiesModel? cityData;
    String? cityIdFromPreferences;
    final ScrollController _scrollController = ScrollController();

    void scrollToSection(double position) {
        _scrollController.animateTo(
          position,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
    }

    Future<void> getCityIdFromPreferences() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      cityIdFromPreferences = prefs.getString('cityId') ?? '';
    });

  }
  
  


  Future<void> getCity(cityId) async{
    try{
      final data = await CityGuideServices().getCity(cityId ?? cityIdFromPreferences!);
      setState(() {
        // cityData = CitiesModel.fromMap(data as Map<String, dynamic>);
        cityData = data;
      });
    }catch(e){
      print('this error ocurred $e');
    }
  }
  
  // causes the getCity method to wait for the first method to set the state of cityId
   Future<void> loadCityData() async {
    await getCityIdFromPreferences();
    await getCity(widget.cityId); // Ensure this is called after the ID is fetched
  }

  @override
  void initState() {
    super.initState();
    // Call the loadCityData method when the widget is initialized
    loadCityData();
  }


  @override
  Widget build(BuildContext context) {
    if (cityData == null) {
      
    }
    return  Scaffold(
      appBar: AppBar(
        title: const Text('City details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Get.back();
          },
        ),
        backgroundColor: Colors.grey.shade200,
      ),
      body: cityData == null ?
      const Center(child: CircularProgressIndicator())
      :
      SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CityHeaderInfo(
              cityName: cityData!.cityName,
              rating: cityData!.rating,
              country: cityData!.country,
              scrollAction: (){
                scrollToSection(500);
              }
            ),
            const SizedBox(height: 45,),
            CityImageCarousel(images: cityData!.images),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                 border: Border.all(
                  width:1, 
                  color: Colors.grey.shade200,
                 )
              ),
              child: const  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Overview',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,

                  ),
                  ),
                   SizedBox(height: 12,),
                    Text('The secret journey of Tonkin is designed for travelers who want to touch, taste and feel the souls of Northern Vietnam through their unique highlights and experiences. More than simple whirlwind tours, the secret journey of Tonkin of Tonkin marry iconic destinations and must-see spots with the hidden corners and below-the-skin experiences to discover some of the famous and unique places around the Halong region.',
                   style: TextStyle(
                    fontWeight: FontWeight.w500
                   ),
                   ),
                   SizedBox(height: 22,),
                 
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text('*Attractions and Services',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
           const  CityAttractionList(),

           const SizedBox(height: 20),
           SimilarCitiesWidget(),
           const SizedBox(height: 30,),
           const CityRatings()
          ],
        ),
        ),
        
      ),
    );
  }
}