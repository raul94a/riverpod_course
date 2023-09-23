import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/presentation/screens/home/characters/characters_screen.dart';
import 'package:riverpod_course_preview/presentation/screens/home/characters/controller/characters_controller.dart';
import 'package:riverpod_course_preview/presentation/screens/home/episodes/episodes_screen.dart';
import 'package:riverpod_course_preview/presentation/screens/home/locations/locations_screen.dart';
import 'package:riverpod_course_preview/presentation/styles/colors.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int page = 0;
  late PageController pageController = PageController(initialPage: page);
  final pages = [
    const CharactersScreen(),
    const EpisodesScreen(),
    const LocationsScreen()
  ];
  final textFieldController = TextEditingController();

  setPage(int index) => setState(() {
        page = index;
        textFieldController.clear();
      });
  String hintText() {
    switch (page) {
      case 0:
        return 'Search a character';
      case 1:
        return 'Search an episode';
      default:
        return 'Search a location';
    }
  }

  @override
  void dispose() {
    textFieldController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextField(
        controller: textFieldController,
        decoration: _textFieldDecoration(),
        onChanged: (value) {
          switch (page) {
            case 0:
              ref.read(charactersProvider.notifier).search(value);
              break;
            case 1:
              break;
            default:
              break;
          }
        },
      )),
      body: PageView(
        controller: pageController,
        onPageChanged: setPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        onTap: (indes) {
          print('set page: $indes');
          setPage(indes);
          pageController.jumpToPage(indes);
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

  InputDecoration _textFieldDecoration() {
    return InputDecoration(
        hintText: hintText(),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
                color: lightColorScheme.onPrimaryContainer, width: 0)),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
                color: lightColorScheme.onPrimaryContainer, width: 1)),
        constraints: const BoxConstraints.tightFor(height: 40),
        contentPadding: EdgeInsets.zero,
        filled: true,
        prefixIcon: const Icon(
          Icons.search,
          size: 25,
        ));
  }
}
