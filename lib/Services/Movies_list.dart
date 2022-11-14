import 'dart:convert';
import 'package:http/http.dart' as http;

class Movie_List {
  String? back_imgurl;
  String? imgUrl;
  String? name;
  String? date;
  String? genre;
  String? des;
  int? id;
  int? vote;
  Movie_List(this.imgUrl, this.name, this.date, this.genre, this.vote, this.des,
      this.id, this.back_imgurl);
}

Future getMovieListData(String type) async {
  List<Movie_List> allmovies = [];
  var response1 = await http.get(Uri.parse(
      "https://api.themoviedb.org/3/movie/$type?api_key=c62d03cc5058838982afddb016d84f54&language=en-US&page=1"));
  var jsonData1 = jsonDecode(response1.body);
  var jsonResult1 = jsonData1["results"];

  for (var u in jsonResult1) {
    allmovies.add(Movie_List(
        u["poster_path"],
        u["title"],
        u["release_date"],
        genres(u["genre_ids"][0]),
        star(u["vote_average"].toDouble()),
        u["overview"],
        u["id"],
        u["backdrop_path"]));
  }
  var response2 = await http.get(Uri.parse(
      "https://api.themoviedb.org/3/movie/$type?api_key=c62d03cc5058838982afddb016d84f54&language=en-US&page=2"));
  var jsonData2 = jsonDecode(response2.body);
  var jsonResult2 = jsonData2["results"];

  for (var u in jsonResult2) {
    allmovies.add(Movie_List(
        u["poster_path"],
        u["title"],
        u["release_date"],
        genres(u["genre_ids"][0]),
        star(u["vote_average"].toDouble()),
        u["overview"],
        u["id"],
        u["backdrop_path"]));
  }
  var response3 = await http.get(Uri.parse(
      "https://api.themoviedb.org/3/movie/$type?api_key=c62d03cc5058838982afddb016d84f54&language=en-US&page=3"));
  var jsonData3 = jsonDecode(response3.body);
  var jsonResult3 = jsonData3["results"];

  for (var u in jsonResult3) {
    allmovies.add(Movie_List(
        u["poster_path"],
        u["title"],
        u["release_date"],
        genres(u["genre_ids"][0]),
        star(u["vote_average"].toDouble()),
        u["overview"],
        u["id"],
        u["backdrop_path"]));
  }

  return allmovies;
}

int star(double vote) {
  int star;
  star = (vote / 2).round();
  return star;
}

String genres(int genre) {
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
