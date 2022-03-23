import 'package:flutter/material.dart';

import 'package:maeth_demo/src/views/report/reports_view.dart';
import 'package:maeth_demo/src/views/user/user_profile_view.dart';
import 'package:maeth_demo/src/views/events/events_view.dart';
import 'package:maeth_demo/src/views/patient/patient_list_view.dart';
import 'package:maeth_demo/src/views/ui/home_view.dart';

class NavigationProvider with ChangeNotifier {
  final List<Widget> _nutritionistPages = [
    const HomeView(),
    const PatientListView(),
    const EventsView(),
    const UserProfileView(),
  ];

  final List<Widget> _patientPages = [
    const HomeView(),
    const ReportsView(),
    const EventsView(),
    const UserProfileView(),
  ];

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Widget get patientPage => _patientPages[_selectedIndex];
  Widget get nutritionistPage => _nutritionistPages[_selectedIndex];
}
