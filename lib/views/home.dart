import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/helper/data.dart';
import 'package:news/helper/news.dart';
import 'package:news/models/article_modle.dart';
import 'package:news/models/category_model.dart';
import 'package:news/views/article_view.dart';
import 'package:news/views/category_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories=List<CategoryModel>();
  List<ArticleModel> articles=List<ArticleModel>();
  bool _loading=true;
  @override
  void initState() {
    super.initState();
    categories=getCategories();
    getNews();
  }
  getNews() async{
    News newsClass=News();
    await newsClass.getNews();
    articles=newsClass.news;
    setState(() {
      _loading=false;
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
      ),
      body: _loading?Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ):SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  },
                ),
              ),
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

class CategoryTile extends StatelessWidget {
  final String imageUrl,categoryName;
  CategoryTile({this.imageUrl,this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryNews(category: categoryName,)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(imageUrl:imageUrl,width: 120,height: 60,fit: BoxFit.cover,),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(6)
              ),
              child: Text(categoryName,style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500
              ),),
            )
          ],
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


