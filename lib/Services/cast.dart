import 'dart:convert';
import 'package:http/http.dart' as http;

class cast {
  String? profile_url;
  String? name;
  String? castId;
  cast(this.name, this.profile_url, this.castId);
}

Future getCastData(int id) async {
  List<cast> allcast = [];
  var response = await http.get(Uri.parse(
      "https://api.themoviedb.org/3/movie/$id/credits?api_key=c62d03cc5058838982afddb016d84f54&language=en-US"));
  var jsonData = jsonDecode(response.body);
  var jsonCast = jsonData["cast"];

  allcast.add(cast(jsonCast[0]["original_name"], jsonCast[0]["profile_path"],
      jsonCast[0]["credit_id"]));
  allcast.add(cast(jsonCast[1]["original_name"], jsonCast[1]["profile_path"],
      jsonCast[1]["credit_id"]));
  allcast.add(cast(jsonCast[2]["original_name"], jsonCast[2]["profile_path"],
      jsonCast[2]["credit_id"]));
  allcast.add(cast(jsonCast[3]["original_name"], jsonCast[3]["profile_path"],
      jsonCast[3]["credit_id"]));
  allcast.add(cast(jsonCast[4]["original_name"], jsonCast[4]["profile_path"],
      jsonCast[4]["credit_id"]));

  return allcast;
}
