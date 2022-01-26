import 'package:flutter/material.dart';
import 'package:news_app/models/NewsResponse.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/widgets/list_news.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);
    

    return SafeArea(
      child: Scaffold(
        body:  Column(
          children: [
            const _ListaCategorias(),
            
            newsService.isLoading 
            ? const CircularProgressIndicator()
            : Expanded(child: ListNews(noticias: newsService.getArticulosCategoriaSeleccionada ))
          ],
        )
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  const _ListaCategorias({
    Key? key,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, indice){
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(categoria: categories[indice]),
                const SizedBox(height: 5,),
                Text(categories[indice].name.replaceFirst(categories[indice].name[0], categories[indice].name[0].toUpperCase()))
              ],
            )
          );
        }
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    Key? key,
    required this.categoria,
  }) : super(key: key);

  final Category categoria;

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: (){
        //print( categoria.name );
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;

      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: Icon( categoria.icon, color: newsService.selectedCategory == categoria.name ? Colors.red : Colors.black54,),
      ),
    );
  }
}