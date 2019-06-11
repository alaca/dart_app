import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../models/movie_model.dart';


String apiKey = '3a87326faf5bfe18650b116224c79235';
String baseUrl = 'api.themoviedb.org';

class TmdbApiProvider{

  Future<List<UserModel>> getPopular({int page = 1}) async {

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

    }

    throw Exception('Failed to load users');

  }


  Future<List<MovieModel>> getMovies({int page = 1}) async {

    final Map<String, String> params = {
      'api_key': apiKey,
      'page': page.toString() ?? '1'
    };

    final uri = Uri.https( baseUrl, '/3/movie/popular', params );
    final response = await http.get(uri);

    if (response.statusCode == 200) {

      final data = json.decode( response.body );

      if (data.length > 0) {

        List<MovieModel> movies = [];
        data['results'].forEach((movie) => movies.add(MovieModel.fromJson(movie)) );
        return movies;

      }

      return null;

    }

    throw Exception('Failed to load users');

  }



  Future<UserModel> getUser(int id) async {

    final Map<String, String> params = {
      'api_key': apiKey,
      'person_id': id.toString()
    };

    final uri = Uri.https( baseUrl, '/3/person/id', params );
    final response = await http.get(uri);

    if (response.statusCode == 200) {

      final data = json.decode( response.body );

      if (data.length > 0) {
        UserModel user = UserModel.fromJson(data);
        return user;
      }

    }

    throw Exception('Failed to load user $id');

  }

}