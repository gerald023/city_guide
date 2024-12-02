import 'package:flutter/material.dart';

class SearchBarFilter extends StatelessWidget {
  const SearchBarFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 7
                  )
                ]
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 20
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text('Where to?',
                      // style: TextStyle(
                      //   fontSize: 13,
                      //   fontWeight: FontWeight.bold
                      // ),
                      // ),
                      SizedBox(height: 15,
                      width: 360,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none
                          ),
                          hintText: 'Anywhere, Any week, Any day',
                          hintStyle: TextStyle(
                            color: Colors.black38,
                            fontSize: 10,
                            fontWeight: FontWeight.bold
                          ),
                          filled: true,
                          fillColor: Colors.white
                        ),
                      ),
                      ),
                    ],
                  )

                ],
                )
                ,
              ),
          )
          ),
          const SizedBox(
            width: 8,
          ),
          // Container(
          //   padding: const EdgeInsets.all(10),
          //   decoration: BoxDecoration(
          //     border: Border.all(
          //       color: Colors.black54
          //     ),
          //     shape: BoxShape.circle
          //   ),
          //   child: const Icon(Icons.tune, size: 20,),
          // )
        ]
      ),
    );
  }
}