import 'package:movieapp/get.dart';
import 'package:http/http.dart' as http;

class RemoteService
{
  Future<Get?> getGets(String k) async {
    var client = http.Client();

    var uri = Uri.parse(k);
    var response = await client.get(uri);
    if(response.statusCode == 200)
      {
        var json = response.body;
        return getFromJson(json);
      }
  }

}