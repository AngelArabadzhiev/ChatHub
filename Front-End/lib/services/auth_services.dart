import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices extends ChangeNotifier{
  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  static late final SharedPreferences _prefs;

  Future<void> loginUser(String userName) async {
    try {
      _prefs.setString('userName', userName);
    } catch (e) {
      print(e);
    }
  }
  Future<bool> isLoggedIn()async{
    String? username = _prefs.getString('userName');
    if(username == null) return false;
    return true;
  }

  void logoutUser() {
    _prefs.clear();
  }

  String? getUsername(){
    return _prefs.getString('userName') ?? 'DefaultValue';
  }

  void updateUsername(String newName){
    _prefs.setString("UserName", newName);
    notifyListeners();
  }

}
