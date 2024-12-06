import 'package:carousel_slider/carousel_slider.dart';
import 'package:city_guide/screens/explore/widgets/city_info_card.dart';
import 'package:flutter/material.dart';

class SimilarCitiesWidget extends StatelessWidget {
   SimilarCitiesWidget({super.key});


  CarouselSliderController buttonCarouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          carouselController: buttonCarouselController,
          items: [
            ...List.generate(5, 
            (index) => Container(
              padding: const EdgeInsets.all(20),
              height: 700,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  children: [
                    Image.network('https://i.postimg.cc/hjG2Nt4v/pexels-photo-2376712.jpg',
                    width: double.maxFinite,
                    height: 130,
                    semanticLabel: 'city image',
                    fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20,),
                        Row(
                          
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Abuja',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black26,
                            ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)
                            ),
                            child: Icon(Icons.favorite,
                            size: 20,
                            color: Colors.red.shade100,
                            ),
                            )
                          ],
                        ),
                        const SizedBox(height: 12,),
                        const Text('Nigeria')
                    
                  ],
                ),
              ),
            
          )
          ], 
          options: CarouselOptions(
            height: 200,
            pauseAutoPlayOnTouch: true,
            padEnds: true,
            pageSnapping: true,
            aspectRatio: 16/9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal
          ),
          ),
           const SizedBox(height: 40,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
          onTap: ()=> buttonCarouselController.previousPage(
            duration: const Duration(milliseconds: 300), curve: Curves.linear
          ),
          child: const Icon(Icons.arrow_back_ios_new,
          size: 20,)
        ),
        const SizedBox(width: 60,),
        GestureDetector(
          onTap: ()=> buttonCarouselController.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.linear
          ),
          child: const Icon(Icons.arrow_forward_ios_outlined,
          size: 20,)
        )
          ],
        )
      ],
    );
  }
}