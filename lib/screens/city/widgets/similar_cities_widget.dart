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
        const Text('Related Cities',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
        const SizedBox( height: 30,),
        CarouselSlider(
          carouselController: buttonCarouselController,
          items: [
            ...List.generate(5, 
            (index) => Container(
              padding: const EdgeInsets.all(12),
              // height: 700,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  // border: Border.all(
                  //   width: 2,
                  //   // color: Colors.red,
                  // ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network('https://i.postimg.cc/hjG2Nt4v/pexels-photo-2376712.jpg',
                    width: double.maxFinite,
                    height: 110,
                    fit: BoxFit.fitWidth,

                    ),
                    // const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text('Abuja $index',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(66, 2, 2, 2),
                            ),
                            ),
                            const Text('@Nigeria',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                            ),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey.shade300
                              ),
                              child: const Icon(Icons.favorite,
                            size: 15,
                            color: Colors.white,
                            ),
                            )
                          ],
                        ),
                        // const SizedBox(height: 12,),
                        
                          ],
                        ),
                      )
                  ],
                ),
              ),
            
          )
          ], 
          options: CarouselOptions(
            height: 217,
            pauseAutoPlayOnTouch: true,
            padEnds: true,
            pageSnapping: true,
            aspectRatio: 16/4,
            viewportFraction: 0.6,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal
          ),
          ),
           const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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