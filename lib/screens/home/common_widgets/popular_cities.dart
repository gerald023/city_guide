import 'package:city_guide/models/cities.dart';
import 'package:city_guide/screens/home/common_widgets/special_offer.dart';
import 'package:city_guide/screens/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:city_guide/provider/firebase_provider.dart';
import 'package:city_guide/screens/explore/widgets/city_info_medium_card.dart';

class PopularProducts extends ConsumerStatefulWidget {
  const PopularProducts({super.key});

  @override
  ConsumerState<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends ConsumerState<PopularProducts> {
  List<CitiesModel> cities = [];
   Map<String, dynamic> userData = {};
  bool _isLoading = true;

   @override
  void initState() {
    super.initState();
    fetchCities();
    fetchUserDetails();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: Text(
             "Popular Cities",
           style: TextStyle(
            fontSize: 18,
          fontWeight: FontWeight.bold,
           )
          ),
        ),
        const SizedBox(height: 20),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                cities.length,
                (index) {
                  if (cities[index].isPopular?? false) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      // child: CityCard(
                      //   city: cities[index],
                      //   onPress: () {},
                      // ),
                      child: CityInfoMediumCard(
                        delivertTime: 3,
                        name: cities[index].cityName,
                        location: cities[index].country,
                        image: cities[index].images[2],
                        rating: cities[index].rating + 0.0,
                        press: (){

                        }
                      ),
                    );
                  }

                  return const SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
        )
      ],
    );
  }
}