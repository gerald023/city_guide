import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CityAttractionList extends StatelessWidget {
  const CityAttractionList({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(10, 13, 10, 30),
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              print('touched me');
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(17, 6, 15, 7),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200,
                    width: 2,
                  )
                 )
              ),
              child:  const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Iconsax.hospital,
                size: 20,
                color: Colors.grey,
                ),
                SizedBox(width: 20),
                Text('Hospitals',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                ),
              ],
            ),
            )
          ),
          const SizedBox(height: 20,),
          
            
            GestureDetector(
            onTap: (){
              print('touched me');
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(17, 6, 15, 7),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200,
                    width: 2,
                  )
                 )
              ),
              child:  const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Iconsax.shop,
                size: 20,
                color: Colors.grey,
                ),
                SizedBox(width: 20),
                Text('Restuarants',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                ),
              ],
            ),
            )
          ),

          
        ],
      ),
      );
  }
}