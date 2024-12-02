import 'package:city_guide/screens/home/data/home_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
   final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('AppCategory');
      int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //  List<Map<String, dynamic>> categories = [
    //   {"icon": flashIcon, "text": "Flash Deal"},
    //   {"icon": billIcon, "text": "Bill"},
    //   {"icon": gameIcon, "text": "Game"},
    //   {"icon": giftIcon, "text": "Daily Gift"},
    //   {"icon": discoverIcon, "text": "More"},
    // ];
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('PLAN YOUR TRIP',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10
            ),
          ),
          const Text('Where to next?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          listOfCategoryItem(size)
        ],
      )
    );
  }

   StreamBuilder<QuerySnapshot<Object?>> listOfCategoryItem(Size size) {
    return StreamBuilder(
        stream: categoryCollection.snapshots(),
        builder: (context, streamSnapshot) {
          if (streamSnapshot.hasData) {
            return Stack(
              children: [
                const Positioned(
                    left: 0,
                    right: 0,
                    top: 80,
                    child: Divider(
                      color: Colors.black12,
                    )),
                SizedBox(
                  height: size.height * 0.15,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: streamSnapshot.data!.docs.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 20, right: 20, left: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 32,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: Image.network(
                                    streamSnapshot.data!.docs[index]['image'],
                                    color: selectedIndex == index
                                        ? Colors.black
                                        : Colors.black45,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  streamSnapshot.data!.docs[index]['title'],
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: selectedIndex == index
                                        ? Colors.black
                                        : Colors.black45,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 3,
                                  width: 50,
                                  color: selectedIndex == index
                                      ? Colors.black
                                      : Colors.transparent,
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            );
          }
          return Container(
            child: const CircularProgressIndicator(),
          );
        });
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFFECDF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.string(icon),
          ),
          const SizedBox(height: 4),
          Text(text, textAlign: TextAlign.center)
        ],
      ),
    );

  }

  
  
}