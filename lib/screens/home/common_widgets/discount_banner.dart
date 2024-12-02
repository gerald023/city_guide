import 'package:flutter/material.dart';


class DiscountBanner extends StatelessWidget {
   const DiscountBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      // padding: const EdgeInsets.symmetric(
      //   horizontal: 20,
      //   vertical: 16,
      // ),
      decoration: BoxDecoration(
        // color: const Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
      padding: const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: (){},
        child: SizedBox(
          width: double.infinity,
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), 
            child: Stack(
              children: [
                Image.network(
                  'https://i.postimg.cc/Vv86SqPJ/images.jpg',
                  width: double.infinity,
                  height: 150,
              fit: BoxFit.cover,
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
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child:  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        
                      ),
                      children: [
                        TextSpan(
                          text: "Christmas Offers \n",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "\n 45% off citys",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        )
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
    );
  }
}