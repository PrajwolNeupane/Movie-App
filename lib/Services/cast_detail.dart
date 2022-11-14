import 'dart:convert';
import 'package:http/http.dart' as http;

class cast_detail {
  String? name;
  double? popularity;
  String? imgUrl;
  String? gender;
  String? job;
  List? movies_title;
  List? movies_imgurl;
  List? release_date;
  List? des;
  List? vote;
  List? movie_id;
  List? moviesback_imgurl;
  List? genre;
  cast_detail(
    this.name,
    this.popularity,
    this.imgUrl,
    this.gender,
    this.job,
    this.movies_title,
    this.movies_imgurl,
    this.release_date,
    this.des,
    this.vote,
    this.movie_id,
    this.moviesback_imgurl,
    this.genre,
  );
}

Future getCast_Detail(String cast_id) async {
  List<cast_detail> all_CastDetail = [];
  var response = await http.get(Uri.parse(
      "https://api.themoviedb.org/3/credit/$cast_id?api_key=c62d03cc5058838982afddb016d84f54"));
  var jsonData = jsonDecode(response.body);
  var jsonPerson = jsonData["person"];
  all_CastDetail.add(cast_detail(
    jsonPerson["name"],
    jsonPerson["popularity"],
    jsonPerson["profile_path"],
    formate(jsonPerson["gender"]),
    jsonData["job"],
    [
      jsonPerson["known_for"][0]["original_title"] == null
          ? jsonPerson["known_for"][0]["original_name"]
          : jsonPerson["known_for"][0]["original_title"],
      jsonPerson["known_for"][1]["original_title"] == null
          ? jsonPerson["known_for"][1]["original_name"]
          : jsonPerson["known_for"][1]["original_title"],
      jsonPerson["known_for"][2]["original_title"] == null
          ? jsonPerson["known_for"][2]["original_name"]
          : jsonPerson["known_for"][2]["original_title"],
    ],
    [
      jsonPerson["known_for"][0]["poster_path"],
      jsonPerson["known_for"][1]["poster_path"],
      jsonPerson["known_for"][2]["poster_path"]
    ],
    [
      jsonPerson["known_for"][0]["release_date"],
      jsonPerson["known_for"][1]["release_date"],
      jsonPerson["known_for"][2]["release_date"]
    ],
    [
      jsonPerson["known_for"][0]["overview"],
      jsonPerson["known_for"][1]["overview"],
      jsonPerson["known_for"][2]["overview"],
    ],
    [
      star(jsonPerson["known_for"][0]["vote_average"].toDouble()),
      star(jsonPerson["known_for"][1]["vote_average"].toDouble()),
      star(jsonPerson["known_for"][2]["vote_average"].toDouble()),
    ],
    [
      jsonPerson["known_for"][0]["id"],
      jsonPerson["known_for"][1]["id"],
      jsonPerson["known_for"][2]["id"],
    ],
    [
      jsonPerson["known_for"][0]["backdrop_path"],
      jsonPerson["known_for"][1]["backdrop_path"],
      jsonPerson["known_for"][2]["backdrop_path"],
    ],
    [
      genres(jsonPerson["known_for"][0]["genre_ids"][0].toDouble()),
      genres(jsonPerson["known_for"][1]["genre_ids"][0].toDouble()),
      genres(jsonPerson["known_for"][2]["genre_ids"][0].toDouble()),
    ],
  ));
  return all_CastDetail;
}

String formate(int value) {
  if (value == 2) {
    return "Male";
  } else if (value == 1) {
    return "Female";
  } else {
    return "Gay";
  }
}

int star(double vote) {
  int star;
  star = (vote / 2).round();
  return star;
}

String genres(double genre) {
  if (genre == 28) {
    return "Action";
  } else if (genre == 12) {
    return "Adventure";
  } else if (genre == 16) {
    return "Animation";
  } else if (genre == 35) {
    return "Comedy";
  } else if (genre == 80) {
    return "Crime";
  } else if (genre == 99) {
    return "Documentary";
  } else if (genre == 18) {
    return "Drama";
  } else if (genre == 10751) {
    return "Family";
  } else if (genre == 14) {
    return "Fantasy";
  } else if (genre == 36) {
    return "History";
  } else if (genre == 27) {
    return "Horror";
  } else if (genre == 10402) {
    return "Music";
  } else if (genre == 9648) {
    return "Mystery";
  } else if (genre == 10749) {
    return "Romance";
  } else if (genre == 878) {
    return "Science Fiction";
  } else if (genre == 10770) {
    return "TV Movie";
  } else if (genre == 53) {
    return "Thriller";
  } else if (genre == 10752) {
    return "War";
  } else if (genre == 37) {
    return "Western";
  } else {
    return "Error in Genre";
  }
}
