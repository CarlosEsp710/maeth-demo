import 'package:flutter/material.dart';

import 'package:maeth_demo/src/schemas/user_schema.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User? _myNutritionist;

  User get user => _user!;
  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  User? get myNutritionist => _myNutritionist;
  set myNutritionist(User? user) {
    _myNutritionist = user;
    notifyListeners();
  }
}
