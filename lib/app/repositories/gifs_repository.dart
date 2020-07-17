import 'package:cubit_gifs/app/models/gif_model.dart';
import 'package:dio/dio.dart';

class GifsRepository {
  Future<List<GifModel>> getRandomGifs() async {
    try {
      final response = await Dio().get('https://api.giphy.com/v1/gifs/trending?api_key=7JVBVpjhlg8va2TCBLSXDk9S28MF4FG9&limit=25&rating=g');
      final result = response.data['data'];
      return result.map<GifModel>((g) => GifModel.fromMap(g)).toList();
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<GifModel>> searchGif(String value) async {
    try {
      final response = await Dio().get('https://api.giphy.com/v1/gifs/search?api_key=7JVBVpjhlg8va2TCBLSXDk9S28MF4FG9&q=$value&limit=25&offset=0&rating=g&lang=en');
      return response.data['data'].map<GifModel>((g) => GifModel.fromMap(g)).toList();
    } catch (e) {
      throw Exception();
    }
  }
}
