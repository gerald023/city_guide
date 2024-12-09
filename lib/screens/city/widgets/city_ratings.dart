import 'package:city_guide/components/custom_button.dart';
import 'package:city_guide/constants/color_constant.dart';
import 'package:flutter/material.dart';

class CityRatings extends StatefulWidget {
  const CityRatings({super.key});

  @override
  State<CityRatings> createState() => _CityRatingsState();
}

class _CityRatingsState extends State<CityRatings> {
    final _formKey = GlobalKey<FormState>();
  int rating = 0;
  TextEditingController _ratingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Add a review',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: Colors.black
        ),
        ),
        const Text('Enjoyed a spectacular view at Venice, Rome? Share your experience',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: Color.fromARGB(255, 131, 131, 131)
        ),
        ),
        const SizedBox(height: 20,),
        Row(
          children: List.generate( 5, 
          (index) {
            return IconButton(
              onPressed: (){
                setState(() {
                  rating = index + 1;
                });
              }, 
              icon: Icon(
                index < rating ? Icons.star_rounded : Icons.star_border_rounded,
                color:  const Color.fromARGB(255, 255, 191, 0),
                size: 36,
              )
            );
          }
          ),
        ),
        Text('you selected $rating star${rating != 1 ? 's' : ''}'),
        const SizedBox(height: 20,),
        Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 126, 126, 126),
                width: 1
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child:  Row(
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Expanded(
              child:  TextFormField(
            autocorrect: true,
            controller: _ratingController,
            validator: (value){
              if (value == null) {
                return 'Please enter your thought';
              }else if(value.length <= 4){
                return 'your thought should be more than 4 characters';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Share your thought',
              hintStyle:  TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color:  Color.fromARGB(255, 116, 116, 116)
              ),
                
              fillColor: Colors.grey,
              contentPadding: EdgeInsets.all(12),
              
            ),
          ),
             ),
           Material(
            color: Colors.green,
            borderRadius: BorderRadius.circular(60),
            child: InkWell(
              onTap: () {
                      if (_formKey.currentState?.validate() == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Form Submitted')),
                        );
                      }
                    },
               borderRadius: BorderRadius.circular(10),
               child: const Padding(
                      padding:  EdgeInsets.all(9.0),
                      child: Icon(
                        Icons.double_arrow_rounded, 
                        size: 30,
                        color: Colors.white, 
                      ),
               )
            ),
           )
            ],
          ),
          )
          
        ),
        const SizedBox(height: 40,),
        const Text('All reviews:',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold
        ),
        ),
        const SizedBox(height: 20,),
         reviewList(),
         reviewList(),
         reviewList(),
         reviewList(),
         reviewList(),
      ],
    )
    );
  }

  Row reviewList() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           const CircleAvatar(
            backgroundImage:  NetworkImage('https://i.postimg.cc/8PPwJrTn/istockphoto-913722282-612x612.jpg'),
            radius: 20,
          ),
          const SizedBox(width: 30,),
         Expanded(
          child:  Column(
            mainAxisSize: MainAxisSize.min, 
            
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Gerald Lekara',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  const SizedBox(width: 40,),
                  Row(
                    children: List.generate(5, (index){
                      return  Icon(
              index < rating ? Icons.star_rounded : Icons.star_border_rounded,
              color:  const Color.fromARGB(255, 255, 191, 0),
              size: 16,
            );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 7,),
               const Text('We had the most spectacular view. Unfortunately it was very hot in the room from 2-830 pm due to no air conditioning and no shade.',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 58, 58, 58),
                fontWeight: FontWeight.w200,
                overflow: TextOverflow.clip
              ),
              ),
            ],
          )
        ),
        const SizedBox(height: 110,)
        ],
      );
  }
}