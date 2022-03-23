import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:maeth_demo/src/providers/navigation_provider.dart';
import 'package:maeth_demo/src/providers/user_provider.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    var page = Provider.of<NavigationProvider>(context);

    return Scaffold(
      body: (user.userType == 'Paciente')
          ? page.patientPage
          : page.nutritionistPage,
      bottomNavigationBar: const _BottomBar(),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    var navigator = Provider.of<NavigationProvider>(context);

    return SalomonBottomBar(
      currentIndex: navigator.selectedIndex,
      onTap: (i) => navigator.selectedIndex = i,
      items: [
        SalomonBottomBarItem(
          icon: const Icon(Icons.home),
          title: const Text("Home"),
          selectedColor: Colors.purple,
        ),
        (user.userType == 'Paciente')
            ? SalomonBottomBarItem(
                icon: const Icon(Icons.medical_services_outlined),
                title: const Text("Nutrition"),
                selectedColor: Colors.pink,
              )
            : SalomonBottomBarItem(
                icon: const Icon(Icons.list),
                title: const Text("Pacientes"),
                selectedColor: Colors.pink,
              ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.calendar_today_outlined),
          title: const Text("Events"),
          selectedColor: Colors.orange,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.person),
          title: const Text("Profile"),
          selectedColor: Colors.teal,
        ),
      ],
    );
  }
}
