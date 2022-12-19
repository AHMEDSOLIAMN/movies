import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movies_application/controller/providers/movies_app_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesAppProvider>(
      builder: (context, controller, child) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.movie_creation_outlined,
              ),
              label: "Movies",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.tv,
              ),
              label: "Series",
            ),
          ],
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.black.withOpacity(0.2),
          elevation: 0,
          currentIndex: controller.currentIndex,
          onTap: (index) {
            controller.changeBottomNavBarItems(index);
          },
        ),
        body: controller.homeScreensList[controller.currentIndex],
      ),
    );
  }
}
