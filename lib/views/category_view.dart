import 'package:flutter/material.dart';
import 'package:news/helper/news.dart';
import 'package:news/models/article_modle.dart';

import 'article_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles=List<ArticleModel>();
  bool _loadingvar=true;
  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }
  getCategoryNews() async{
    CategoryNewsClass newsClass=CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles=newsClass.news;
    setState(() {
      _loadingvar=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("News",style: TextStyle(color: Colors.blue),),
            Text("App"),
          ],
        ),
        actions:<Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          )
        ],
        centerTitle: true,
      ),
      body:_loadingvar?Center(child: Container(child: CircularProgressIndicator(),),)
        :SingleChildScrollView(
          child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top:16,left: 16,right: 16),
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context,index){
                      return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url,
                      );
                    }),
              )
            ],
          ),
      ),
        ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl,title,desc,url;
  BlogTile({this.imageUrl,this.title,this.desc,this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(
            builder: (context)=>ArticleView(blogUrl: url,
            )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl),
            ),
            Text(title,style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 8,),
            Text(desc,style:TextStyle(
                color: Colors.black54
            ),),
          ],
        ),
      ),
    );
  }
}
