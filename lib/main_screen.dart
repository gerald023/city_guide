import 'package:city_guide/main.dart';
import 'package:city_guide/screens/account/screens/account_screen.dart';
import 'package:city_guide/screens/explore/screens/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:city_guide/constants/color_constant.dart';
import 'package:iconsax/iconsax.dart';
import 'package:city_guide/screens/home/screens/home_screen.dart';
import 'package:city_guide/screens/unboarding/screens/onboarding_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  int activeIndex = 0;
   final List<Widget> _pages = [
    const HomeScreen(),
    const OnboardingScreen(),
    const NewExplore(),
    // const ExploreScreen(),
     const ProfileScreen(),
    //  LoginScreen(),
    const UploadToFirestore(),
    
  ];
  final PageController _pageController = PageController();
  List<IconData> icons = [
    Iconsax.home5,
    Iconsax.heart5,
    Iconsax.calendar5,
    Iconsax.personalcard4,
    Iconsax.setting5
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: List.generate(_pages.length, (i){
          return _pages[i];
        })
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        elevation: 0,
        iconSize: 28,
        selectedItemColor: kBannerColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:  const TextStyle(
          color: kBannerColor, 
          fontWeight: FontWeight.w600
          ),
          unselectedLabelStyle: const TextStyle(
          fontSize: 14, 
          fontWeight: FontWeight.w500
          ),
        onTap: (index){
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          // setState(() {
          //   _currentIndex = index;
          // });
        },
        items: [
          BottomNavigationBarItem(
      icon: Icon(
        _currentIndex == 0 ? Iconsax.home5 : Iconsax.home_1
      ),
      label: 'Home'
      
    ),
     BottomNavigationBarItem(
      icon: Icon(
        _currentIndex == 1 ? Iconsax.heart5 : Iconsax.heart
      ),
      label: 'Favorite'
      
    ),
     BottomNavigationBarItem(
      icon: Icon(
        _currentIndex == 2 ? Iconsax.search_normal_14 : Iconsax.search_normal
      ),
      label: 'Explore'
      
    ),
     BottomNavigationBarItem(
      icon: Icon(
        _currentIndex == 3 ? Iconsax.personalcard5 : Iconsax.personalcard
      ),
      label: 'Profile'
      
    ),
     BottomNavigationBarItem(
      icon: Icon(
        _currentIndex == 4 ? Iconsax.setting : Iconsax.setting_2
      ),
      label: 'Setting'
      
    ),
    
        ]
      ),
    );
  }
   

}


