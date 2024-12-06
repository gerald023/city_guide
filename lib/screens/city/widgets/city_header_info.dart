import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CityHeaderInfo extends StatelessWidget {
  final String cityName;
  final int rating;
  final String country;
  final VoidCallback scrollAction;
  const CityHeaderInfo({
    super.key,
    required this.cityName,
    required this. rating,
    required this.country,
    required this.scrollAction
  });

  @override
  Widget build(BuildContext context) {
    return   Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(cityName,
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                )
                ),
                const SizedBox(height: 23,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Row(
                       children: [
                         const Icon(Icons.star_rounded,
                         color: Colors.black,
                         // weight: 3,
                         size: 20,
                       ),
                       Text(' ${ rating}',
                       style:const  TextStyle(
                         fontSize: 13,
                         fontWeight: FontWeight.bold,
                       ),
                       )
                       ]
                     ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        const Icon(Iconsax.flag,
                        size: 17,
                        color: Colors.grey,
                        weight: 600,
                        ),
                        Text(' ${country}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                        )
                      ]
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: scrollAction,//()=> scrollToSection(500),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1
                          )
                        ),
                        child: const Center(
                          child: Icon(Icons.details_rounded,
                          size: 20,
                          color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1
                          )
                        ),
                        child: const Center(
                          child: Icon(Icons.link,
                          size: 20,
                          color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1
                          )
                        ),
                        child: const Center(
                          child: Icon(Icons.favorite_outline,
                          size: 20,
                          color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ]
            );
  }
}