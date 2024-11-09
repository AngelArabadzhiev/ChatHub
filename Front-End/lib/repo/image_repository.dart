import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../models/image_model.dart';

class ImageRepository {
  Future<List<UnsplashImage>> getNetworkImages() async {
    try {
      var endpointUrl = Uri.parse(
          'https://api.unsplash.com/photos/?client_id=aUPb9EHmEod9LI9ilYE_PJyOpa_lClOxqXOgKOweOEg&page=12');

      final response = await http.get(endpointUrl);

      if (response.statusCode == 200) {
        final List<dynamic> decodedList = jsonDecode(response.body) as List;

        final List<UnsplashImage> imageList = decodedList.map((listItem) {
          return UnsplashImage.fromJson(listItem);
        }).toList();
        return imageList;
      } else {
        throw Exception("API got cooked.");
      }
    } on SocketException{
      throw Exception("No internet conection");
    }on HttpException{
      throw Exception("Could'n retrive images");
    }on FormatException{
      throw Exception("Bad response format");
    }
    catch(e){
      throw Exception("Unknown error");
    }
  }
}
