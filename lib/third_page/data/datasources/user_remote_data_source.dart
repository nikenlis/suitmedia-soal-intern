import 'dart:convert';

import '../../../../api/urls.dart';
import '../../../../core/error/excaption.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getAllUser(int page);
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> getAllUser(int page) async {
    Uri url = Uri.parse('${URLs.base}users?page=$page&per_page=6');

    final response = await client.get(url).timeout(const Duration(seconds: 3));
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body)['data'];
      return list.map((e) => UserModel.fromJson(Map.from(e))).toList();
    } else if (response.statusCode == 404) {
      Map body = jsonDecode(response.body);
      throw NotFoundExcaption(message: body['message']);
    } else {
      throw ServerExcaption();
    }
  }
}
