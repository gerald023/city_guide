import 'package:city_guide/services/city_guide_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: Icons.person_2_outlined,
              press: () => {},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: Icons.notification_add_outlined,
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: Iconsax.setting_2,
              press: () {},
            ),
            ProfileMenu(
              text: "FAQs",
              icon: Iconsax.message_question,
              press: () {

              },
            ),
             ProfileMenu(
              text: "Rating",
              icon: Iconsax.star,
              press: () {
                Get.toNamed('/rating');
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: Iconsax.logout,
              color: Colors.red,
              press: () {
                showLogoutModal(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
void showLogoutModal(BuildContext context){
  showDialog(
    context: context, 
    builder: (BuildContext context){
      return  AlertDialog(
      title: const Text('Log out'),
      content: const Text('Are you sure you want to Log out?'),
      actions: [
        TextButton(
          onPressed: (){
             Navigator.of(context).pop();
          }, 
          child: const Text('No',
            style: TextStyle(
              color: Colors.green
            ),
          )
          ),
          TextButton(
            onPressed: ()async{
              await CityGuideServices().signOut();
               Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully!')),
                );
                Get.offNamed('/login');
            }, 
            child: const Text('Yes',
              style: TextStyle(
                color: Colors.red
              ),
            )
            )
      ],
      );
    }
  );
}
class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String _selectedImagePath = '';

  Future<void> _pickImage(ImageSource source) async{
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      print('picked file path: ${pickedFile.path}');
      print('picked file name: ${pickedFile.name}');

      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No image selected')
        )
      );
    }
  }

  void _showImagePickerOption(BuildContext context){
    showModalBottomSheet(
      context: context, 
      builder: (BuildContext context){
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Select from gallery'),
              onTap: (){
                _pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Take a photo'),
              onTap: (){
                _pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
            ]
          )
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            backgroundImage:
                NetworkImage("https://i.postimg.cc/yY2bNrmd/Image-Banner-2.png"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  _showImagePickerOption(context);
                },
                child: SvgPicture.string(cameraIcon),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
             this.color,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Color? color;
  
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor:color ?? const Color.fromARGB(255, 66, 133, 115),
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            // SvgPicture.asset(
            //   icon,
            //   colorFilter:
            //       const ColorFilter.mode(Color(0xFFFF7643), BlendMode.srcIn),
            //   width: 22,
            // ),
             Icon(
              icon,
              color: color ?? const Color(0xff579f8c),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF757575),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF757575),
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}

const cameraIcon =
    '''<svg width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M10 12.0152C8.49151 12.0152 7.26415 10.8137 7.26415 9.33902C7.26415 7.86342 8.49151 6.6619 10 6.6619C11.5085 6.6619 12.7358 7.86342 12.7358 9.33902C12.7358 10.8137 11.5085 12.0152 10 12.0152ZM10 5.55543C7.86698 5.55543 6.13208 7.25251 6.13208 9.33902C6.13208 11.4246 7.86698 13.1217 10 13.1217C12.133 13.1217 13.8679 11.4246 13.8679 9.33902C13.8679 7.25251 12.133 5.55543 10 5.55543ZM18.8679 13.3967C18.8679 14.2226 18.1811 14.8935 17.3368 14.8935H2.66321C1.81887 14.8935 1.13208 14.2226 1.13208 13.3967V5.42346C1.13208 4.59845 1.81887 3.92664 2.66321 3.92664H4.75C5.42453 3.92664 6.03396 3.50952 6.26604 2.88753L6.81321 1.41746C6.88113 1.23198 7.06415 1.10739 7.26604 1.10739H12.734C12.9358 1.10739 13.1189 1.23198 13.1877 1.41839L13.734 2.88845C13.966 3.50952 14.5755 3.92664 15.25 3.92664H17.3368C18.1811 3.92664 18.8679 4.59845 18.8679 5.42346V13.3967ZM17.3368 2.82016H15.25C15.0491 2.82016 14.867 2.69466 14.7972 2.50917L14.2519 1.04003C14.0217 0.418041 13.4113 0 12.734 0H7.26604C6.58868 0 5.9783 0.418041 5.74906 1.0391L5.20283 2.50825C5.13302 2.69466 4.95094 2.82016 4.75 2.82016H2.66321C1.19434 2.82016 0 3.98846 0 5.42346V13.3967C0 14.8326 1.19434 16 2.66321 16H17.3368C18.8057 16 20 14.8326 20 13.3967V5.42346C20 3.98846 18.8057 2.82016 17.3368 2.82016Z" fill="#757575"/>
</svg>
''';
