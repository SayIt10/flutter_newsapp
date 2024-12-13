import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('token', token); 
  }

  Future<String?> getToken() async{
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('token');
    return data;
  }

  Future removeToken()async{
    final pref= await SharedPreferences.getInstance();
    await pref.remove('token');
  }
}