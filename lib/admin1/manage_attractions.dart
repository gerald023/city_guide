import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../models/cities.dart';
import '../services/cloudinary_upload_service.dart';

class ManageAttractions extends StatelessWidget {
  final CollectionReference citiesCollection =
  FirebaseFirestore.instance.collection('Cities');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Cities and Attractions'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: citiesCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No cities found'));
          }

          final List<QueryDocumentSnapshot> cities = snapshot.data!.docs;

          return ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final cityData = cities[index].data() as Map<String, dynamic>;
              final cityId = cities[index].id;
              final city = CitiesModel.fromMap(cityData);

              return ExpansionTile(
                title: Text(city.cityName),
                subtitle: Text(city.country),
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: citiesCollection
                        .doc(cityId)
                        .collection('Attractions')
                        .snapshots(),
                    builder: (context, attractionsSnapshot) {
                      if (attractionsSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }

                      if (attractionsSnapshot.hasError) {
                        return const Center(
                            child: Text('Error fetching attractions'));
                      }

                      if (!attractionsSnapshot.hasData ||
                          attractionsSnapshot.data!.docs.isEmpty) {
                        return const Center(
                            child: Text('No attractions found'));
                      }

                      final attractions = attractionsSnapshot.data!.docs;

                      return Column(
                        children: attractions.map((attraction) {
                          final attractionData =
                          attraction.data() as Map<String, dynamic>;
                          final attractionId = attraction.id;

                          return ListTile(
                            title: Text(attractionData['name']),
                            trailing: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'edit') {
                                  _addOrEditAttraction(
                                      context,
                                      cityId,
                                      attractionId: attractionId,
                                      attractionData: attractionData);
                                } else if (value == 'delete') {
                                  _deleteAttraction(cityId, attractionId);
                                }
                              },
                              itemBuilder: (BuildContext context) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Edit Attraction'),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Text('Delete Attraction'),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Add New Attraction'),
                    leading: const Icon(Icons.add),
                    onTap: () {
                      _addOrEditAttraction(context, cityId);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _addOrEditAttraction(BuildContext context, String cityId,
      {String? attractionId, Map<String, dynamic>? attractionData}) async {
    final TextEditingController attractionNameController =
    TextEditingController(text: attractionData?['name'] ?? '');
    final TextEditingController longitudeController = TextEditingController(
        text: attractionData?['longitude']?.toString() ?? '');
    final TextEditingController latitudeController = TextEditingController(
        text: attractionData?['latitude']?.toString() ?? '');

    final ImagePicker picker = ImagePicker();
    XFile? selectedImage;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(attractionId == null ? 'Add New Attraction' : 'Edit Attraction'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: attractionNameController,
                  decoration: const InputDecoration(labelText: 'Attraction Name'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: longitudeController,
                  decoration: const InputDecoration(labelText: 'Longitude'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: latitudeController,
                  decoration: const InputDecoration(labelText: 'Latitude'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    selectedImage = await picker.pickImage(source: ImageSource.gallery);
                    if (selectedImage != null) {
                      print('Image selected: ${selectedImage!.path}');
                    } else {
                      print('No image selected');
                    }
                  },
                  child: const Text('Upload Image'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final attractionName = attractionNameController.text.trim();
                final longitude = double.tryParse(longitudeController.text.trim());
                final latitude = double.tryParse(latitudeController.text.trim());

                if (attractionName.isEmpty || longitude == null || latitude == null) {
                  print('Please fill in all fields with valid data');
                  return;
                }

                String? imageUrl;

                if (selectedImage != null) {
                  imageUrl = await CloudinaryUploadService().uploadImageToCloudinary(selectedImage!);
                }

                final attractionsCollection =
                citiesCollection.doc(cityId).collection('Attractions');

                if (attractionId == null) {
                  // Add new attraction
                  await attractionsCollection.add({
                    'name': attractionName,
                    'longitude': longitude,
                    'latitude': latitude,
                    'imageUrl': imageUrl,
                  });
                } else {
                  // Update existing attraction
                  await attractionsCollection.doc(attractionId).update({
                    'name': attractionName,
                    'longitude': longitude,
                    'latitude': latitude,
                    'imageUrl': imageUrl,
                  });
                }

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }



  Future<void> _deleteAttraction(String cityId, String attractionId) async {
    try {
      await citiesCollection
          .doc(cityId)
          .collection('Attractions')
          .doc(attractionId)
          .delete();
      print('Attraction deleted successfully');
    } catch (e) {
      print('Error deleting attraction: $e');
    }
  }
}
