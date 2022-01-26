import 'package:flutter/material.dart';
import 'package:news_app/models/NewsResponse.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/category_model.dart';

class NewsService with ChangeNotifier{

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) {
    notifyListeners();
    _isLoading = isLoading;
  }

  List<Article> headlines = [];

  String _selectedCategory = 'business';

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String selectedCategory) {
    _selectedCategory = selectedCategory;
    getArticlesByCategory(selectedCategory);
    notifyListeners();
  }

  List<Article>get getArticulosCategoriaSeleccionada =>categoryArticles[selectedCategory] ?? [];

  List<Category> categories = [
    Category( Icons.business_center_outlined, 'business' ),
    Category( Icons.tv, 'entertainment' ),
    Category( Icons.all_inclusive_rounded, 'general' ),
    Category( Icons.health_and_safety, 'health' ),
    Category( Icons.science, 'science' ),
    Category( Icons.sports_volleyball, 'sports' ),
    Category( Icons.memory, 'technology' ),
  ];


  Map<String,List<Article>> categoryArticles = {};

  final _URL_NEWS = 'https://newsapi.org/v2/';
  final _API_KEY = 'b8756d862fcf4f70ba371dadb47590f4';

  NewsService(){
    getTopHeadlines();

    for (var element in categories) { 
      categoryArticles[element.name] = [];
    }
     
    getArticlesByCategory(selectedCategory);
  }

  getTopHeadlines() async{
    
    final url = '$_URL_NEWS/top-headlines?country=mx&apiKey=$_API_KEY';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = NewsResponse.fromJson(resp.body);

    headlines.addAll( newsResponse.articles );
    notifyListeners();

  }


  getArticlesByCategory(String category)async{

    if(categoryArticles[category]!.isNotEmpty ){
      notifyListeners();
      return categoryArticles[category];
    }

    isLoading = true;
    notifyListeners();

    final url = '$_URL_NEWS/top-headlines?country=mx&apiKey=$_API_KEY&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = NewsResponse.fromJson(resp.body);
    
    categoryArticles[category]?.addAll( newsResponse.articles );

    isLoading = false;
    notifyListeners();
  }

}