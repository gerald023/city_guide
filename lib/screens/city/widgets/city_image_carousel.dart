import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class CityImageCarousel extends StatelessWidget {
  final List<String> images;
  CityImageCarousel({super.key, required this.images});

  CarouselSliderController buttonCarouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        CarouselSlider(
          carouselController: buttonCarouselController,
          items: images.map((i){
            return(
              Image.network(images[images.indexOf(i)],
              fit: BoxFit.cover,
              width: double.maxFinite,
              )
            );
          }).toList(),
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