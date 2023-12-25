import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gitty/feature/home/presentation/views/posts_screen.dart';
import 'package:gitty/feature/home/presentation/views/todos_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentScreenIndex = 0;

  List<Widget> screens = [
    const PostsScreen(),
    const TodosScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int selectedIndex) {
          setState(() {
            currentScreenIndex = selectedIndex;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentScreenIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.circleCheck),
            label: 'Todos',
          ),
        ],
      ),
      body: screens[currentScreenIndex],
    );
  }
}
