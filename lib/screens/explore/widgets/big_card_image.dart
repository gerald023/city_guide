import 'package:flutter/material.dart';

class BigCardImage extends StatelessWidget {
  const BigCardImage({
    super.key,
    required this.image,
     this.cityName,
     this.visits
  });

  final String image;
  final String? cityName;
  final String? visits;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: (){
          print('$cityName was clicked');
        },
        child: SizedBox(
          width: double.infinity,
          height: 300,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  image,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  width: double.infinity,
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.transparent,
                      ]
                      )
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: ' $cityName \n \n',
                          style:const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 2,
                            backgroundColor: Color.fromARGB(73, 0, 0, 0)
                          )
                        ),
                        TextSpan(
                          text: '$visits annual visits',
                          style: const TextStyle(
                            height: 2,
                            backgroundColor: Color.fromARGB(73, 0, 0, 0)
                          )
                        )
                      ]
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      );
  }
}