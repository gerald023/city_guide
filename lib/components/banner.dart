import 'package:city_guide/constants/color_constant.dart';
import 'package:flutter/material.dart';

class BannerToExplore extends StatelessWidget {
  const BannerToExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kBannerColor
      ),
      child: Stack(
        children: [
          Positioned(
            top: 32,
            left: 20,
            child: Column(
            children: [
              const Text('Travel to the best \n cities in the World',
              style: TextStyle(
                height: 1.1,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 33
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0
                ),
                onPressed: (){}, 
              child: const Text('Explore',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
              )
              ),
            ],
          )
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: -20,
              child: Image.network(
                'https://images.pexels.com/photos/9909207/pexels-photo-9909207.jpeg?auto=compress&cs=tinysrgb&w=600',
                scale: 0.4,
              )
              )
        ],
      ),
    );
  }
}