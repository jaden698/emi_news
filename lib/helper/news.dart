import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/models/article_modle.dart';

class News{
  List<ArticleModel> news=[];
  Future<void> getNews() async{
    String url="http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=cb4d2aa5a6f14e09acc28a266e74d7f4";
    var response= await http.get(url);
    var jsonData=jsonDecode(response.body);
    if(jsonData['status']=="ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null&&element["description"]!=null){
          ArticleModel articleModel=ArticleModel(
            title: element["title"],
            author:element["author"],
            description: element["description"],
            url:element["url"],
            urlToImage: element["urlToImage"],
            content: element["context"]
          );
          news.add(articleModel);
        }
      });
    }
  }


}

class CategoryNewsClass{
  List<ArticleModel> news=[];
  Future<void> getNews(String category) async{
    String url="http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=cb4d2aa5a6f14e09acc28a266e74d7f4";
    var response= await http.get(url);
    var jsonData=jsonDecode(response.body);
    if(jsonData['status']=="ok"){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null&&element["description"]!=null){
          ArticleModel articleModel=ArticleModel(
              title: element["title"],
              author:element["author"],
              description: element["description"],
              url:element["url"],
              urlToImage: element["urlToImage"],
              content: element["context"]
          );
          news.add(articleModel);
        }
      });
    }
  }
}