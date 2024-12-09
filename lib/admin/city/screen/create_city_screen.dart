import 'dart:io';

import 'package:city_guide/components/custom_button.dart';
import 'package:city_guide/components/textField_widget.dart';
import 'package:city_guide/services/city_guide_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateCityScreen extends StatefulWidget {
  const CreateCityScreen({super.key});

  @override
  State<CreateCityScreen> createState() => _CreateCityScreenState();
}

class _CreateCityScreenState extends State<CreateCityScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityName = TextEditingController();
  final TextEditingController _rating = TextEditingController();
  final TextEditingController _country = TextEditingController();
  String _selectedCategory = 'Holiday';
  bool _isCityPopular = false;
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
  final cityService = CityGuideServices();
  Future<void> _submitForm()async{
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
      _isLoading = true;
    });
      try{
        
      String? cityId = await cityService.createCity(
        cityName: _cityName.text, 
        images: _selectedImages, 
        category: _selectedCategory, 
        country: _country.text, 
        rating: int.parse(_rating.text),
        isPopular: _isCityPopular
      );
        setState(() {
      _isLoading = false;
    });
       ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("City added successfully!")),
        );
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('cityId', cityId!);
        _formKey.currentState!.reset();
         setState(() {
          _selectedImages = [];
          _selectedCategory = "Holiday";
          _isCityPopular = false;
          _isLoading = false;
        });
        Get.toNamed('/add-attraction');
      }catch(e){
        setState(() {
      _isLoading = true;
    });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Add City'),
      ),
        body:  Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Fill the form to add a new city',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextfieldWidget(
                    controller: _cityName,
                    placeholder: 'City name',
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Please enter the city\'s name';
                      }else if(value.trim().length < 3){
                        return 'City\'s name cannot be less than 3 characters';
                      }
                      return null;
                    },
                    prefixIcon: const Icon(
                      Icons.location_city_rounded,
                      color: Colors.grey,
                      size: 21,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextfieldWidget(
                    controller: _rating,
                    placeholder: 'City rating (0-5)',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter rating";
                    }
                    int? rating = int.tryParse(value);
                    if (rating == null || rating < 0 || rating > 5) {
                      return "Enter a valid rating between 0 and 5";
                    }
                    return null;
                  },
                  prefixIcon: const Icon(
                    Icons.star_rate_rounded,
                    color: Colors.grey,
                    size: 21,
                  ),
                  ),
                  const SizedBox(height: 10,),
                TextfieldWidget(
                  controller: _country,
                  placeholder: 'Country',
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter country" : null,
                  prefixIcon: const Icon(
                    Icons.place,
                    color: Colors.grey,
                    size: 21,
                  ),
                ),
                const SizedBox(height: 18,),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: const [
                    "Holiday",
                    "Business",
                    "Adventure",
                    "Amusement",
                    "Pleasure"
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
                const SizedBox(height: 14,),
                 SwitchListTile(
                  title: const Text("Is Popular City"),
                  value: _isCityPopular,
                  onChanged: (value) {
                    setState(() {
                      _isCityPopular = value;
                    });
                  },
                ),
                   const SizedBox(height: 20,),
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
            ),
          ),
        ),
    );
  }
}