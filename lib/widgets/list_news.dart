import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/NewsResponse.dart';
import 'package:news_app/theme/tema.dart';

class ListNews extends StatelessWidget {
  
  final List<Article> noticias; 
  
  const ListNews({required this.noticias});


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (context, indice){
        return _ItemArticle(noticia: noticias[indice], indice: indice);
      }
    );
  }
}

class _ItemArticle extends StatelessWidget {
  
  final Article noticia;
  final int indice;

  const _ItemArticle({Key? key, required this.noticia, required this.indice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(
          indice: indice,
          noticia: noticia,
        ),

        _TarjetaNoticia(
          noticia: noticia,
        ),

        _TarjetaImagen(
          noticia: noticia
        ),

        _TarjetaBody(
          noticia: noticia
        ),

        const _TarjetaBotones(),

        const SizedBox(height: 10,),
        const Divider()
      ],
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {

  final Article noticia;
  final int indice;

  const _TarjetaTopBar({
    Key? key, 
    required this.noticia,
    required this.indice}) : super(key: key); 

  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text('${indice+1}', style: TextStyle( color: miTema.colorScheme.secondary ),),
          const Text(' '),
          Text(noticia.source.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}


class _TarjetaNoticia extends StatelessWidget {

  final Article noticia;

  const _TarjetaNoticia({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Text( noticia.title ?? 'Sin titulo' ),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {

  final Article noticia;
  const _TarjetaImagen({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
          child: noticia.urlToImage != null 
            ? noticia.urlToImage!.startsWith('http') ? FadeInImage(
              placeholder: const AssetImage('assets/giphy.gif'), 
              image: NetworkImage(noticia.urlToImage!))
              :const Image(image: AssetImage('assets/no-image.png'),)
            : const Image(image: AssetImage('assets/no-image.png'),)
        ),
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;
  const _TarjetaBody({Key? key, required this.noticia}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text( noticia.description ?? 'sin contenido'),
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  const _TarjetaBotones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: (){},
            fillColor: miTema.errorColor,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),
            child: const Icon( Icons.star_border ),
          ),

          const SizedBox(width: 10,),

          RawMaterialButton(
            onPressed: (){},
            fillColor: miTema.hintColor,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20) ),
            child: const Icon( Icons.more ),
          )
        ],
      ),
    );
  }
}