import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';


class TMDBRepository {

  String apiKey = '3a87326faf5bfe18650b116224c79235';
  String baseUrl = 'api.themoviedb.org';

  ///
  /// Get top rated persons
  ///
  Future<List<UserModel>> getTopRated({int page = 1}) async {

    final Map<String, String> params = {
      'api_key': apiKey,
      'page': page.toString() ?? '1'
    };

    final uri = Uri.https( baseUrl, '/3/person/popular', params );
    final response = await http.get(uri);

    if (response.statusCode == 200) {

      final data = json.decode( response.body );

      if (data.length > 0) {

        List<UserModel> users = [];

        data['results'].forEach((user) => users.add(UserModel.fromJson(user)) );

        return users;

      }

      return null;

    } else {
      throw Exception('Failed to load users');
    }

  }


}