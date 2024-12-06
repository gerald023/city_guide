import 'package:city_guide/models/cities.dart';
import 'package:city_guide/screens/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:city_guide/provider/firebase_provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:city_guide/screens/city/screens/city_screen.dart';

class AllCities extends ConsumerStatefulWidget {
  const AllCities({super.key});

  @override
  ConsumerState<AllCities> createState() => _AllCitiesState();
}

class _AllCitiesState extends ConsumerState<AllCities> {
  List<CitiesModel> cities = [];
   Map<String, dynamic> userData = {};
  bool _isLoading = true;

   @override
  void initState() {
    super.initState();
    fetchCities();
    fetchUserDetails();
  }
  Future<void> _saveCityIdToPreference(cityId) async{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cityId', cityId);
  }
  Future<void> fetchCities() async{
    final firebaseService = ref.read(firebaseServiceProvider);
    setState(() => _isLoading = true);

    try{
      List<CitiesModel> fetchedCities = await firebaseService.getAllCities();
       print('Fetched cities: $fetchedCities');
      setState(() {
        cities = fetchedCities;
        _isLoading = false;
        print('Cities state updated: $cities');
      });
      print(cities);
      print(fetchedCities);
    }catch(e){
      print('Error while fetching cities $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> fetchUserDetails() async{

  }

  @override
  Widget build(BuildContext context) {
      if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (cities.isEmpty) {
      return const Center(child: Text('No popular cities found.'));
    }
    return SingleChildScrollView(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: Text(
               "All Cities",
             style: TextStyle(
              fontSize: 18,
            fontWeight: FontWeight.bold,
             )
            ),
          ),
          const SizedBox(height: 20),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     child: GridView.builder(
          //        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2, // Number of columns in the grid
          //       crossAxisSpacing: 10, // Spacing between columns
          //       mainAxisSpacing: 10, // Spacing between rows
          //       childAspectRatio: 3 / 4, // Aspect ratio for each grid item
          //     ),
          //     itemCount: cities.length,
          //     itemBuilder:(context, index){
          //       return CityCard(
          //           city: cities[index],
          //         onPress: () {},
          //       );
          //     }
          //     ),
          //   ),
          // ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: cities.map((city) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 30,
                child: CityCard(
                  city: city,
                  onPress: (){
                    _saveCityIdToPreference(city.cityId);
                    Get.to(
                      CityScreen(cityId: city.cityId,)
                    );
                  },
                ),
              );
            }).toList(),
          )
            // Column(
            //   children: [
            //     ...List.generate(
            //       cities.length,
            //       (index) {
            //           return Padding(
            //             padding: const EdgeInsets.only(left: 20),
            //             child: CityCard(
            //               city: cities[index],
            //               onPress: () {},
            //             ),
                        
            //           );
            //       },
            //     ),
            //     const SizedBox(width: 20),
            //   ],
            // ),
          
        ],
      ),
    );
  }
}