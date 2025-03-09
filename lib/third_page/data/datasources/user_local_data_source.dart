import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:suitmedia/third_page/data/models/user_model.dart';

import '../../../../core/error/excaption.dart';

const cacheAllUserKey = 'all_user';

abstract class UserLocalDataSource {
  Future<List<UserModel>>getAllUser();
  Future<bool> cachedAll(List<UserModel> list);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences pref;

  UserLocalDataSourceImpl({required this.pref});
  
  @override
  Future<bool> cachedAll(List<UserModel> list) async {
    List<Map<String, dynamic>> listMap = list.map((e) => e.toJson()).toList();
    String allUser = jsonEncode(listMap);
   return pref.setString(cacheAllUserKey, allUser);
  }
  
  @override
  Future<List<UserModel>> getAllUser() async {
   String? allUser = pref.getString(cacheAllUserKey);
    if(allUser != null) {
      List<Map<String, dynamic>> listMap = List<Map<String, dynamic>>.from(jsonDecode(allUser));
      List<UserModel> list =  listMap.map((e) => UserModel.fromJson(e)).toList();
      return list;
    } 
    throw CachedExcaption();
  }
}