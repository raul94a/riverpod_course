import 'package:flutter/material.dart';
import 'package:riverpod_course_preview/presentation/screens/home/characters/characters_screen.dart';
import 'package:riverpod_course_preview/presentation/screens/home/episodes/episodes_screen.dart';
import 'package:riverpod_course_preview/presentation/screens/home/locations/locations_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;
  late PageController pageController = PageController(initialPage: page);
  final pages = [
    const CharactersScreen(),
    const EpisodesScreen(),
    const LocationsScreen()
  ];
  setPage(int index) => page = index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TextField()),
      body: PageView(
        controller: pageController,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        onTap: (indes) {
          print('set page: $indes');
          setState(() {
            setPage(indes);
            pageController.jumpToPage(indes);
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Characters'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Episodes'),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Locations'),
        ],
      ),
    );
  }
}
