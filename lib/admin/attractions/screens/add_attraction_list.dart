import 'package:city_guide/components/custom_button.dart';
import 'package:city_guide/components/textField_widget.dart';
import 'package:city_guide/services/attraction_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:bottom_picker/resources/arrays.dart';


class AddAttractionList extends StatefulWidget {
  // String cityId;
  AddAttractionList({
    super.key,
  // required this.cityId
  });

  @override
  State<AddAttractionList> createState() => _AddAttractionListState();
}

class _AddAttractionListState extends State<AddAttractionList> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController openingTIme = TextEditingController();
  TextEditingController closingTime = TextEditingController();
  TextEditingController rating = TextEditingController();
  TextEditingController images = TextEditingController();
  TextEditingController lng = TextEditingController();
  TextEditingController lat = TextEditingController();

  String _selectedCategory = 'Hospital';
  bool _isLoading = false;
  List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();


  Future<void> _pickedImages() async{
    try{
      if (_selectedImages.length >= 5) {
         ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You can upload up to 5 images only.")),
      );
      return;
      }
      final pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles != null) {
        setState(() {
          // _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));

          _selectedImages.addAll( pickedFiles.map((file) {
          // Use for Web
          return XFile(file.path); // File.path works as network source
        }),);
        });
      }
    }catch(e){
      print(e);
    }
  }

  final attractionService = AttractionService();
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
      _isLoading = true;
    });
    try{
      final prefs = await SharedPreferences.getInstance();
      String? cityId = await prefs.getString('cityId');
      await attractionService.createAttraction(
        name: name.text, 
        images: _selectedImages, 
        description: description.text, 
        category: _selectedCategory,
        cityId: cityId.toString(), 
        rating: int.parse(rating.text), 
        lng: double.parse(lng.text),
        lat: double.parse(lat.text),
        // closingTime: ,
        );
        setState(() {
          _isLoading = false;
        });
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Attraction added successfully!")),
        );
        _formKey.currentState!.reset();
        setState(() {
          _selectedImages = [];
          _isLoading = false;
        });
    }catch(e){
      setState(() {
        _isLoading = false;
      });
      print('error occured while adding attraction $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('add a list of attractions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey
              )
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextfieldWidget(
                    controller: name,
                    placeholder: 'Attraction name',
                    validator: (value){
                      if (value == null) {
                        return 'enter a name for the attraction';
                      }else if (value.length <= 2) {
                        return 'Name of attraction cannot be less than 3';
                      }
                      return null;
                    },
                  ),
                  TextfieldWidget(
                    controller: lng,
                    placeholder: 'longitude',
                    validator: (value){
                      if (value == null) {
                        return 'enter a longitude for the attraction';
                      }
                      // else if (value.length <= 2) {
                      //   return 'Name of attraction cannot be less than 3';
                      // }
                      return null;
                    },
                  ),
                 TextfieldWidget(
                    controller: lat,
                    placeholder: 'latitude',
                    validator: (value){
                      if (value == null) {
                        return 'enter a latitude for the attraction';
                      }
                      // else if (value.length <= 2) {
                      //   return 'Name of attraction cannot be less than 3';
                      // }
                      return null;
                    },
                  ),
                  TextfieldWidget(
                    controller: rating,
                    placeholder: 'Rating',
                    validator: (value){
                      if (value == null) {
                        return 'enter a name for the attraction';
                      }else if (value.length > 5) {
                        return 'Rating cannot be greater than 5';
                      }
                      return null;
                    },
                  ),
                  TextfieldWidget(
                    controller: description,
                    placeholder: 'attraction description',
                    validator: (value){
                      if (value == null) {
                        return 'enter a descrition for the attraction';
                      }else if (value.length <= 10) {
                        return 'Name of attraction cannot be less than 10 characters';
                      }
                      return null;
                    },
                  ),
                                  DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: const [
                    "Hospital",
                    "Business",
                    "Restaurant",
                    "Banks",
                    "Parks"
                  ] .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(), 
                  onChanged:  (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                  decoration: const InputDecoration(labelText: "Category"),
                ),
                TextButton.icon(
                  onPressed: _pickedImages,
                  icon: const Icon(Icons.add_a_photo),
                  label: const Text("Pick Images"),
                  style: const ButtonStyle(
                    backgroundColor: WidgetStateColor.transparent,
                  ),
                ),

                const SizedBox(height: 20,),
                        Wrap(
  spacing: 8.0,
  runSpacing: 8.0,
  children: _selectedImages
      .map((image) => Stack(
            children: [
              Image.network(
                image.path, // Use the path for Web
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImages.remove(image);
                    });
                  },
                  child: const Icon(Icons.cancel, color: Colors.red),
                ),
              ),
            ],
          ))
      .toList(),
),

    const SizedBox(height: 16.0),
                CustomButton(
                  onPressed: _submitForm,
                  buttonText: "Add City",
                   isLoading: _isLoading,
                ),
                ],
              ),  
            )
            )
          ]
        )
      )
    );
  }

  void _openDateTimePicker(BuildContext context) {
    BottomPicker.dateTime(
      pickerTitle: Text(
        'Set the event exact time and date',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      onSubmit: (date) {
        print(date);
      },
      onClose: () {
        print('Picker closed');
      },
      minDateTime: DateTime(2021, 5, 1),
      maxDateTime: DateTime(2021, 8, 2),
      initialDateTime: DateTime(2021, 5, 1),
      gradientColors: [
        Color(0xfffdcbf1),
        Color(0xffe6dee9),
      ],
    ).show(context);
  }
}