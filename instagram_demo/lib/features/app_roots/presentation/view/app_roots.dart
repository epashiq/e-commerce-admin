import 'package:flutter/material.dart';
import 'package:instagram_demo/features/home/presentation/view/add_post_page.dart';
import 'package:instagram_demo/features/home/presentation/view/favourite_screen.dart';
import 'package:instagram_demo/features/home/presentation/view/home_screen.dart';
import 'package:instagram_demo/features/home/presentation/view/profile_page.dart';
import 'package:instagram_demo/features/home/presentation/view/search_page.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const SearchPage(),
    const AddPostPage(),
    const FavouriteScreen(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            tooltip: "Home",
            icon: Image.asset('assets/images/home.png'),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/home.png'),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Image.asset('assets/images/search.png'), label: ''),
          BottomNavigationBarItem(
              icon: Image.asset('assets/images/add-post.png'), label: ''),
          BottomNavigationBarItem(
            tooltip: "Favourite",
            icon: const Icon(Icons.favorite_outline),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/favourite.png'),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Image.asset('assets/images/Oval.png'), label: ''),
        ],
      ),
    );
  }
}
