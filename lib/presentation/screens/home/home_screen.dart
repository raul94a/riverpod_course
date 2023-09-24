import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/presentation/screens/home/characters/characters_screen.dart';
import 'package:riverpod_course_preview/presentation/screens/home/characters/controller/characters_controller.dart';
import 'package:riverpod_course_preview/presentation/screens/home/episodes/episodes_screen.dart';
import 'package:riverpod_course_preview/presentation/screens/home/locations/locations_screen.dart';
import 'package:riverpod_course_preview/presentation/shared/controllers/theme_controller.dart';
import 'package:riverpod_course_preview/presentation/styles/colors.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int page = 0;
  Timer? timer;
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
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Consumer(builder: (ctx, ref, _) {
                final lightTheme = ref.watch(themeProvider).light;
                final icon =
                    Icon(lightTheme ? Icons.light_mode : Icons.dark_mode);
                final text = lightTheme ? 'Light Mode' : 'Dark mode';
                return GestureDetector(
                  onTap: () {
                    ref.read(themeProvider).changeStatus();
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.0).copyWith(top: 50.0),
                    child: Row(
                      children: [
                        icon,
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          text,
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: TextField(
              controller: textFieldController,
              decoration: _textFieldDecoration(),
              onChanged: (value) {
                timer?.cancel();
                timer = Timer(const Duration(milliseconds: 600), () {
                  switch (page) {
                    case 0:
                      ref.read(charactersProvider.notifier).search(value);
                      break;
                    case 1:
                      break;
                    default:
                      break;
                  }
                });
              },
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          StatusSelector(
              onChanged: (value) => ref
                  .read(charactersProvider.notifier)
                  .changeFilterStatus(value ?? 'All'))
        ],
      )),
      body: PageView(
        controller: pageController,
        onPageChanged: setPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        onTap: (index) {
          print('set page: $index');
          setPage(index);
          pageController.jumpToPage(index);
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

class StatusSelector extends StatelessWidget {
  const StatusSelector({super.key, required this.onChanged});
  final Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 40,
      child: DropdownButtonFormField<String>(
          isExpanded: true,
          dropdownColor: lightColorScheme.primary,
          style: TextStyle(color: lightColorScheme.primary),
          value: 'All',
          items: ['All', 'Alive', 'Dead', 'unknown']
              .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(
                      e,
                      style: TextStyle(color: lightColorScheme.onPrimary),
                    ),
                  ))
              .toList(),
          onChanged: onChanged),
    );
  }
}
